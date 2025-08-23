@echo off
REM ===== Git �ڵ� Pull �� Commit �� Push =====

REM ���� ���丮 ǥ��
echo ���� ���丮: %cd%

REM ��¥/�ð� �޽����� PowerShell�� �� �ٿ� ��������
for /f %%i in ('powershell -NoProfile -Command "Get-Date -Format \"yyyy-MM-dd HH:mm\" "') do set msg=%%i ����

REM 1. ���� ����� �ֽ� ���� ��������
echo [1/4] ���� ����� �ֽ� ���� �������� ��...
git pull origin main --allow-unrelated-histories

REM 2. ������� ������¡
echo [2/4] ������� ������¡...
git add .

REM 3. Ŀ��
echo [3/4] Ŀ�� ����...
git commit -m "%msg%"

REM 4. ���� ����ҷ� push
echo [4/4] ���� ����ҷ� Push...
git push origin main

echo ======================================
echo Git Pull & Push �Ϸ�!
echo Ŀ�� �޽���: %msg%
pause
