@echo off
setlocal

rem Always work from the v2.1.0 directory where this script lives
pushd "%~dp0"

set PATH=..\..\dx_rt\bin;%PATH%

set "APP_MODEL_PATH=..\assets\models\YoloV7.dxnn"
set "APP_CONFIG_PARAM=4"
set "APP_VIDEO_PATH=..\assets\videos\dogs.mp4"
start cmd /K "bin\yolo.exe" -m %APP_MODEL_PATH% -p %APP_CONFIG_PARAM% -v %APP_VIDEO_PATH% --target_fps 30
popd
endlocal