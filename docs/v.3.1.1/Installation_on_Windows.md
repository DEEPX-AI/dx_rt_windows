# Installation Guide on Windows

This document provides step-by-step instructions for installing the DeepX NPU driver and setting up the runtime environment on Windows.

## 1. Prerequisite
* **OS:** Windows 10 or later (x86_64)
* **Visual C++ Redistributable:** Microsoft Visual C++ 2015-2022 Redistributable (x64)
  - Download from: https://aka.ms/vs/17/release/vc_redist.x64.exe
  - Required for running DeepX runtime and demo applications
* **Hardware:** DEEPX NPU Device (e.g., DX-M1) connected via:
  - PCIe slot
  - M.2 slot
  - USB 4.0 (requires USB4 PCIe tunneling support)
* **Administrator Privileges:** Required for driver installation.

---

## 2. Driver Installation

The driver package contains the necessary PCIe device driver files for manual installation on Windows.

### Step 1: Connect the Device
Ensure your DeepX NPU device is properly connected to your system:
* For PCIe or M.2 connection: Install the device in an available PCIe slot or M.2 slot
* For USB connection: Connect via a USB 4.0 port that supports PCIe tunneling (Thunderbolt™ or USB4)
  - Note: Standard USB 3.x ports are not supported. USB4 PCIe tunneling capability is required.

### Step 2: Locate Driver Files
The driver files are located in:
> **Directory:** `m1/v.3.1.1/dxm1drv/`

The directory contains the following file:
* `dxm1drv.zip` - Driver package (contains `dxm1drv.inf`, `dxm1drv.sys`, `dxm1drv.cat`)

Extract `dxm1drv.zip` first. After extraction, the driver files will be available under the extracted `dxm1drv/` folder.

### Step 3: Install the Driver

#### Option A: Install via INF File (Simplest Method)
1. Navigate to the `m1/v.3.1.1/dxm1drv/` directory.
2. Extract **dxm1drv.zip**.
3. Open the extracted `dxm1drv/` folder.
4. Right-click on the **dxm1drv.inf** file.
3. Select **Install** from the context menu.
4. If prompted with a security warning about the driver publisher, click **Install** or **Yes** to proceed.
5. Wait for the installation to complete.

#### Option B: Install via Device Manager
1. Right-click on the **Start menu** and select **Device Manager**.
2. Locate your DeepX NPU device. It may appear under:
   - **Other devices** (if not yet installed)
   - **Unknown devices** (with a yellow exclamation mark)
3. Right-click on the device and select **Update driver**.
4. Choose **Browse my computer for drivers**.
5. Click **Browse** and navigate to the extracted driver folder that contains `dxm1drv.inf`.
6. Click **Next** and follow the on-screen instructions to complete the installation.
7. If prompted with a security warning about the driver publisher, click **Install this driver software anyway**.

#### Option C: Install via Command Line (Advanced)
Open Command Prompt or PowerShell as Administrator and run:
```powershell
pnputil /add-driver "path\to\extracted\dxm1drv\dxm1drv.inf" /install
```

### Step 4: Verify Installation
1. Open **Device Manager** (Right-click Start menu → Device Manager).
2. Look for **DeepX AI Accelerator** or **DX-M1** device.
3. Verify that the device is listed without any warning icons.
4. You can right-click the device and select **Properties** → **Driver** tab to confirm the driver version.

---

## 3. Runtime Environment Setup

After installing the driver, you must set up the runtime libraries and tools.

The runtime files are located in: **`m1/v.3.1.1/dx_rt/`**

Directory layout:
* **`m1/v.3.1.1/dx_rt/bin/`** - executables and runtime DLLs
* **`m1/v.3.1.1/dx_rt/include/`** - C/C++ headers
* **`m1/v.3.1.1/dx_rt/lib/`** - libraries and CMake config files

### Step 1: Understanding the Tools
The package contains the following components:

#### Core Libraries
* **`dxrt.dll`** - Main runtime library for NPU inference (in `dx_rt/bin/`)
* **`onnxruntime.dll`** - ONNX Runtime library for CPU operations (if compiled with ONNX support, in `dx_rt/bin/`)

#### System Service
* **`dxrtd.exe`** - DeepX Runtime Daemon (in `dx_rt/bin/`)
  - Manages multi-process and multi-device support
  - Must be running for NPU operations
  - Handles device resource allocation and coordination

#### Command-Line Tools

* **`dxrt-cli.exe`** - Device management and firmware interface tool
  - Check device status: `dxrt-cli.exe -s`
  - Get device information: `dxrt-cli.exe -i`
  - Monitor device status: `dxrt-cli.exe -m <seconds>`
  - Reset NPU device: `dxrt-cli.exe -r`
  - Show version requirements: `dxrt-cli.exe -v`
  - Update firmware: `dxrt-cli.exe -u <firmware.bin>`

