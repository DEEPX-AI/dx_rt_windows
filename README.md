# DeepX NPU Windows Runtime & Driver

**Windows runtime libraries, drivers, and installation documentation for DEEPX AI accelerators.**

This repository contains the official distribution of the DeepX Windows Runtime (DX-RT) and Kernel Drivers. Unlike the source repository, this repository provides **prebuilt binaries and installers** intended for end-users and developers who need to set up the execution environment for DeepX NPU devices.

## 📂 Repository Structure

The repository is organized as follows:

* **`installers/`**: Contains the Windows installer executable for the NPU driver.
* **`prebuilt/`**: Contains precompiled runtime libraries, headers, and tools.
* **`docs/`**: Detailed installation guides and manuals.

## 🚀 Supported Devices

| Device Type | Model Name | Description |
| :--- | :--- | :--- |
| DX_M1 | **DX-M1** | AI Accelerator |

## 💻 System Requirements

Before installing, ensure your system meets the following requirements:

* **Operating System**: Windows 10 or later (x86_64)
* **Hardware**: DeepX NPU Device (e.g., DX-M1) connected via PCIe.

## 📦 Installation

For detailed step-by-step instructions, please refer to the [**Installation Guide**](docs/v3.1.0/Installation_on_Windows.md).

### 1. Driver Installation
The driver installer is located in the `installers` directory.

1.  Navigate to `installers/v.3.1.0/`.
2.  Run the **`dx_rt_windows_driver_v1.8.0_x86_64.exe`** file.
3.  Follow the on-screen instructions to complete the installation.
4.  **Reboot** your system if prompted.

### 2. Runtime Environment Setup
The runtime libraries are required to run applications using the DeepX NPU.

1.  Navigate to `prebuilt/v3.1.0/`.
2.  Extract **`dx_rt_windows_prebuilt_v3.1.0_x86_64.zip`** to your desired location (e.g., `C:\DeepX\Runtime`).
3.  Add the `bin` folder path from the extracted directory to your system's **PATH** environment variable.

## ✅ Verification

After installation, you can verify the setup by checking the Windows Device Manager:

1.  Open **Device Manager**.
2.  Look for the **"DeepX AI Accelerator"** (or similar) entry under "System devices" or a dedicated category.
3.  Ensure the device status indicates it is working properly.

## 📖 Documentation

* [Installation on Windows](docs/v3.1.0/Installation_on_Windows.md): Comprehensive guide for driver and runtime installation.

## 🤝 Contributing

**Note:** This repository hosts binary releases only.
This software is proprietary. Pull requests modifying the binaries will not be accepted. If you find an issue with the driver or runtime, please submit an issue ticket describing the problem and your environment.

## 📄 License

See the [LICENSE.md](LICENSE.md) file for details regarding the usage and distribution of the files in this repository.