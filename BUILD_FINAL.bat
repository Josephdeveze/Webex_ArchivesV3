@echo off
REM Script de compilation FINAL avec correction automatique du bug _socket
REM Ce script fait tout automatiquement

echo.
echo ========================================
echo   COMPILATION WEBEX ARCHIVE MANAGER
echo   Avec correction automatique _socket
echo ========================================
echo.

REM Etape 1 : Nettoyer
echo [1/4] Nettoyage des anciens builds...
if exist build rmdir /s /q build
if exist dist rmdir /s /q dist
echo       OK - Nettoyage termine
echo.

REM Etape 2 : Compiler avec PyInstaller
echo [2/4] Compilation avec PyInstaller...
echo       (Cela peut prendre 2-3 minutes...)
pyinstaller --clean --noconfirm "Webex Archive Manager.spec"
if %errorlevel% neq 0 (
    echo       ERREUR - La compilation a echoue
    pause
    exit /b 1
)
echo       OK - Compilation terminee
echo.

REM Etape 3 : Appliquer le fix (copier les .pyd à la racine)
echo [3/4] Application du fix pour _socket...
python post_build_fix.py
if %errorlevel% neq 0 (
    echo       ERREUR - Le fix a echoue
    pause
    exit /b 1
)
echo       OK - Fix applique
echo.

REM Etape 4 : Verification
echo [4/4] Verification...
if exist "dist\Webex Archive Manager\Webex Archive Manager.exe" (
    if exist "dist\Webex Archive Manager\_socket.pyd" (
        echo       OK - Executable cree
        echo       OK - Fichiers .pyd presents a la racine
        echo.
        echo ========================================
        echo   COMPILATION REUSSIE !
        echo ========================================
        echo.
        echo L'application est prete dans :
        echo   dist\Webex Archive Manager\
        echo.
        echo IMPORTANT : Les fichiers .pyd sont maintenant
        echo a la RACINE du dossier, pas dans _internal
        echo.
        echo Testez l'application avant de distribuer !
        echo.
    ) else (
        echo       ERREUR - Fichiers .pyd manquants
        pause
        exit /b 1
    )
) else (
    echo       ERREUR - Executable non cree
    pause
    exit /b 1
)

set /p test="Voulez-vous tester l'application maintenant ? (O/N): "
if /i "%test%"=="O" (
    echo.
    echo Lancement de l'application...
    start "" "dist\Webex Archive Manager\Webex Archive Manager.exe"
)

echo.
pause
