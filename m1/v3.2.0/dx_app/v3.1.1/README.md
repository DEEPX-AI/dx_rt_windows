# dx_app v3.1.1 (Legacy Demo Applications)

This folder contains **legacy demo applications** from dx_app v3.1.1 for users who prefer the previous demo interface.

> ⚠️ **Note:** This is provided for backward compatibility. For the latest demos, use `setup.bat` and `run_demo.bat` in the parent `dx_app` folder.

## 📋 Prerequisites

Before running the demos, ensure that:

1. **Driver is installed** - Device Manager shows "DEEPX DEVICE"
2. **dxrtd service is running** - `dxrtd.exe --start` from `dx_rt/bin`
3. **Models and videos are downloaded** - Run `setup.bat` from the parent `dx_app` folder

```cmd
cd m1\v3.2.0\dx_app
setup.bat
```

## 🚀 Running Demo Applications

Navigate to the `x86_64_win` folder and run the desired batch file:

```cmd
cd m1\v3.2.0\dx_app\v3.1.1\x86_64_win
```

### Available Demo Scripts

| Script | Description | Model Used |
|--------|-------------|------------|
| **run_detector.bat** | Object detection demo | YOLOv5s |
| **run_classifier.bat** | Image classification demo | ImageNet classifier |
| **run_yolo.bat** | Basic YOLO inference | YOLOv7 |
| **run_yolo_pose.bat** | Pose estimation demo | YOLOv5Pose |
| **run_yolo_multi.bat** | Multi-stream YOLO demo | Multiple video sources |
| **run_ppu_yolo_multi.bat** | PPU-optimized multi-stream demo | PPU acceleration |
| **od_segmentation.bat** | Object detection + segmentation | YOLOv5 + DeepLabV3 |

### Example Usage

**Run Object Detection:**
```cmd
run_detector.bat
```

**Run Image Classification:**
```cmd
run_classifier.bat
```

**Run Pose Estimation:**
```cmd
run_yolo_pose.bat
```

**Run Object Detection + Segmentation:**
```cmd
od_segmentation.bat
```

## 📂 Folder Structure

```
v3.1.1/
├── bin/                    # Executable files
│   ├── run_detector.exe
│   ├── run_classifier.exe
│   ├── yolo.exe
│   ├── pose.exe
│   ├── yolo_multi.exe
│   ├── od_segmentation.exe
│   └── *.dll              # Required DLL files
├── example/                # JSON configuration files
│   ├── dx_postprocess/    # Post-processing configs
│   ├── run_classifier/    # Classifier configs
│   ├── run_detector/      # Detector configs
│   └── yolo_multi/        # Multi-stream configs
├── sample/                 # Sample images
└── x86_64_win/            # Batch scripts for Windows x64
```

## 🔧 Customization

Each batch script uses JSON configuration files located in the `example/` folder. You can modify these configurations or create your own to customize:

- Model path
- Video/image input source
- Post-processing parameters
- Detection thresholds

For example, `run_detector.bat` uses:
```
example\run_detector\yolov5s3_example.json
```

## 📖 More Information

For more demo applications and detailed documentation, visit the [dx_app repository](https://github.com/DEEPX-AI/dx_app).
