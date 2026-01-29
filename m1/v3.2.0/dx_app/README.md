# dx_app Demo Applications

This directory contains demo applications for the DEEPX M1 runtime:

- **v3.0.0** – recommended, menu-based demo app
- **v2.1.0** – legacy demos kept for backward compatibility

Use the v3.0.0 demos if possible; use v2.1.0 only if you need the old interface or scripts.

## Prerequisites (Common)

Before running any demo, make sure that:

1. **Driver is installed**  
	Windows Device Manager should show "DEEPX DEVICE".
2. **dxrtd service is running**  
	From the `dx_rt/bin` directory, start the service:

	```cmd
	dxrtd.exe --start
	```

3. **Models and videos are downloaded**  
	From the parent `dx_app` directory, run `setup.bat` once:

	```cmd
	cd m1\v3.2.0\dx_app
	setup.bat
	```

---

## v3.0.0 – Recommended Demo App

The v3.0.0 demo provides a simple text menu that lets you choose which AI demo to run.

### How to Run

```cmd
cd dx_app\v3.0.0
.\run_demo.bat
```

You will see a numbered menu in the console. Enter a number to run a demo, for example:

- Object detection (YOLOv7 / YOLOv8N / YOLOv9S / YOLOv26S)
- Object detection with PPU (YOLOv5S, YOLOv7, SCRFD, etc.)
- Face detection
- Pose estimation (with / without PPU)
- Semantic segmentation
- Combined YOLO + segmentation demos


---

## v2.1.0 – Legacy Demo Apps

The v2.1.0 directory contains the older, script-based demo applications. Each feature has its own batch file and JSON configuration.

### Location

```cmd
cd dx_app\v2.1.0
```

### Main Batch Scripts

Run these from the `v2.1.0` directory:

- `od_segmentation.bat` – object detection + segmentation demo
- `run_classifier.bat` – image classification demo
- `run_detector.bat` – object detection demo
- `run_ppu_yolo_multi.bat` – PPU-accelerated multi-stream YOLO demo
- `run_yolo_multi.bat` – multi-stream YOLO demo
- `run_yolo_pose.bat` – pose estimation demo
- `run_yolo.bat` – basic YOLO inference demo

Example:

```cmd
.\run_detector.bat
```

```cmd
.\run_classifier.bat
```

### Configuration (JSON)

Some demos use JSON configuration files under the `example/` directory, for example:

- `example\run_classifier\imagenet_example.json`
- `example\run_detector\yolov5s3_example.json`

For demos that use JSON, you can edit these files to customize:

- Model paths
- Input image / video sources
- Post-processing parameters
- Detection thresholds

