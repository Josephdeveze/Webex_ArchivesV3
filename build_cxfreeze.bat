@echo off
REM Script de compilation avec cx_Freeze
REM Compatible Python 3.13

echo.
echo ========================================
echo   COMPILATION AVEC CX_FREEZE
echo   Webex Archive Manager
echo ========================================
echo.

REM Etape 1 : Nettoyer les anciens builds
echo [1/3] Nettoyage des anciens builds...
if exist build rmdir /s /q build
if exist dist rmdir /s /q dist
echo       OK - Nettoyage termine
echo.

REM Etape 2 : Compiler avec cx_Freeze
echo [2/3] Compilation avec cx_Freeze...
echo       (Cela peut prendre 2-3 minutes...)
python setup.py build
if %errorlevel% neq 0 (
    echo       ERREUR - La compilation a echoue
    pause
    exit /b 1
)
echo       OK - Compilation terminee
echo.

REM Etape 3 : Verification
echo [3/3] Verification...
for /d %%D in (build\exe.*) do (
    if exist "%%D\Webex Archive Manager.exe" (
        echo       OK - Executable cree dans %%D
        echo.
        echo ========================================
        echo   COMPILATION REUSSIE !
        echo ========================================
        echo.
        echo L'application est prete dans :
        echo   %%D\
        echo.
        echo Testez l'application avant de distribuer !
        echo.
        
        set /p test="Voulez-vous tester l'application maintenant ? (O/N): "
        if /i "!test!"=="O" (
            echo.
            echo Lancement de l'application...
            start "" "%%D\Webex Archive Manager.exe"
        )
        goto :end
    )
)

echo       ERREUR - Executable non trouve
pause
exit /b 1

:end
echo.
pause
