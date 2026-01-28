# DeepX NPU Windows Runtime & Driver

**Windows runtime libraries, drivers, and demo applications for DEEPX AI accelerators.**

This repository provides **prebuilt binaries** for DeepX NPU devices on Windows, including PCIe device drivers, runtime environment, and demo applications for DX-M1 accelerators.

## 📦 Prebuilt Versions

| Component | Version |
|-----------|---------|
| **dx_rt** | 3.2.0 |
| **dx_app** | 3.3.0 |

## 📂 Repository Structure

```
dx_rt_windows/
└── m1/v3.2.0/
    ├── dxm1drv/           # PCIe driver package (dxm1drv.zip)
    ├── dx_rt/             # Runtime (bin/, include/, lib/)
    └── dx_app/            # Demo applications
        └── v3.1.1/        # Legacy demo applications (optional)
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

Ensure the device appears correctly in Device Manager as "DEEPX DEVICE".

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

**Step 2: Run Demo**
```cmd
run_demo.bat
```

This runs the demo application to verify NPU operation.

> ⚠️ **Note:** The `dx_app` included here is a minimal demo for verification purposes only.
> 
> 💡 **For actual development and more demo applications**, please use the [dx_app repository](https://github.com/DEEPX-AI/dx_app).

## 🛠️ Available Tools

### Runtime Tools (`m1/v3.2.0/dx_rt/bin/`)

| Tool | Description |
|------|-------------|
| **dxrtd.exe** | Runtime daemon (must be running) |
| **dxrt-cli.exe** | Device management and firmware interface |
| **run_model.exe** | Run inference on `.dxnn` models |
| **parse_model.exe** | Inspect model information |
| **dxbenchmark.exe** | Performance benchmarking |
| **dxtop.exe** | Real-time NPU monitoring |

### Demo Applications (`m1/v3.2.0/dx_app/`)

| Script | Description |
|--------|-------------|
| **setup.bat** | Download models and sample videos |
| **run_demo.bat** | Run demo to verify NPU operation |

Run any tool with `-h` for detailed usage.

### Legacy Demo Applications (`m1/v3.2.0/dx_app/v3.1.1/`)

For users who prefer the previous demo interface, legacy demo applications from v3.1.1 are included.

Navigate to `x86_64_win` folder and run the batch scripts:

```cmd
cd m1\v3.2.0\dx_app\v3.1.1\x86_64_win
run_detector.bat
```

| Script | Description |
|--------|-------------|
| **run_detector.bat** | Object detection (YOLOv5) |
| **run_classifier.bat** | Image classification |
| **run_yolo.bat** | Basic YOLO inference |
| **run_yolo_pose.bat** | Pose estimation |
| **run_yolo_multi.bat** | Multi-stream YOLO |
| **od_segmentation.bat** | Object detection + segmentation |

See [v3.1.1/README.md](m1/v3.2.0/dx_app/v3.1.1/README.md) for detailed instructions.

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