@echo off
setlocal

rem Always work from the v2.1.0 directory where this script lives
pushd "%~dp0"

set PATH=..\..\dx_rt\bin;%PATH%

set "APP_MODEL_PATH=..\assets\models\YOLOV5Pose640_1.dxnn"
set "APP_CONFIG_PARAM=0"
set "APP_VIDEO_PATH=..\assets\videos\dance-group2.mov"

start cmd /K "bin\pose.exe" -m %APP_MODEL_PATH% -p %APP_CONFIG_PARAM% -v %APP_VIDEO_PATH% --target_fps 25
popd
endlocal