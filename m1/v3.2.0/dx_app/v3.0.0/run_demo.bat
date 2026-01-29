@echo off
setlocal EnableDelayedExpansion

REM Get script directory
set "SCRIPT_DIR=%~dp0"
set "DX_APP_PATH=%SCRIPT_DIR:~0,-1%"
set "MODELS_VERSION=models-2_2_0"

pushd "%DX_APP_PATH%"

echo [INFO] DX_APP_PATH: %DX_APP_PATH%

REM Check if bin directory exists and contains files
if not exist ".\bin" (
    echo [INFO] dx_app is not built. Building dx_app first before running the demo.
    call build.bat
) else (
    dir /b ".\bin\*.exe" >nul 2>&1
    if errorlevel 1 (
        echo [INFO] dx_app is not built. Building dx_app first before running the demo.
        call build.bat
    )
)

REM Check if models and videos directories exist
set "MODELS_OK=0"
set "VIDEOS_OK=0"

if exist "..\assets\models\%MODELS_VERSION%" set "MODELS_OK=1"
if exist "..\assets\videos" set "VIDEOS_OK=1"

if "%MODELS_OK%"=="1" if "%VIDEOS_OK%"=="1" (
    echo [INFO] Models and Videos directory already exists. Skipping download.
) else (
    echo [INFO] Models and Videos not found. Please run setup manually.
)

REM Set PATH to include DXRT DLLs
if defined DXRT_DIR (
    set "PATH=%DXRT_DIR%\bin;%PATH%"
    echo [INFO] Added DXRT bin to PATH
)

REM Display menu
echo.
echo ========================================
echo        DEEPX AI Demo Selection
echo ========================================
echo  0: Object Detection (YOLOv7)
echo  1: Object Detection with PPU (YOLOv7-640)
echo  2: Object Detection (YOLOv8N)
echo  3: Object Detection (YOLOv9S)
echo  4: Object Detection With PPU (YOLOv5S-512)
echo  5: Face Detection (YOLOV5S_Face)
echo  6: Face Detection With PPU (SCRFD500M-640)
echo  7: Pose Estimation
echo  8: Pose Estimation With PPU (YOLOv5Pose-640)
echo  9: Semantic Segmentation
echo 10: Multi-Model Object Detection (YOLOv7) ^& Segmentation
echo 11: Object Detection (YOLOv26S)
echo ========================================
echo.

REM Get user input with default timeout
set "SELECT=0"
set /p "SELECT=Which AI demo do you want to run? (default:0): "

REM Validate input - if empty, use default
if "%SELECT%"=="" set "SELECT=0"

REM Execute selected demo
if "%SELECT%"=="0" (
    echo [INFO] Running YOLOv7 Object Detection...
    "%DX_APP_PATH%\bin\yolov7_async.exe" -m ..\assets\models\%MODELS_VERSION%\YoloV7.dxnn -v ..\assets\videos\snowboard.mp4
    goto :end
)
if "%SELECT%"=="1" (
    echo [INFO] Running YOLOv7 PPU Object Detection...
    "%DX_APP_PATH%\bin\yolov7_ppu_async.exe" -m ..\assets\models\%MODELS_VERSION%\YoloV7_PPU.dxnn -v ..\assets\videos\snowboard.mp4
    goto :end
)
if "%SELECT%"=="2" (
    echo [INFO] Running YOLOv8N Object Detection...
    "%DX_APP_PATH%\bin\yolov8_async.exe" -m ..\assets\models\%MODELS_VERSION%\YoloV8N.dxnn -v ..\assets\videos\boat.mp4
    goto :end
)
if "%SELECT%"=="3" (
    echo [INFO] Running YOLOv9S Object Detection...
    "%DX_APP_PATH%\bin\yolov9_async.exe" -m ..\assets\models\%MODELS_VERSION%\YOLOV9S.dxnn -v ..\assets\videos\carrierbag.mp4
    goto :end
)
if "%SELECT%"=="4" (
    echo [INFO] Running YOLOv5S PPU Object Detection...
    "%DX_APP_PATH%\bin\yolov5_ppu_async.exe" -m ..\assets\models\%MODELS_VERSION%\YOLOV5S_PPU.dxnn -v ..\assets\videos\boat.mp4
    goto :end
)
if "%SELECT%"=="5" (
    echo [INFO] Running YOLOV5S Face Detection...
    "%DX_APP_PATH%\bin\yolov5face_async.exe" -m ..\assets\models\%MODELS_VERSION%\YOLOV5S_Face-1.dxnn -v ..\assets\videos\dance-group.mov
    goto :end
)
if "%SELECT%"=="6" (
    echo [INFO] Running SCRFD500M PPU Face Detection...
    "%DX_APP_PATH%\bin\scrfd_ppu_async.exe" -m ..\assets\models\%MODELS_VERSION%\SCRFD500M_PPU.dxnn -v ..\assets\videos\dance-group.mov
    goto :end
)
if "%SELECT%"=="7" (
    echo [INFO] Running Pose Estimation...
    "%DX_APP_PATH%\bin\yolov5pose_async.exe" -m ..\assets\models\%MODELS_VERSION%\YOLOV5Pose640_1.dxnn -v ..\assets\videos\dance-solo.mov
    goto :end
)
if "%SELECT%"=="8" (
    echo [INFO] Running Pose Estimation with PPU...
    "%DX_APP_PATH%\bin\yolov5pose_ppu_async.exe" -m ..\assets\models\%MODELS_VERSION%\YOLOV5Pose_PPU.dxnn -v ..\assets\videos\dance-solo.mov
    goto :end
)
if "%SELECT%"=="9" (
    echo [INFO] Running Semantic Segmentation...
    "%DX_APP_PATH%\bin\deeplabv3_async.exe" -m ..\assets\models\%MODELS_VERSION%\DeepLabV3PlusMobileNetV2_2.dxnn -v ..\assets\videos\blackbox-city-road.mp4
    goto :end
)
if "%SELECT%"=="10" (
    echo [INFO] Running Multi-Model Object Detection ^& Segmentation...
    "%DX_APP_PATH%\bin\yolov7_x_deeplabv3_async.exe" -y ..\assets\models\%MODELS_VERSION%\YoloV7.dxnn -d ..\assets\models\%MODELS_VERSION%\DeepLabV3PlusMobileNetV2_2.dxnn -v ..\assets\videos\blackbox-city-road2.mov
    goto :end
)
if "%SELECT%"=="11" (
    echo [INFO] Running YOLOv26S Object Detection...
    "%DX_APP_PATH%\bin\yolov26_async.exe" -m ..\assets\models\%MODELS_VERSION%\yolo26s-1.dxnn -v ..\assets\videos\snowboard.mp4
    goto :end
)

echo [ERROR] Invalid selection: %SELECT%
echo Please select a number between 0 and 11.

:end
popd
endlocal
