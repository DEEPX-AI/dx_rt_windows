# DeepX NPU Windows Runtime & Driver

**Windows runtime libraries, drivers, and demo applications for DEEPX AI accelerators.**

This repository provides **prebuilt binaries** for DeepX NPU devices on Windows, including PCIe device drivers, runtime environment, and demo applications for DX-M1 accelerators.

## 📦 Prebuilt Versions

| Component | Version |
|-----------|---------|
| **dx_rt** | v3.2.0 |
| **dx_app** | v3.0.0 (recommended) / v2.1.0 (legacy) |

## 📂 Repository Structure

```
dx_rt_windows/
└── m1/v3.2.0/
    ├── dxm1drv/           # PCIe driver package (dxm1drv.zip)
    ├── dx_rt/             # Runtime (bin/, include/, lib/, python/)
    │   ├── bin/           # dxrtd.exe, dxrt-cli.exe, run_model.exe, etc.
    │   ├── include/       # Header files (dxrt/*.h)
    │   ├── lib/           # Libraries and CMake config
    │   └── python/        # Python wheel packages and CLI tools
    │       ├── dx_engine-*.whl  # Python bindings (cp310~cp314)
    │       └── cli/       # Python CLI scripts
    └── dx_app/            # Demo applications
        ├── setup.bat      # Download models and sample videos
        ├── v3.0.0/        # Recommended menu-based demo app
        │   └── bin/       # YOLO, SCRFD, DeepLabV3, etc.
        └── v2.1.0/        # Legacy script-based demos
            ├── bin/       # Executables
            └── example/   # JSON configuration files
```

## 🚀 Supported Devices

| Device | Connection | Description |
|--------|------------|-------------|
| **DX-M1** | PCIe / M.2 / USB 4.0* | AI Accelerator |

> *USB 4.0 requires PCIe tunneling support (Thunderbolt™ or USB4)

## 💻 System Requirements

* **OS**: Windows 10 or later (x86_64)
* **Visual C++ Redistributable**: Microsoft Visual C++ 2015-2022 Redistributable (x64)
  - Download: https://aka.ms/vs/17/release/vc_redist.x64.exe
* **Hardware**: DeepX NPU device installed in PCIe slot, M.2 slot, or connected via USB 4.0
* **Privileges**: Administrator rights required for driver installation and service registration

## 📦 Quick Start

