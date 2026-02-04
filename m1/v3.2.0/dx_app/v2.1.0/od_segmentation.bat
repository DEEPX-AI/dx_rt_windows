@echo off
setlocal

rem Always work from the v2.1.0 directory where this script lives
pushd "%~dp0"

set PATH=..\..\dx_rt\bin;%PATH%

set "APP_MODEL0_PATH=..\assets\models\YOLOV5S_3.dxnn"
set "APP_MODEL0_PARAM=1"
set "APP_MODEL1_PATH=..\assets\models\DeepLabV3PlusMobileNetV2_2.dxnn"
set "APP_MODEL1_PARAM=0"
set "APP_VIDEO_PATH=..\assets\videos\blackbox-city-road.mp4"
start cmd /K "bin\od_segmentation.exe" -m0 %APP_MODEL0_PATH% -p0 %APP_MODEL0_PARAM% -m1 %APP_MODEL1_PATH% -p1 %APP_MODEL1_PARAM% -v %APP_VIDEO_PATH%

popd
endlocal