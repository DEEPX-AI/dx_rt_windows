@echo off
setlocal

rem Always work from the v2.1.0 directory where this script lives
pushd "%~dp0"

set PATH=..\..\dx_rt\bin;%PATH%

set "APP_JSON_PATH=example\run_detector\yolov5s3_example.json"

start cmd /K "bin\run_detector.exe" -c %APP_JSON_PATH%
popd
endlocal