import sys
import subprocess
import requests
import os
import json
from pathlib import Path
from PyQt6.QtWidgets import (
    QApplication, QWidget, QVBoxLayout, QHBoxLayout, QPushButton, 
    QLineEdit, QLabel, QListWidget, QListWidgetItem, QProgressBar,
    QTextEdit, QComboBox, QSpinBox, QCheckBox, QGroupBox, QTabWidget,
    QMessageBox, QFileDialog, QSplitter
)
from PyQt6.QtCore import Qt, QThread, pyqtSignal
from PyQt6.QtGui import QFont, QIcon


class ArchiveWorker(QThread):
    """Thread worker pour exécuter l'archivage sans bloquer l'interface"""
    progress = pyqtSignal(int, int)  # current, total
    log = pyqtSignal(str)
    finished = pyqtSignal()
    error = pyqtSignal(str)

    def __init__(self, script_path, room_ids, config_filename):
        super().__init__()
        self.script_path = script_path
        self.room_ids = room_ids
        self.config_filename = config_filename  # Juste le nom du fichier, pas le chemin complet
        self._is_running = True

    def run(self):
        total = len(self.room_ids)
        for i, room_id in enumerate(self.room_ids):
            if not self._is_running:
                self.log.emit("❌ Archivage annulé par l'utilisateur")
                break
            
            try:
                self.log.emit(f"\n📦 Archivage de l'espace {i+1}/{total}...")
                self.log.emit(f"   ID: {room_id}")
                
                # Exécuter le script d'archivage
                # Le script s'exécute dans le répertoire 'Webex Archive' et utilise le nom du fichier config
                process = subprocess.Popen(
                    ["python3", os.path.basename(self.script_path), room_id, self.config_filename],
                    stdout=subprocess.PIPE,
                    stderr=subprocess.PIPE,
                    text=True,
                    cwd=os.path.dirname(self.script_path)
                )
                
                # Lire la sortie en temps réel
                for line in process.stdout:
                    if line.strip():
                        self.log.emit(f"   {line.strip()}")
                
                process.wait()
                
                if process.returncode == 0:
                    self.log.emit(f"✅ Espace {i+1}/{total} archivé avec succès")
                else:
                    error_msg = process.stderr.read()
                    self.log.emit(f"⚠️ Erreur lors de l'archivage: {error_msg}")
                
                self.progress.emit(i + 1, total)
                
            except Exception as e:
                self.log.emit(f"❌ Erreur: {str(e)}")
                self.error.emit(str(e))
        
        self.finished.emit()

    def stop(self):
        self._is_running = False


