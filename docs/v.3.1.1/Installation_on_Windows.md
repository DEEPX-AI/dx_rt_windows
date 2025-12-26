# Installation Guide on Windows

This document provides step-by-step instructions for installing the DeepX NPU driver and setting up the runtime environment on Windows.

## 1. Prerequisite
* **OS:** Windows 10 or later (x86_64)
* **Hardware:** DEEPX NPU Device (e.g., DX-M1)
* **Administrator Privileges:** Required for driver installation.

---

## 2. Driver Installation

The driver installer simplifies the process of setting up the DX-M1 device. 

### Step 1: Connect the Device
Ensure your DeepX NPU device is properly connected to your system.

### Step 2: Run the Installer
Locate and run the installer executable:
> **File:** `m1/v.3.1.1/dxm1drv/` directory

### Step 3: Check Device Status

The installer will automatically detect the device status.

#### Scenario A: Device Not Found
If the device is not connected or not recognized:

* **Status:** "Device not found!!!"
* **Action:** Check the physical connection of the device and click **"Open Device Manager"** to troubleshoot.

#### Scenario B: Device Found & Ready to Install
If the device is connected, the installer will display the current driver status and the version available for installation.

* **Top Section:** Displays the new driver package version (e.g., `dxm1drv.zip`).
* **Green Button ("Installed" or "Install"):** * Click this button to install or update the driver.
    * The version number to the left of the button indicates the version that will be installed.
* **Bottom Section ("Driver OK!!!"):** * Shows the currently installed driver version on your system.
    * **"Number of DX-M1 devices found"** indicates the count of recognized devices.

### Step 4: Verify Installation
After clicking the **Install** button and completing the process, you can click **"Open Device Manager"** at the bottom left to verify that the "DeepX AI Accelerator" device is listed correctly without errors.

---

## 3. Runtime Environment Setup

After installing the driver, you must set up the runtime libraries and tools.

### Step 1: Locate Runtime Files
The runtime files are located in:
> **Directory:** `m1/v.3.1.1/dx_rt/`

### Step 2: Understanding the Tools
The package contains the following key components:

* **Core Libraries:** `dxrt.dll`, `onnxruntime.dll`
* **System Service:** `dxrtd.exe` (DeepX Runtime Daemon)
* **Utilities:**
    * `check_versions.exe`: Check version of libraries and driver.
    * `dxtop.exe`: Monitor NPU utilization.
    * `dxbenchmark.exe`: Benchmark performance.
    * `dxrt-cli.exe`: Command-line interface tool.
* **Sample Applications:** `run_model.exe`, `run_async_model.exe`, etc.

### Step 3: Configure `dxrtd.exe` (Startup Setup)
**Important:** The `dxrtd.exe` (DeepX Runtime Daemon) must be running for the NPU to function properly. It is recommended to configure it to run automatically at Windows startup.

**Manual Setup Procedure:**
1.  Right-click `dxrtd.exe` in the `m1/v.3.1.1/dx_rt/` folder and select **Create shortcut**.
2.  Press `Win + R` on your keyboard to open the Run dialog.
3.  Type `shell:startup` and press Enter. This opens the Windows Startup folder.
4.  Move the **shortcut** you created in step 1 into this Startup folder.
5.  Restart your computer or manually run `dxrtd.exe` once to start the service immediately.

---

## 4. Verification

To ensure everything is set up correctly:

1.  Open a command prompt (cmd) or PowerShell.
2.  Navigate to the `m1/v.3.1.1/dx_rt/` directory.
3.  Run the version check tool:
    ```powershell
    .\dxrt-cli.exe -s
    ```
4.  If the output shows valid version numbers for both the driver and runtime, the installation is complete.