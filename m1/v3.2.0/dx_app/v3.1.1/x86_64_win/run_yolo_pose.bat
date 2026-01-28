@echo off
setlocal
pushd ..\
set PATH=..\..\dx_rt\bin;%PATH%

set "APP_MODEL_PATH=..\assets\models\YOLOV5Pose640_1.dxnn"
set "APP_CONFIG_PARAM=0"
set "APP_VIDEO_PATH=..\assets\videos\dance-group2.mov"

start cmd /K "bin\pose.exe" -m %APP_MODEL_PATH% -p %APP_CONFIG_PARAM% -v %APP_VIDEO_PATH%
popd
endlocal