class WebexArchiverGUI(QWidget):
    def __init__(self):
        super().__init__()
        self.setWindowTitle("Webex Archive - Interface Graphique")
        self.resize(1000, 700)
        
        # Chemins des fichiers
        self.base_dir = Path(__file__).parent / "Webex Archive"
        self.archive_script = self.base_dir / "webex-space-archive.py"
        self.config_file = self.base_dir / "webexspacearchive-config.ini"
        self.settings_file = Path(__file__).parent / ".webex_gui_settings.json"
        
        # Variables
        self.rooms_data = []
        self.worker = None
        
        self.init_ui()
        self.load_settings()

    def init_ui(self):
        """Initialiser l'interface utilisateur"""
        main_layout = QVBoxLayout(self)
        main_layout.setSpacing(10)
        
        # Titre
        title = QLabel("🚀 Webex Archive Manager")
        title_font = QFont()
        title_font.setPointSize(18)
        title_font.setBold(True)
        title.setFont(title_font)
        title.setAlignment(Qt.AlignmentFlag.AlignCenter)
        main_layout.addWidget(title)
        
        # Tabs
        tabs = QTabWidget()
        tabs.addTab(self.create_main_tab(), "📋 Espaces Webex")
        tabs.addTab(self.create_config_tab(), "⚙️ Configuration")
        main_layout.addWidget(tabs)
        
        # Logs et progression en bas
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
        
        # Section Token
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
        
        # Section Espaces
        spaces_group = QGroupBox("📁 Espaces disponibles")
        spaces_layout = QVBoxLayout()
        
        # Recherche et filtres
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
        
        # Liste des espaces
        self.spaces_list = QListWidget()
        self.spaces_list.setSelectionMode(QListWidget.SelectionMode.ExtendedSelection)
        spaces_layout.addWidget(self.spaces_list)
        
        # Boutons de sélection
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
        
        # Boutons d'action
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
        
        # Options de téléchargement
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
        
        # Options de messages
        messages_group = QGroupBox("💬 Options des messages")
        messages_layout = QVBoxLayout()
        
        messages_layout.addWidget(QLabel("Nombre maximum de messages:"))
        max_msg_layout = QHBoxLayout()
        self.max_messages_spin = QSpinBox()
        self.max_messages_spin.setRange(1, 999999)
        self.max_messages_spin.setValue(1000)
        max_msg_layout.addWidget(self.max_messages_spin)
        max_msg_layout.addWidget(QLabel("messages"))
        messages_layout.addLayout(max_msg_layout)
        
        self.sort_old_new = QCheckBox("Trier du plus ancien au plus récent")
        self.sort_old_new.setChecked(True)
        messages_layout.addWidget(self.sort_old_new)
        
        self.output_json = QCheckBox("Exporter aussi en JSON")
        messages_layout.addWidget(self.output_json)
        
        self.blurring = QCheckBox("Flouter les noms dans le HTML")
        messages_layout.addWidget(self.blurring)
        
        messages_group.setLayout(messages_layout)
        layout.addWidget(messages_group)
        
        # Boutons
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
        """Basculer la visibilité du token"""
        if self.show_token_btn.isChecked():
            self.token_input.setEchoMode(QLineEdit.EchoMode.Normal)
        else:
            self.token_input.setEchoMode(QLineEdit.EchoMode.Password)

    def load_spaces(self):
        """Charger les espaces Webex"""
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
            
            # Sauvegarder le token
            self.save_settings()
            
        except requests.exceptions.RequestException as e:
            QMessageBox.critical(self, "Erreur", f"Erreur lors du chargement des espaces:\n{str(e)}")
            self.log_text.append(f"❌ Erreur: {str(e)}")
        finally:
            self.load_spaces_btn.setEnabled(True)

    def filter_spaces(self):
        """Filtrer les espaces selon la recherche et le type"""
        search_text = self.search_input.text().lower()
        type_filter = self.type_filter.currentText()
        
        for i in range(self.spaces_list.count()):
            item = self.spaces_list.item(i)
            room = item.data(Qt.ItemDataRole.UserRole)
            
            # Filtre de recherche
            matches_search = search_text in room['title'].lower()
            
            # Filtre de type
            matches_type = True
            if type_filter == "Groupes":
                matches_type = room['type'] == "group"
            elif type_filter == "Directs":
                matches_type = room['type'] == "direct"
            
            item.setHidden(not (matches_search and matches_type))

    def archive_selected(self):
        """Archiver les espaces sélectionnés"""
        selected_items = self.spaces_list.selectedItems()
        
        if not selected_items:
            QMessageBox.warning(self, "Aucune sélection", "Veuillez sélectionner au moins un espace à archiver.")
            return
        
        # Vérifier que le script existe
        if not self.archive_script.exists():
            QMessageBox.critical(self, "Script manquant", f"Le script d'archivage n'a pas été trouvé:\n{self.archive_script}")
            return
        
        # Sauvegarder la configuration avant d'archiver
        self.save_config()
        
        # Récupérer les IDs des espaces sélectionnés
        room_ids = [item.data(Qt.ItemDataRole.UserRole)['id'] for item in selected_items]
        
        # Confirmation
        reply = QMessageBox.question(
            self,
            "Confirmation",
            f"Archiver {len(room_ids)} espace(s) ?\n\nCela peut prendre du temps.",
            QMessageBox.StandardButton.Yes | QMessageBox.StandardButton.No
        )
        
        if reply == QMessageBox.StandardButton.No:
            return
        
        # Démarrer l'archivage
        self.log_text.clear()
        self.log_text.append(f"🚀 Démarrage de l'archivage de {len(room_ids)} espace(s)...")
        self.progress_bar.setValue(0)
        
        self.archive_btn.setEnabled(False)
        self.stop_btn.setEnabled(True)
        
        # Créer et démarrer le worker thread
        # Passer seulement le nom du fichier config, pas le chemin complet
        config_filename = self.config_file.name
        self.worker = ArchiveWorker(str(self.archive_script), room_ids, config_filename)
        self.worker.progress.connect(self.update_progress)
        self.worker.log.connect(self.append_log)
        self.worker.finished.connect(self.archive_finished)
        self.worker.error.connect(self.archive_error)
        self.worker.start()

    def stop_archiving(self):
        """Arrêter l'archivage en cours"""
        if self.worker:
            self.worker.stop()
            self.stop_btn.setEnabled(False)

    def update_progress(self, current, total):
        """Mettre à jour la barre de progression"""
        progress = int((current / total) * 100)
        self.progress_bar.setValue(progress)
        self.progress_bar.setFormat(f"{current}/{total} espaces archivés ({progress}%)")

    def append_log(self, message):
        """Ajouter un message aux logs"""
        self.log_text.append(message)
        self.log_text.verticalScrollBar().setValue(
            self.log_text.verticalScrollBar().maximum()
        )

    def archive_finished(self):
        """Callback quand l'archivage est terminé"""
        self.archive_btn.setEnabled(True)
        self.stop_btn.setEnabled(False)
        self.log_text.append("\n🎉 Archivage terminé!")
        QMessageBox.information(self, "Terminé", "L'archivage est terminé avec succès!")

    def archive_error(self, error_msg):
        """Callback en cas d'erreur"""
        QMessageBox.warning(self, "Erreur", f"Une erreur s'est produite:\n{error_msg}")

    def save_config(self):
        """Sauvegarder la configuration dans le fichier .ini"""
        try:
            import configparser
            config = configparser.ConfigParser()
            
            # Lire le fichier existant s'il existe
            if self.config_file.exists():
                config.read(str(self.config_file))
            
            if not config.has_section('Archive Settings'):
                config.add_section('Archive Settings')
            
            # Récupérer les valeurs
            download_value = self.download_combo.currentText().split(" - ")[0]
            avatar_value = self.avatar_combo.currentText().split(" - ")[0]
            
            # Mettre à jour la config
            config['Archive Settings']['download'] = download_value
            config['Archive Settings']['useravatar'] = avatar_value
            config['Archive Settings']['maxtotalmessages'] = str(self.max_messages_spin.value())
            config['Archive Settings']['sortoldnew'] = 'yes' if self.sort_old_new.isChecked() else 'no'
            config['Archive Settings']['outputjson'] = 'yes' if self.output_json.isChecked() else 'no'
            config['Archive Settings']['blurring'] = 'yes' if self.blurring.isChecked() else ''
            
            # Sauvegarder le token si présent
            token = self.token_input.text().strip()
            if token:
                config['Archive Settings']['mytoken'] = token
            
            # S'assurer que myspaceid existe
            if not config.has_option('Archive Settings', 'myspaceid'):
                config['Archive Settings']['myspaceid'] = '__YOUR_SPACE_ID_HERE__'
            
            # S'assurer que outputfilename existe
            if not config.has_option('Archive Settings', 'outputfilename'):
                config['Archive Settings']['outputfilename'] = ''
            
            # S'assurer que dst_start et dst_stop existent
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
        """Charger la configuration depuis le fichier .ini"""
        try:
            import configparser
            config = configparser.ConfigParser()
            
            if not self.config_file.exists():
                self.log_text.append("⚠️ Fichier de configuration non trouvé, utilisation des valeurs par défaut")
                return
            
            config.read(str(self.config_file))
            
            if config.has_section('Archive Settings'):
                # Charger les valeurs
                download = config['Archive Settings'].get('download', 'no')
                avatar = config['Archive Settings'].get('useravatar', 'no')
                max_msg = config['Archive Settings'].get('maxtotalmessages', '1000')
                sort_old = config['Archive Settings'].get('sortoldnew', 'yes')
                output_json = config['Archive Settings'].get('outputjson', 'no')
                blurring = config['Archive Settings'].get('blurring', '')
                
                # Appliquer aux widgets
                self.download_combo.setCurrentText(f"{download} - " + self.download_combo.currentText().split(" - ")[1])
                self.avatar_combo.setCurrentText(f"{avatar} - " + self.avatar_combo.currentText().split(" - ")[1])
                
                try:
                    self.max_messages_spin.setValue(int(max_msg.replace('d', '')))
                except:
                    self.max_messages_spin.setValue(1000)
                
                self.sort_old_new.setChecked(sort_old == 'yes')
                self.output_json.setChecked(output_json in ['yes', 'json', 'both'])
                self.blurring.setChecked(blurring == 'yes')
                
                self.log_text.append("✅ Configuration chargée")
            
        except Exception as e:
            QMessageBox.warning(self, "Erreur", f"Erreur lors du chargement:\n{str(e)}")

    def save_settings(self):
        """Sauvegarder les paramètres de l'interface"""
        settings = {
            'token': self.token_input.text().strip()
        }
        try:
            with open(self.settings_file, 'w') as f:
                json.dump(settings, f)
        except Exception as e:
            print(f"Erreur sauvegarde settings: {e}")

    def load_settings(self):
        """Charger les paramètres de l'interface"""
        if self.settings_file.exists():
            try:
                with open(self.settings_file, 'r') as f:
                    settings = json.load(f)
                    self.token_input.setText(settings.get('token', ''))
            except Exception as e:
                print(f"Erreur chargement settings: {e}")
        
        # Charger aussi la config .ini
        self.load_config()


def main():
    app = QApplication(sys.argv)
    app.setStyle('Fusion')  # Style moderne
    window = WebexArchiverGUI()
    window.show()
    sys.exit(app.exec())


if __name__ == "__main__":
    main()