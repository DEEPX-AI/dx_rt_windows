@echo off
setlocal
pushd ..\..\
set PATH=..\dx_rt\bin;%PATH%

set "APP_JSON_PATH=example\yolo_multi\ppu_yolo_multi_demo.json"

start cmd /K "bin\yolo_multi.exe" -c %APP_JSON_PATH%
popd
endlocal