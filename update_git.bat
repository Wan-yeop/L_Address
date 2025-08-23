@echo off
REM ===== Git 자동 Pull → Commit → Push =====

REM 현재 디렉토리 표시
echo 현재 디렉토리: %cd%

REM 날짜/시간 메시지를 PowerShell로 한 줄에 가져오기
for /f %%i in ('powershell -NoProfile -Command "Get-Date -Format \"yyyy-MM-dd HH:mm\" "') do set msg=%%i 수정

REM 1. 원격 저장소 최신 내용 가져오기
echo [1/4] 원격 저장소 최신 내용 가져오는 중...
git pull origin main --allow-unrelated-histories

REM 2. 변경사항 스테이징
echo [2/4] 변경사항 스테이징...
git add .

REM 3. 커밋
echo [3/4] 커밋 생성...
git commit -m "%msg%"

REM 4. 원격 저장소로 push
echo [4/4] 원격 저장소로 Push...
git push origin main

echo ======================================
echo Git Pull & Push 완료!
echo 커밋 메시지: %msg%
pause
