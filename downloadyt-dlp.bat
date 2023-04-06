@echo off
set root=%CD%
set mode=Single
set debug=0

:single
set mode=Single
cls
cd %root%
echo Current root: %root%
echo Current mode: %mode%
echo.
echo Available commands:
echo.
echo A - Album Mode
echo E - Exit
echo.
set /P "link=Enter command or link: "
if "%link%"=="a" goto setalbum
if "%link%"=="e" exit
echo Single Mode
echo.
set /P "folder=Enter artist folder name: "
set /P "artist=Enter artist/s: "
set /P "album=Enter album: "
set /P "track=Enter track number: "
set /P "title=Enter title: "
set /P "genre=Enter genre: "
set /P "year=Enter year: "
if "%folder%"=="" set folder=%artist%
if "%album%"=="" set album=%title%
if "%track%"=="" set track=01
if "%genre%"=="" set genre=Dubstep

if "%debug%"=="1" (
echo %link%
echo %folder%
echo %artist%
echo %album%
echo %track%
echo %title%
echo %genre%
echo %year%
)

:: ORDER == artist - album - track - title - genre - year
yt-dlp -o "%artist% - %album% - %track% - %title% - %genre% - %year%" -P "%root%\%genre%\%folder%" -x --audio-format mp3 %link%
"C:\Program Files\Mp3tag\Mp3tag.exe" /fp:"%root%\%genre%\%folder%"
goto single

:setalbum
cls
echo Set Album Information:
echo.
set /P "folder=Enter artist folder name: "
set /P "artist=Enter artist/s: "
set /P "album=Enter album: "
set /P "genre=Enter genre: "
set /P "year=Enter year: "
if "%folder%"=="" set folder=%artist%
goto album

:album
set mode=Album
cls
cd %root%
echo Current root: %root%
echo Current mode: %mode%
echo Current album: %album%
echo.
echo Available commands:
echo.
echo S - Single Mode
echo C - Change Album
echo F - Finish Album
echo E - Exit
echo.
set /P "link=Enter command or link: "
if "%link%"=="s" goto single
if "%link%"=="c" goto setalbum
if "%link%"=="f" goto finishalbum
if "%link%"=="e" exit
cls
echo Album Mode
echo.
set /P "track=Enter track number: "
set /P "title=Enter title: "
if "%track%"=="" set track=01

if "%debug%"=="1" (
echo %link%
echo %folder%
echo %artist%
echo %album%
echo %track%
echo %title%
echo %genre%
echo %year%
)

:: ORDER == artist - album - track - title - genre - year
yt-dlp -o "%artist% - %album% - %track% - %title% - %genre% - %year%" -P "%root%\%genre%\%folder%\%year% - %album%" -x --audio-format mp3 %link%
goto album

:finishalbum
"C:\Program Files\Mp3tag\Mp3tag.exe" /fp:"%root%\%genre%\%folder%\%year% - %album%"
goto single