* **`parse_model.exe`** - Model inspection tool
  - Parse and display `.dxnn` model information
  - Usage: `parse_model.exe -m <model.dxnn>`
  - Options:
    - `-v` : Verbose output with task dependencies
    - `-o <file>` : Save output to file
    - `-j` : Extract JSON data (graph_info, rmap_info)

* **`run_model.exe`** - Single model inference tool
  - Run inference on a single model
  - Usage: `run_model.exe -m <model.dxnn> -l <loops>`
  - Options:
    - `-i <input>` : Specify input file
    - `-o <output>` : Specify output file
    - `-l <loops>` : Number of inference loops
    - `-t <seconds>` : Run for specified time duration
    - `-w <count>` : Warmup runs before measurement
    - `-v` : Verbose output with performance metrics
    - `--use-ort` : Enable ONNX Runtime for CPU operations

* **`dxbenchmark.exe`** - Performance benchmarking utility
  - Batch performance testing for multiple models
  - Generates HTML reports with visualizations
  - Usage: `dxbenchmark.exe --dir <model_directory> -l <loops>`
  - Options:
    - `--dir <path>` : Model directory
    - `-l <loops>` : Number of inference loops (default: 30)
    - `-t <seconds>` : Time duration to run
    - `--warmup <count>` : Warmup iterations
    - `--result-path <path>` : Output directory for reports
    - `--recursive` : Include subdirectories
    - `-v` : Show detailed performance metrics

* **`dxtop.exe`** - Real-time NPU monitoring utility
  - Terminal-based monitoring tool
  - Displays NPU core utilization and DRAM usage
  - Real-time device status updates
  - Usage: `dxtop.exe`

### Step 2: Configure `dxrtd.exe` (Startup Setup)
**Important:** The `dxrtd.exe` (DeepX Runtime Daemon) must be running for the NPU to function properly. It is recommended to configure it to run automatically at Windows startup.

**Note:** `dxrtd.exe --run` (or `-r`) is intended for Windows SCM (Service Control Manager) and should not be used for normal interactive execution.

Choose one of the following methods to configure automatic startup:

#### Option A: Using Windows Service (Recommended for Production)
1. Open Command Prompt or PowerShell **as Administrator**.
2. Navigate to the `m1/v.3.1.1/dx_rt/bin/` directory:
   ```powershell
   cd path\to\m1\v.3.1.1\dx_rt\bin
   ```
3. Install the Windows service:
   ```powershell
   .\dxrtd.exe --install
   ```
4. Start the service:
   ```powershell
   .\dxrtd.exe --start
   ```

5. Verify the service is running:
   - Check the Windows Services list (`services.msc`) for the DeepX runtime service
   - Or confirm the `dxrtd.exe` process is running in Task Manager

**To remove the service later:**
```powershell
.\dxrtd.exe --stop
.\dxrtd.exe --uninstall
```

#### Option B: Using Task Scheduler (Alternative)
1. Press `Win + R` and type `taskschd.msc` to open Task Scheduler.
2. In the right panel, click **Create Task** (not "Create Basic Task").
3. In the **General** tab:
   - Name: `DeepX Runtime Daemon`
   - Check **Run with highest privileges**
   - Check **Run whether user is logged on or not**
4. In the **Triggers** tab:
   - Click **New**
   - Begin the task: **At startup**
   - Click **OK**
5. In the **Actions** tab:
   - Click **New**
   - Action: **Start a program**
   - Program/script: Browse and select `dxrtd.exe` from `m1/v.3.1.1/dx_rt/bin/`
   - Click **OK**
6. In the **Conditions** tab:
   - Uncheck **Start the task only if the computer is on AC power** (if applicable)
7. In the **Settings** tab:
   - Check **Allow task to be run on demand**
   - Check **If the task fails, restart every: 1 minute**
8. Click **OK** and enter your Windows password if prompted.
9. Restart your computer or right-click the task and select **Run** to start immediately.

---

## 4. Demo Applications Setup (Optional)

The DeepX SDK includes pre-built demo applications that demonstrate NPU capabilities with object detection, classification, and pose estimation.

### Step 1: Download Models and Sample Videos

Before running demo applications, you need to download the required DXNN models and sample video files.

1. Navigate to the `m1/v.3.1.1/dx_app/` directory:
   ```cmd
   cd path\to\m1\v.3.1.1\dx_app
   ```

2. Run the setup script:
   ```cmd
   setup.bat
   ```

   This script will:
   - Download pre-trained DXNN models (models-2_1_0.tar.gz) from DeepX SDK repository
   - Download sample video files (sample_videos.tar.gz) for testing
   - Extract them to `assets/models/` and `assets/videos/` directories
   - Clean up temporary archive files

**Note:** The download may take several minutes depending on your internet connection. If the directories already exist, the script will skip downloading.

### Step 2: Run Demo Applications

The demo applications are located in `m1/v.3.1.1/dx_app/scripts/x86_64_win/`. Each script runs a specific type of demo:

#### Available Demos:

