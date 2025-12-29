@echo off
setlocal
pushd ..\..\
set PATH=..\dx_rt\bin;%PATH%

set "APP_JSON_PATH=example\run_classifier\imagenet_example.json"

start cmd /K "bin\run_classifier.exe" -c %APP_JSON_PATH%
popd
endlocal