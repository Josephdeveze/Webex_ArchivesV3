import sys
import subprocess
import requests
import os
import json
import importlib.util
from pathlib import Path
from PyQt6.QtWidgets import (
    QApplication, QWidget, QVBoxLayout, QHBoxLayout, QPushButton, 
    QLineEdit, QLabel, QListWidget, QListWidgetItem, QProgressBar,
    QTextEdit, QComboBox, QSpinBox, QCheckBox, QGroupBox, QTabWidget,
    QMessageBox, QRadioButton, QFileDialog, QSplitter
)
from PyQt6.QtCore import Qt, QThread, pyqtSignal
from PyQt6.QtGui import QFont, QIcon


class ArchiveWorker(QThread):
    """Thread worker pour exécuter l'archivage sans bloquer l'interface"""
    progress = pyqtSignal(int, int)
    log = pyqtSignal(str)
    finished = pyqtSignal()
    error = pyqtSignal(str)

    def __init__(self, script_path, room_ids, config_filename):
        super().__init__()
        self.script_path = script_path
        self.room_ids = room_ids
        self.config_filename = config_filename
        self._is_running = True

    def run(self):
        total = len(self.room_ids)
        
        # Déterminer le répertoire de l'application
        if getattr(sys, 'frozen', False):
            # Si l'application est compilée (frozen)
            if sys.platform == "darwin":  # macOS
                # Pour les applications .app sur macOS, aller au niveau du .app
                app_path = sys.executable
                # Remonter de Contents/MacOS/ vers le dossier contenant le .app
                app_dir = os.path.dirname(os.path.dirname(os.path.dirname(app_path)))
            else:
                # Pour Windows et Linux
                app_dir = os.path.dirname(sys.executable)
        else:
            # Si l'application est exécutée depuis le code source
            app_dir = os.path.dirname(os.path.abspath(__file__))
        
        # Créer un dossier "Webex Archives" à côté de l'exécutable
        output_dir = os.path.join(app_dir, "Webex Archives")
        os.makedirs(output_dir, exist_ok=True)
        
        self.log.emit(f"📂 Dossier de sortie: {output_dir}")
        
        # Sauvegarder le répertoire de travail actuel
        original_cwd = os.getcwd()
        script_dir = os.path.dirname(self.script_path)

        # Préparer un dossier externe et inscriptible pour le fichier de configuration
        external_webex_dir = os.path.join(app_dir, "Webex Archive")
        os.makedirs(external_webex_dir, exist_ok=True)

        # Copier une config par défaut vers l'emplacement externe si absente
        try:
            internal_config_path = os.path.join(script_dir, self.config_filename)
            external_config_path = os.path.join(external_webex_dir, self.config_filename)
            if os.path.exists(internal_config_path) and not os.path.exists(external_config_path):
                import shutil
                shutil.copyfile(internal_config_path, external_config_path)
        except Exception as _e:
            # En cas d'échec, le script générera une config vide côté externe
            pass
        
        for i, room_id in enumerate(self.room_ids):
            if not self._is_running:
                self.log.emit("❌ Archivage annulé par l'utilisateur")
                break
            
            try:
                self.log.emit(f"\n📦 Archivage de l'espace {i+1}/{total}...")
                self.log.emit(f"   ID: {room_id}")
                
                # Définir le répertoire de sortie via os.environ
                os.environ['OUTPUT_DIR'] = output_dir
                
                # Se placer dans le dossier externe pour que './config.ini' pointe vers un chemin inscriptible
                os.chdir(external_webex_dir)
                
                # Sauvegarder les arguments originaux
                original_argv = sys.argv.copy()
                
                # Configurer les arguments pour le script
                # Passer un chemin RELATIF (juste le nom du fichier) pour éviter les constructions './C:\\...'
                # Le CWD a été changé vers external_webex_dir ci-dessus
                # Toujours passer uniquement le nom du fichier; CWD est le dossier externe inscriptible
                config_arg = self.config_filename
                
                sys.argv = [os.path.basename(self.script_path), room_id, config_arg]
                
                # Charger et exécuter le script comme un module
                spec = importlib.util.spec_from_file_location("webex_archive_module", self.script_path)
                if spec and spec.loader:
                    module = importlib.util.module_from_spec(spec)
                    
                    # Ajouter exit comme alias de sys.exit dans le namespace du module
                    module.__dict__['exit'] = sys.exit
                    module.__dict__['quit'] = sys.exit
                    
                    # Rediriger stdout pour capturer les logs
                    import io
                    old_stdout = sys.stdout
                    sys.stdout = io.StringIO()
                    
                    try:
                        spec.loader.exec_module(module)
                        
                        # Récupérer les logs
                        output = sys.stdout.getvalue()
                        for line in output.split('\n'):
                            if line.strip():
                                self.log.emit(f"   {line.strip()}")
                        
                        self.log.emit(f"✅ Espace {i+1}/{total} archivé avec succès")
                    except SystemExit:
                        # Le script a appelé exit(), c'est normal
                        output = sys.stdout.getvalue()
                        for line in output.split('\n'):
                            if line.strip():
                                self.log.emit(f"   {line.strip()}")
                        self.log.emit(f"✅ Espace {i+1}/{total} archivé avec succès")
                    except Exception as e:
                        self.log.emit(f"⚠️ Erreur lors de l'archivage: {str(e)}")
                        import traceback
                        self.log.emit(f"   Détails: {traceback.format_exc()}")
                    finally:
                        # Restaurer stdout
                        sys.stdout = old_stdout
                        # Restaurer les arguments
                        sys.argv = original_argv
                else:
                    self.log.emit(f"❌ Impossible de charger le script d'archivage")
                
                self.progress.emit(i + 1, total)
                
            except Exception as e:
                self.log.emit(f"❌ Erreur: {str(e)}")
                self.error.emit(str(e))
            finally:
                # Restaurer le répertoire de travail
                os.chdir(original_cwd)
        
        self.log.emit(f"\n📁 Les archives sont disponibles dans: {output_dir}")
        self.finished.emit()

    def stop(self):
        self._is_running = False


