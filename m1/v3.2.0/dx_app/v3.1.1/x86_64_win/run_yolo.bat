@echo off
setlocal
pushd ..\
set PATH=..\..\dx_rt\bin;%PATH%

set "APP_MODEL_PATH=..\assets\models\YoloV7.dxnn"
set "APP_CONFIG_PARAM=4"
set "APP_VIDEO_PATH=..\assets\videos\dogs.mp4"
start cmd /K "bin\yolo.exe" -m %APP_MODEL_PATH% -p %APP_CONFIG_PARAM% -v %APP_VIDEO_PATH%
popd
endlocal