| Script | Description | Example Model |
|--------|-------------|---------------|
| **run_detector.bat** | Object detection demo | YOLOv5, YOLOv7, YOLOv8, YOLOv9, YOLOX |
| **run_classifier.bat** | Image classification demo | ImageNet classifiers |
| **run_yolo.bat** | YOLO model inference | YOLOv7, YOLOv5S |
| **run_yolo_pose.bat** | Pose estimation demo | YOLOv5Pose |
| **run_yolo_multi.bat** | Multi-stream YOLO demo (one window per source) | Single YOLO model, multiple video sources |
| **run_ppu_yolo_multi.bat** | PPU-optimized multi-stream YOLO demo | YOLO with post-processing, multiple video sources |
| **od_segmentation.bat** | Object detection & segmentation | Combined detection models |

#### Running a Demo:

1. Navigate to the scripts directory:
   ```cmd
   cd m1\v.3.1.1\dx_app\scripts\x86_64_win
   ```

2. Run any demo script by double-clicking it or executing from command line:
   ```cmd
   run_detector.bat
   ```
   or
   ```cmd
   run_yolo.bat
   ```

3. A new command window will open showing the inference results in real-time.

**Note:** Ensure that `dxrtd.exe` is running before executing any demo application.

### Step 3: Customizing Demos

Each demo uses configuration JSON files located in the `example/` directory. You can modify these configurations to:
- Change input video sources
- Adjust model parameters
- Modify post-processing settings
- Configure output options

Example configuration files:
- `example/run_detector/yolov5s3_example.json`
- `example/run_classifier/imagenet_example.json`
- `example/yolo_multi/yolo_multi_demo.json`
- `example/yolo_multi/yolo_multi_input_source_demo.json`

---

## 5. Verification

To ensure everything is set up correctly, follow these verification steps:

### Step 1: Check Device Status
Open Command Prompt or PowerShell and navigate to the `m1/v.3.1.1/dx_rt/bin/` directory:

```cmd
cd path\to\m1\v.3.1.1\dx_rt\bin
```

Run the device status check:
```cmd
dxrt-cli.exe -s
```

**Expected Output:**
- Device status information
- Driver version
- Firmware version
- Device count and IDs

If you see device information without errors, the driver is correctly installed.

### Step 2: Verify Runtime Daemon
Check if `dxrtd.exe` is running:

**Using Task Manager:**
1. Press `Ctrl + Shift + Esc` to open Task Manager
2. Go to the **Details** tab
3. Look for `dxrtd.exe` in the process list

**Using Command Line:**

For Command Prompt (cmd):
```cmd
tasklist | findstr dxrtd.exe
```

For PowerShell:
```powershell
Get-Process | Where-Object {$_.Name -eq "dxrtd"}
```

Or simply (works in both cmd and PowerShell):
```
tasklist | findstr dxrtd.exe
```

If `dxrtd.exe` is not running, start it manually or check your startup configuration from Step 3.

### Step 3: Get Detailed Device Information
For comprehensive device information:
```cmd
dxrt-cli.exe -i
```

This displays detailed hardware information, temperature, and utilization status.

### Step 4: Monitor NPU in Real-Time (Optional)
To verify NPU functionality with real-time monitoring:
```cmd
dxtop.exe
```

This launches a terminal-based monitoring interface showing:
- NPU core utilization
- Memory usage
- Device temperature
- Active processes

Press `q` to quit the monitoring tool.

### Step 5: Test with a Model (If Available)
If you have a `.dxnn` model file, you can verify inference functionality:

**Parse the model:**
```cmd
parse_model.exe -m your_model.dxnn
```

**Run inference:**
```cmd
run_model.exe -m your_model.dxnn -l 10
```

This runs 10 inference loops and displays performance metrics.

---

## Troubleshooting

### Device Not Detected
- Verify the device is properly seated in the PCIe/M.2 slot
- Check Device Manager for any warning icons
- Try reinstalling the driver using Option A (INF right-click install)

### dxrtd.exe Not Running
- Manually run `dxrtd.exe` from the `dx_rt/bin/` directory
- Check if it's blocked by Windows Firewall or antivirus software
- Run as Administrator if permission issues occur

### Driver Installation Fails
- Ensure you have Administrator privileges
- Disable Driver Signature Enforcement temporarily (for testing only):
  1. Restart Windows
  2. Press F8 during boot (or Shift + Restart → Troubleshoot → Advanced Options → Startup Settings → Restart → Press 7)
  3. Select "Disable driver signature enforcement"
  4. Install the driver

### Performance Issues
- Ensure `dxrtd.exe` is running
- Check for Windows power management settings (set to High Performance)
- Verify adequate cooling for the NPU device
- Use `dxtop.exe` to monitor thermal throttling

---

## Next Steps

Once verification is complete, your DeepX NPU is ready for use. For detailed usage of each tool, run:
```cmd
<tool_name>.exe -h
```

For example:
```cmd
run_model.exe -h
dxbenchmark.exe -h
```