class WebexArchiverGUI(QWidget):
    def __init__(self):
        super().__init__()
        self.setWindowTitle("Webex Archive - Interface Graphique")
        self.resize(1000, 700)
        
        # Chemins relatifs (portable pour tous les utilisateurs)
        # Gérer correctement les applications compilées (frozen)
        if getattr(sys, 'frozen', False):
            # Application compilée avec cx_Freeze ou PyInstaller
            application_path = Path(sys.executable).parent
        else:
            # Application en mode développement
            application_path = Path(__file__).parent
        
        self.base_dir = application_path / "Webex Archive"
        self.archive_script = self.base_dir / "webex-space-archive.py"
        self.config_file = self.base_dir / "webexspacearchive-config.ini"
        self.settings_file = application_path / ".webex_gui_settings.json"
        
        self.rooms_data = []
        self.worker = None
        
        # Créer la configuration par défaut si elle n'existe pas
        self.ensure_config_exists()
        
        self.init_ui()
        self.load_settings()

    def ensure_config_exists(self):
        """Créer le fichier de configuration avec des valeurs par défaut"""
        if not self.config_file.exists():
            try:
                import configparser
                config = configparser.ConfigParser()
                config.optionxform = str
                config.add_section('Archive Settings')
                
                config.set('Archive Settings', 'mytoken', '__YOUR_TOKEN_HERE__')
                config.set('Archive Settings', 'myspaceid', '__YOUR_SPACE_ID_HERE__')
                config.set('Archive Settings', 'download', 'no')
                config.set('Archive Settings', 'useravatar', 'no')
                config.set('Archive Settings', 'limit_type', 'messages')
                config.set('Archive Settings', 'maxTotalMessages', '1000')
                config.set('Archive Settings', 'time_limit_value', '30')
                config.set('Archive Settings', 'time_limit_unit', 'jours')
                config.set('Archive Settings', 'outputfilename', '')
                config.set('Archive Settings', 'sortoldnew', 'yes')
                config.set('Archive Settings', 'outputjson', 'no')
                config.set('Archive Settings', 'dst_start', '')
                config.set('Archive Settings', 'dst_stop', '')
                config.set('Archive Settings', 'blurring', '')
                
                with open(self.config_file, 'w') as f:
                    config.write(f)
                
                print(f"✅ Configuration créée: {self.config_file}")
            except Exception as e:
                print(f"⚠️ Erreur création config: {e}")

    def init_ui(self):
        """Initialiser l'interface utilisateur"""
        main_layout = QVBoxLayout(self)
        main_layout.setSpacing(10)
        
        title = QLabel("🚀 Webex Archive Manager")
        title_font = QFont()
        title_font.setPointSize(18)
        title_font.setBold(True)
        title.setFont(title_font)
        title.setAlignment(Qt.AlignmentFlag.AlignCenter)
        main_layout.addWidget(title)
        
        tabs = QTabWidget()
        tabs.addTab(self.create_main_tab(), "📋 Espaces Webex")
        tabs.addTab(self.create_config_tab(), "⚙️ Configuration")
        main_layout.addWidget(tabs)
        
        log_group = QGroupBox("📝 Logs d'exécution")
        log_layout = QVBoxLayout()
        
        self.log_text = QTextEdit()
        self.log_text.setReadOnly(True)
        self.log_text.setMaximumHeight(150)
        log_layout.addWidget(self.log_text)
        
        self.progress_bar = QProgressBar()
        self.progress_bar.setTextVisible(True)
        log_layout.addWidget(self.progress_bar)
        
        log_group.setLayout(log_layout)
        main_layout.addWidget(log_group)

    def create_main_tab(self):
        """Créer l'onglet principal"""
        tab = QWidget()
        layout = QVBoxLayout(tab)
        
        token_group = QGroupBox("🔑 Token d'accès Webex")
        token_layout = QVBoxLayout()
        
        token_info = QLabel("Obtenez votre token sur: developer.webex.com (valide 12h)")
        token_info.setStyleSheet("color: #666; font-size: 10px;")
        token_layout.addWidget(token_info)
        
        token_input_layout = QHBoxLayout()
        self.token_input = QLineEdit()
        self.token_input.setPlaceholderText("Entrez votre token Webex ici...")
        self.token_input.setEchoMode(QLineEdit.EchoMode.Password)
        token_input_layout.addWidget(self.token_input)
        
        self.show_token_btn = QPushButton("👁")
        self.show_token_btn.setMaximumWidth(40)
        self.show_token_btn.setCheckable(True)
        self.show_token_btn.clicked.connect(self.toggle_token_visibility)
        token_input_layout.addWidget(self.show_token_btn)
        
        self.load_spaces_btn = QPushButton("🔄 Charger les espaces")
        self.load_spaces_btn.setStyleSheet("background-color: #0D7ABF; color: white; padding: 8px; font-weight: bold;")
        self.load_spaces_btn.clicked.connect(self.load_spaces)
        token_input_layout.addWidget(self.load_spaces_btn)
        
        token_layout.addLayout(token_input_layout)
        token_group.setLayout(token_layout)
        layout.addWidget(token_group)
        
        spaces_group = QGroupBox("📁 Espaces disponibles")
        spaces_layout = QVBoxLayout()
        
        search_layout = QHBoxLayout()
        self.search_input = QLineEdit()
        self.search_input.setPlaceholderText("🔍 Rechercher un espace...")
        self.search_input.textChanged.connect(self.filter_spaces)
        search_layout.addWidget(self.search_input)
        
        self.type_filter = QComboBox()
        self.type_filter.addItems(["Tous", "Groupes", "Directs"])
        self.type_filter.currentTextChanged.connect(self.filter_spaces)
        search_layout.addWidget(self.type_filter)
        
        spaces_layout.addLayout(search_layout)
        
        self.spaces_list = QListWidget()
        self.spaces_list.setSelectionMode(QListWidget.SelectionMode.ExtendedSelection)
        spaces_layout.addWidget(self.spaces_list)
        
        selection_layout = QHBoxLayout()
        select_all_btn = QPushButton("✅ Tout sélectionner")
        select_all_btn.clicked.connect(self.spaces_list.selectAll)
        selection_layout.addWidget(select_all_btn)
        
        deselect_all_btn = QPushButton("❌ Tout désélectionner")
        deselect_all_btn.clicked.connect(self.spaces_list.clearSelection)
        selection_layout.addWidget(deselect_all_btn)
        
        spaces_layout.addLayout(selection_layout)
        
        spaces_group.setLayout(spaces_layout)
        layout.addWidget(spaces_group)
        
        action_layout = QHBoxLayout()
        
        self.archive_btn = QPushButton("📦 Archiver la sélection")
        self.archive_btn.setStyleSheet("background-color: #28a745; color: white; padding: 10px; font-weight: bold; font-size: 14px;")
        self.archive_btn.clicked.connect(self.archive_selected)
        action_layout.addWidget(self.archive_btn)
        
        self.stop_btn = QPushButton("⏹ Arrêter")
        self.stop_btn.setStyleSheet("background-color: #dc3545; color: white; padding: 10px; font-weight: bold;")
        self.stop_btn.setEnabled(False)
        self.stop_btn.clicked.connect(self.stop_archiving)
        action_layout.addWidget(self.stop_btn)
        
        layout.addLayout(action_layout)
        
        return tab

    def create_config_tab(self):
        """Créer l'onglet de configuration"""
        tab = QWidget()
        layout = QVBoxLayout(tab)
        
        download_group = QGroupBox("📥 Options de téléchargement")
        download_layout = QVBoxLayout()
        
        download_layout.addWidget(QLabel("Télécharger les fichiers:"))
        self.download_combo = QComboBox()
        self.download_combo.addItems(["no - Texte seulement", "info - Infos fichiers", "images - Images seulement", "files - Tous les fichiers"])
        download_layout.addWidget(self.download_combo)
        
        download_layout.addWidget(QLabel("Avatars utilisateurs:"))
        self.avatar_combo = QComboBox()
        self.avatar_combo.addItems(["no - Initiales", "link - Lien vers image", "download - Télécharger"])
        download_layout.addWidget(self.avatar_combo)
        
        download_group.setLayout(download_layout)
        layout.addWidget(download_group)
        
        # Section : Limite d'archivage
        limit_group = QGroupBox("📊 Limite d'archivage")
        limit_layout = QVBoxLayout()
        
        # Choix du type de limite
        limit_type_label = QLabel("Type de limite:")
        limit_type_label.setStyleSheet("font-weight: bold;")
        limit_layout.addWidget(limit_type_label)
        
        self.limit_by_messages = QRadioButton("Limiter par nombre de messages")
        self.limit_by_messages.setChecked(True)
        self.limit_by_messages.toggled.connect(self.toggle_limit_type)
        limit_layout.addWidget(self.limit_by_messages)
        
        # Options pour limite par messages
        msg_limit_layout = QHBoxLayout()
        msg_limit_layout.addSpacing(20)
        self.max_messages_spin = QSpinBox()
        self.max_messages_spin.setRange(1, 999999)
        self.max_messages_spin.setValue(1000)
        msg_limit_layout.addWidget(self.max_messages_spin)
        msg_limit_layout.addWidget(QLabel("messages maximum"))
        msg_limit_layout.addStretch()
        limit_layout.addLayout(msg_limit_layout)
        
        limit_layout.addSpacing(10)
        
        self.limit_by_time = QRadioButton("Limiter par période")
        self.limit_by_time.toggled.connect(self.toggle_limit_type)
        limit_layout.addWidget(self.limit_by_time)
        
        # Options pour limite temporelle
        time_limit_layout = QHBoxLayout()
        time_limit_layout.addSpacing(20)
        time_limit_layout.addWidget(QLabel("Archiver les"))
        self.time_value_spin = QSpinBox()
        self.time_value_spin.setRange(1, 999)
        self.time_value_spin.setValue(30)
        self.time_value_spin.setEnabled(False)
        time_limit_layout.addWidget(self.time_value_spin)
        self.time_unit_combo = QComboBox()
        self.time_unit_combo.addItems(["derniers jours", "derniers mois", "dernières années"])
        self.time_unit_combo.setEnabled(False)
        time_limit_layout.addWidget(self.time_unit_combo)
        time_limit_layout.addStretch()
        limit_layout.addLayout(time_limit_layout)
        
        limit_group.setLayout(limit_layout)
        layout.addWidget(limit_group)
        
        # Section : Options des messages
        messages_group = QGroupBox("💬 Options des messages")
        messages_layout = QVBoxLayout()
        
        self.sort_old_new = QCheckBox("Trier du plus ancien au plus récent")
        self.sort_old_new.setChecked(True)
        messages_layout.addWidget(self.sort_old_new)
        
        self.output_json = QCheckBox("Exporter aussi en JSON")
        messages_layout.addWidget(self.output_json)
        
        self.blurring = QCheckBox("Flouter les noms dans le HTML")
        messages_layout.addWidget(self.blurring)
        
        messages_group.setLayout(messages_layout)
        layout.addWidget(messages_group)
        
        button_layout = QHBoxLayout()
        
        save_config_btn = QPushButton("💾 Sauvegarder la configuration")
        save_config_btn.setStyleSheet("background-color: #0D7ABF; color: white; padding: 8px;")
        save_config_btn.clicked.connect(self.save_config)
        button_layout.addWidget(save_config_btn)
        
        load_config_btn = QPushButton("📂 Charger la configuration")
        load_config_btn.clicked.connect(self.load_config)
        button_layout.addWidget(load_config_btn)
        
        layout.addLayout(button_layout)
        layout.addStretch()
        
        return tab

    def toggle_token_visibility(self):
        if self.show_token_btn.isChecked():
            self.token_input.setEchoMode(QLineEdit.EchoMode.Normal)
        else:
            self.token_input.setEchoMode(QLineEdit.EchoMode.Password)

    def toggle_limit_type(self):
        """Activer/désactiver les options selon le type de limite choisi"""
        by_messages = self.limit_by_messages.isChecked()
        
        # Activer/désactiver les champs de limite par messages
        self.max_messages_spin.setEnabled(by_messages)
        
        # Activer/désactiver les champs de limite temporelle
        self.time_value_spin.setEnabled(not by_messages)
        self.time_unit_combo.setEnabled(not by_messages)

    def load_spaces(self):
        token = self.token_input.text().strip()
        
        if not token:
            QMessageBox.warning(self, "Token manquant", "Veuillez entrer votre token Webex.")
            return
        
        self.log_text.append("🔄 Chargement des espaces Webex...")
        self.load_spaces_btn.setEnabled(False)
        
        try:
            headers = {"Authorization": f"Bearer {token}", "Content-Type": "application/json"}
            response = requests.get("https://webexapis.com/v1/rooms?max=1000", headers=headers, timeout=10)
            response.raise_for_status()
            
            self.rooms_data = sorted(
                response.json().get("items", []),
                key=lambda room: room.get("title", "").lower()
            )
            
            self.spaces_list.clear()
            for room in self.rooms_data:
                room_type = "👥" if room['type'] == "group" else "💬"
                item = QListWidgetItem(f"{room_type} {room['title']}")
                item.setData(Qt.ItemDataRole.UserRole, room)
                self.spaces_list.addItem(item)
            
            self.log_text.append(f"✅ {len(self.rooms_data)} espaces chargés avec succès")
            self.save_settings()
            
        except requests.exceptions.RequestException as e:
            QMessageBox.critical(self, "Erreur", f"Erreur lors du chargement des espaces:\n{str(e)}")
            self.log_text.append(f"❌ Erreur: {str(e)}")
        finally:
            self.load_spaces_btn.setEnabled(True)

    def filter_spaces(self):
        search_text = self.search_input.text().lower()
        type_filter = self.type_filter.currentText()
        
        for i in range(self.spaces_list.count()):
            item = self.spaces_list.item(i)
            room = item.data(Qt.ItemDataRole.UserRole)
            
            matches_search = search_text in room['title'].lower()
            
            matches_type = True
            if type_filter == "Groupes":
                matches_type = room['type'] == "group"
            elif type_filter == "Directs":
                matches_type = room['type'] == "direct"
            
            item.setHidden(not (matches_search and matches_type))

    def archive_selected(self):
        selected_items = self.spaces_list.selectedItems()
        
        if not selected_items:
            QMessageBox.warning(self, "Aucune sélection", "Veuillez sélectionner au moins un espace à archiver.")
            return
        
        if not self.archive_script.exists():
            QMessageBox.critical(self, "Script manquant", f"Le script d'archivage n'a pas été trouvé:\n{self.archive_script}")
            return
        
        self.save_config()
        
        room_ids = [item.data(Qt.ItemDataRole.UserRole)['id'] for item in selected_items]
        
        reply = QMessageBox.question(
            self,
            "Confirmation",
            f"Archiver {len(room_ids)} espace(s) ?\n\nCela peut prendre du temps.",
            QMessageBox.StandardButton.Yes | QMessageBox.StandardButton.No
        )
        
        if reply == QMessageBox.StandardButton.No:
            return
        
        self.log_text.clear()
        self.log_text.append(f"🚀 Démarrage de l'archivage de {len(room_ids)} espace(s)...")
        self.progress_bar.setValue(0)
        
        self.archive_btn.setEnabled(False)
        self.stop_btn.setEnabled(True)
        
        config_filename = self.config_file.name
        self.worker = ArchiveWorker(str(self.archive_script), room_ids, config_filename)
        self.worker.progress.connect(self.update_progress)
        self.worker.log.connect(self.append_log)
        self.worker.finished.connect(self.archive_finished)
        self.worker.error.connect(self.archive_error)
        self.worker.start()

    def stop_archiving(self):
        if self.worker:
            self.worker.stop()
            self.stop_btn.setEnabled(False)

    def update_progress(self, current, total):
        progress = int((current / total) * 100)
        self.progress_bar.setValue(progress)
        self.progress_bar.setFormat(f"{current}/{total} espaces archivés ({progress}%)")

    def append_log(self, message):
        self.log_text.append(message)
        self.log_text.verticalScrollBar().setValue(
            self.log_text.verticalScrollBar().maximum()
        )

    def archive_finished(self):
        self.archive_btn.setEnabled(True)
        self.stop_btn.setEnabled(False)
        self.log_text.append("\n🎉 Archivage terminé!")
        QMessageBox.information(self, "Terminé", "L'archivage est terminé avec succès!")

    def archive_error(self, error_msg):
        QMessageBox.warning(self, "Erreur", f"Une erreur s'est produite:\n{error_msg}")

    def save_config(self):
        try:
            import configparser
            config = configparser.ConfigParser()
            
            if self.config_file.exists():
                config.read(str(self.config_file))
            
            if not config.has_section('Archive Settings'):
                config.add_section('Archive Settings')
            
            download_value = self.download_combo.currentText().split(" - ")[0]
            avatar_value = self.avatar_combo.currentText().split(" - ")[0]
            
            config['Archive Settings']['download'] = download_value
            config['Archive Settings']['useravatar'] = avatar_value
            config['Archive Settings']['sortoldnew'] = 'yes' if self.sort_old_new.isChecked() else 'no'
            config['Archive Settings']['outputjson'] = 'yes' if self.output_json.isChecked() else 'no'
            config['Archive Settings']['blurring'] = 'yes' if self.blurring.isChecked() else ''
            
            # Options de limite d'archivage
            config['Archive Settings']['limit_type'] = 'messages' if self.limit_by_messages.isChecked() else 'time'
            config['Archive Settings']['maxtotalmessages'] = str(self.max_messages_spin.value())
            config['Archive Settings']['time_limit_value'] = str(self.time_value_spin.value())
            config['Archive Settings']['time_limit_unit'] = self.time_unit_combo.currentText().split()[1]  # 'jours', 'mois', 'années'
            
            token = self.token_input.text().strip()
            if token:
                config['Archive Settings']['mytoken'] = token
            
            if not config.has_option('Archive Settings', 'myspaceid'):
                config['Archive Settings']['myspaceid'] = '__YOUR_SPACE_ID_HERE__'
            
            if not config.has_option('Archive Settings', 'outputfilename'):
                config['Archive Settings']['outputfilename'] = ''
            
            if not config.has_option('Archive Settings', 'dst_start'):
                config['Archive Settings']['dst_start'] = ''
            if not config.has_option('Archive Settings', 'dst_stop'):
                config['Archive Settings']['dst_stop'] = ''
            
            with open(self.config_file, 'w') as f:
                config.write(f)
            
            self.log_text.append("✅ Configuration sauvegardée")
            
        except Exception as e:
            QMessageBox.critical(self, "Erreur", f"Erreur lors de la sauvegarde:\n{str(e)}")

    def load_config(self):
        try:
            import configparser
            config = configparser.ConfigParser()
            
            if not self.config_file.exists():
                self.log_text.append("⚠️ Fichier de configuration non trouvé, utilisation des valeurs par défaut")
                return
            
            config.read(str(self.config_file))
            
            if config.has_section('Archive Settings'):
                download = config['Archive Settings'].get('download', 'no')
                avatar = config['Archive Settings'].get('useravatar', 'no')
                max_msg = config['Archive Settings'].get('maxtotalmessages', '1000')
                sort_old = config['Archive Settings'].get('sortoldnew', 'yes')
                output_json = config['Archive Settings'].get('outputjson', 'no')
                blurring = config['Archive Settings'].get('blurring', '')
                
                for i in range(self.download_combo.count()):
                    if self.download_combo.itemText(i).startswith(download):
                        self.download_combo.setCurrentIndex(i)
                        break
                
                for i in range(self.avatar_combo.count()):
                    if self.avatar_combo.itemText(i).startswith(avatar):
                        self.avatar_combo.setCurrentIndex(i)
                        break
                
                # Charger les options de limite
                limit_type = config['Archive Settings'].get('limit_type', 'messages')
                time_limit_value = config['Archive Settings'].get('time_limit_value', '30')
                time_limit_unit = config['Archive Settings'].get('time_limit_unit', 'jours')
                
                if limit_type == 'messages':
                    self.limit_by_messages.setChecked(True)
                else:
                    self.limit_by_time.setChecked(True)
                
                try:
                    self.max_messages_spin.setValue(int(max_msg.replace('d', '')))
                except:
                    self.max_messages_spin.setValue(1000)
                
                try:
                    self.time_value_spin.setValue(int(time_limit_value))
                except:
                    self.time_value_spin.setValue(30)
                
                # Sélectionner l'unité de temps
                unit_map = {'jours': 0, 'mois': 1, 'années': 2}
                self.time_unit_combo.setCurrentIndex(unit_map.get(time_limit_unit, 0))
                
                self.sort_old_new.setChecked(sort_old == 'yes')
                self.output_json.setChecked(output_json in ['yes', 'json', 'both'])
                self.blurring.setChecked(blurring == 'yes')
                
                self.log_text.append("✅ Configuration chargée")
            
        except Exception as e:
            QMessageBox.warning(self, "Erreur", f"Erreur lors du chargement:\n{str(e)}")

    def save_settings(self):
        settings = {'token': self.token_input.text().strip()}
        try:
            with open(self.settings_file, 'w') as f:
                json.dump(settings, f)
        except Exception as e:
            print(f"Erreur sauvegarde settings: {e}")

    def load_settings(self):
        if self.settings_file.exists():
            try:
                with open(self.settings_file, 'r') as f:
                    settings = json.load(f)
                    self.token_input.setText(settings.get('token', ''))
            except Exception as e:
                print(f"Erreur chargement settings: {e}")
        
        self.load_config()


def main():
    app = QApplication(sys.argv)
    app.setStyle('Fusion')
    window = WebexArchiverGUI()
    window.show()
    sys.exit(app.exec())


if __name__ == "__main__":
    main()