### 1. Install Visual C++ Redistributable
Download and install [Microsoft Visual C++ 2015-2022 Redistributable (x64)](https://aka.ms/vs/17/release/vc_redist.x64.exe)

### 2. Install Driver
Navigate to `m1/v3.2.0/dxm1drv/` and extract **`dxm1drv.zip`**.

Then, in the extracted folder (contains `dxm1drv.inf/.sys/.cat`), right-click **`dxm1drv.inf`** → Select **Install**.

Ensure the device appears correctly in Device Manager as "DEEPX DEVICE - M1 PCI CONTROLLER".

### 3. Configure Runtime Service
The `dxrtd.exe` daemon must run for NPU operations:

**Register as Windows Service:**
```cmd
cd m1\v3.2.0\dx_rt\bin
dxrtd.exe --install
dxrtd.exe --start
```

To manage the service later:
```cmd
cd m1\v3.2.0\dx_rt\bin
dxrtd.exe --stop
dxrtd.exe --uninstall
```

For full options: `dxrtd.exe -h`

### 4. Verify Installation
```cmd
cd m1\v3.2.0\dx_rt\bin
dxrt-cli.exe -s
```

If device information appears, installation is complete.

### 5. Run Demo Applications

The prebuilt demo applications (`dx_app`) are provided **only to verify** that the driver and `dxrtd` service are installed and working correctly.

**Step 1: Download Models and Videos**
```cmd
cd m1\v3.2.0\dx_app
setup.bat
```

This downloads DXNN models and sample videos to the `assets/` directory.

**Step 2: Run Demo (v3.0.0 - Recommended)**
```cmd
cd v3.0.0
run_demo.bat
```

This launches an interactive menu-based demo application where you can select various AI demos:
- Object detection (YOLOv5/v7/v8/v9/v10/v11/v12/v26)
- Face detection (SCRFD, YOLOv5Face)
- Pose estimation (YOLOv5Pose with/without PPU)
- Semantic segmentation (DeepLabV3)
- Combined YOLO + segmentation demos

> ⚠️ **Note:** The `dx_app` included here is a minimal demo for verification purposes only.
> 
> 💡 **For actual development and more demo applications**, please use the [dx_app repository](https://github.com/DEEPX-AI/dx_app).

## 🛠️ Available Tools

### Runtime Tools (`m1/v3.2.0/dx_rt/bin/`)

| Tool | Description |
|------|-------------|
| **dxrtd.exe** | Runtime daemon (must be running for NPU operations) |
| **dxrt-cli.exe** | Device management and firmware interface |
| **run_model.exe** | Run inference on `.dxnn` models |
| **parse_model.exe** | Inspect model information |
| **dxbenchmark.exe** | Performance benchmarking |
| **dxtop.exe** | Real-time NPU monitoring |

Run any tool with `-h` for detailed usage.

---

## 🐍 Python API (`m1/v3.2.0/dx_rt/python/`)

The `dx_engine` Python package provides Python bindings for the DXRT runtime, allowing you to run inference on DeepX NPU devices directly from Python.

### Supported Python Versions

| Python Version | Wheel File |
|----------------|------------|
| Python 3.10 | `dx_engine-1.1.4-cp310-cp310-win_amd64.whl` |
| Python 3.11 | `dx_engine-1.1.4-cp311-cp311-win_amd64.whl` |
| Python 3.12 | `dx_engine-1.1.4-cp312-cp312-win_amd64.whl` |
| Python 3.13 | `dx_engine-1.1.4-cp313-cp313-win_amd64.whl` |
| Python 3.14 | `dx_engine-1.1.4-cp314-cp314-win_amd64.whl` |

### Installation

```cmd
cd m1\v3.2.0\dx_rt\python
pip install dx_engine-1.1.4-cp312-cp312-win_amd64.whl
```

> Replace `cp312` with your Python version (e.g., `cp310` for Python 3.10).

### Python CLI Tools

Python-based command-line tools are available in `python/cli/`:

| Script | Description |
|--------|-------------|
| **run_model.py** | Run inference on `.dxnn` models (benchmark, single, target FPS modes) |
| **parse_model.py** | Inspect and parse model information |
| **run_model_prof.py** | Run inference with profiling support |

### Usage Examples

**Run Model (Benchmark Mode):**
```cmd
cd m1\v3.2.0\dx_rt\python\cli
python run_model.py -m model.dxnn -l 100
```

**Run Model (Single Inference):**
```cmd
python run_model.py -m model.dxnn -s -v
```

**Parse Model Information:**
```cmd
python parse_model.py -m model.dxnn -v
```

**run_model.py Options:**

| Option | Description |
|--------|-------------|
| `-m, --model` | Model file path (.dxnn) [required] |
| `-b, --benchmark` | Benchmark mode (maximum throughput, default) |
| `-s, --single` | Single run mode (sequential single-input inference) |
| `-v, --verbose` | Show NPU Processing Time and Latency |
| `-n, --npu` | NPU binding option (0: ALL, 1: NPU_0, 2: NPU_1, etc.) |
| `-l, --loops` | Number of inference loops (default: 30) |
| `-w, --warmup-runs` | Number of warmup runs before measurement |
| `-d, --devices` | Target NPU devices ('all', '0', '0,1,2', 'count:N') |
| `-f, --fps` | Target FPS for target FPS mode |
| `--use-ort` | Enable ONNX Runtime for CPU tasks |
| `--profiler` | Enable profiler |

Run `python run_model.py -h` for full usage details.

---

## 🎯 Demo Applications (`m1/v3.2.0/dx_app/`)

### Common Setup

Before running any demo, download models and sample videos:
```cmd
cd m1\v3.2.0\dx_app
setup.bat
```

---

### v3.0.0 – Recommended Demo App

The v3.0.0 demo provides an interactive menu to select and run various AI demos.

```cmd
cd m1\v3.2.0\dx_app\v3.0.0
run_demo.bat
```

**Available Demos:**

| Category | Models |
|----------|--------|
| **Object Detection** | YOLOv5, YOLOv7, YOLOv8, YOLOv9, YOLOv10, YOLOv11, YOLOv12, YOLOv26, YOLOX |
| **Object Detection (PPU)** | YOLOv5-PPU, YOLOv7-PPU |
| **Face Detection** | SCRFD, SCRFD-PPU, YOLOv5Face |
| **Pose Estimation** | YOLOv5Pose, YOLOv5Pose-PPU |
| **Segmentation** | DeepLabV3, YOLOv8Seg |
| **Combined** | YOLOv7 + DeepLabV3 |
| **Classification** | EfficientNet |

---

### v2.1.0 – Legacy Demo Apps

The v2.1.0 directory contains script-based demos with JSON configuration files.

```cmd
cd m1\v3.2.0\dx_app\v2.1.0
```

| Script | Description |
|--------|-------------|
| **run_detector.bat** | Object detection demo |
| **run_classifier.bat** | Image classification demo |
| **run_yolo.bat** | Basic YOLO inference demo |
| **run_yolo_pose.bat** | Pose estimation demo |
| **run_yolo_multi.bat** | Multi-stream YOLO demo |
| **run_ppu_yolo_multi.bat** | PPU-accelerated multi-stream YOLO |
| **od_segmentation.bat** | Object detection + segmentation |

**JSON Configuration:**

Configuration files are located in `v2.1.0/example/`:
- `run_classifier/imagenet_example.json`
- `run_detector/scrfd_example.json`, `yolov5s3_example.json`, etc.
- `yolo_multi/` – multi-stream configurations

See [dx_app/README.md](m1/v3.2.0/dx_app/README.md) for detailed instructions.

## ✅ Verification Checklist

- [ ] Driver installed (Device Manager shows "DEEPX DEVICE")
- [ ] `dxrtd.exe` is running (check Task Manager)
- [ ] `dxrt-cli.exe -s` shows device information
- [ ] No errors in Device Manager

## 🐛 Troubleshooting

**Device not detected?**
- Verify proper PCIe/M.2 slot installation
- Check Device Manager for warnings
- Try reinstalling driver

**dxrtd.exe not running?**
- Run manually from `dx_rt/bin` folder
- Check Windows Firewall/antivirus
- Run as Administrator

## 🤝 Contributing

This repository hosts binary releases only. For issues, please submit a ticket with:
- Windows version
- Device model and connection type
- Error messages or logs

## 📄 License

See [LICENSE](LICENSE) for usage terms and distribution rights.