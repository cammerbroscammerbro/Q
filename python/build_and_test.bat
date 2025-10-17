@echo off
echo ===============================
echo 🔧 Building quantumsafe package
echo ===============================

cd /d C:\Users\RUDRANSH\pqc-projects\quantumsafe\python

"C:\Users\RUDRANSH\New folder\New folder\python.exe" -m pip install --upgrade build setuptools wheel >nul 2>&1
"C:\Users\RUDRANSH\New folder\New folder\python.exe" -m build

if exist dist\quantumsafe-0.1-py3-none-any.whl (
    echo ===============================
    echo 📦 Installing wheel package
    echo ===============================
    "C:\Users\RUDRANSH\New folder\New folder\python.exe" -m pip install --force-reinstall dist\quantumsafe-0.1-py3-none-any.whl
) else (
    echo ❌ Build failed — wheel file not found.
    pause
    exit /b
)

echo ===============================
echo 🧠 Testing import
echo ===============================
echo import quantumsafe ^&^& print('quantumsafe imported successfully!') > test_import.py
"C:\Users\RUDRANSH\New folder\New folder\python.exe" test_import.py

pause
