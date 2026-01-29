@echo off
setlocal

rem Always work from the v2.1.0 directory where this script lives
pushd "%~dp0"

set PATH=..\..\dx_rt\bin;%PATH%

set "APP_JSON_PATH=example\yolo_multi\ppu_yolo_multi_demo.json"

start cmd /K "bin\yolo_multi.exe" -c %APP_JSON_PATH%
popd
endlocal