@echo off
REM GitHub Sync Setup Script for Obsidian Vault
REM Run this script from F:\Codex_Ai_Knowledges_Vault

echo ========================================
echo Obsidian Vault GitHub Sync Setup
echo ========================================
echo.

REM Check if git is available
git --version >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] Git is not installed. Please install Git first.
    pause
    exit /b 1
)

echo [OK] Git detected

REM Check if already a git repo
if exist ".git" (
    echo [OK] Git repository already initialized
) else (
    echo [INFO] Initializing git repository...
    git init
)

REM Configure remote
git remote -v | findstr "Codex_obsidian" >nul 2>&1
if %errorlevel% neq 0 (
    echo [INFO] Adding GitHub remote...
    git remote add origin https://github.com/Iquar/Codex_obsidian.git
) else (
    echo [OK] GitHub remote already configured
)

REM Create .gitignore
echo # Obsidian > .gitignore
echo .obsidian/workspace.json >> .gitignore
echo .obsidian/workspace-mobile.json >> .gitignore
echo .trash/ >> .gitignore
echo .DS_Store >> .gitignore
echo Thumbs.db >> .gitignore

echo [OK] .gitignore created

REM Initial commit
git add .
git status

echo.
echo ========================================
echo Manual steps:
echo 1. Run: git commit -m "Initial Knowledge Base setup"
echo 2. Run: git branch -M main
echo 3. Run: git pull origin main --allow-unrelated-histories
echo 4. Run: git push -u origin main
echo.
echo Optional: Install Obsidian Git plugin for auto-sync
echo ========================================
pause
