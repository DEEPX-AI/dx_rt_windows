# DeepX NPU Windows Runtime & Driver

**Windows runtime libraries, drivers, and installation documentation for DEEPX AI accelerators.**

This repository provides **prebuilt binaries** for DeepX NPU devices on Windows, including PCIe device drivers and runtime environment for DX-M1 accelerators.

## 📂 Repository Structure

```
dx_rt_windows/
├── m1/v.3.1.1/
│   ├── dxm1drv/           # PCIe driver files (INF, SYS, CAT)
│   └── dx_rt/             # Runtime libraries and tools
└── docs/v.3.1.1/
    └── Installation_on_Windows.md
```

## 🚀 Supported Devices

| Device | Connection | Description |
|--------|------------|-------------|
| **DX-M1** | PCIe / M.2 / USB 4.0* | AI Accelerator |

> *USB 4.0 requires PCIe tunneling support (Thunderbolt™ or USB4)

## 💻 System Requirements

* **OS**: Windows 10 or later (x86_64)
* **Hardware**: DeepX NPU device installed in PCIe slot, M.2 slot, or connected via USB 4.0
* **Privileges**: Administrator rights required for driver installation

## 📦 Quick Start

### 1. Install Driver
Navigate to `m1/v.3.1.1/dxm1drv/` and right-click **`dxm1drv.inf`** → Select **Install**

Alternative methods available in the [full installation guide](docs/v.3.1.1/Installation_on_Windows.md).

### 2. Configure Runtime Service
The `dxrtd.exe` daemon must run for NPU operations:

**Simple Method** - Add to Startup folder:
```cmd
Win + R → shell:startup
```
Create shortcut to `dxrtd.exe` and move it to the Startup folder.

**Production Method** - Register as Windows Service:
```cmd
cd m1\v.3.1.1\dx_rt
sc create DxrtService binPath= "%CD%\dxrtd.exe" start= auto DisplayName= "DeepX Runtime Service"
sc start DxrtService
```

### 3. Verify Installation
```cmd
cd m1\v.3.1.1\dx_rt
dxrt-cli.exe -s
```

If device information appears, installation is complete.

## 🛠️ Available Tools

Located in `m1/v.3.1.1/dx_rt/`:

| Tool | Description |
|------|-------------|
| **dxrtd.exe** | Runtime daemon (must be running) |
| **dxrt-cli.exe** | Device management and firmware interface |
| **run_model.exe** | Run inference on `.dxnn` models |
| **parse_model.exe** | Inspect model information |
| **dxbenchmark.exe** | Performance benchmarking |
| **dxtop.exe** | Real-time NPU monitoring |

Run any tool with `-h` for detailed usage.

## 📖 Documentation

* **[Installation Guide](docs/v.3.1.1/Installation_on_Windows.md)** - Complete step-by-step installation instructions
  - Driver installation (3 methods)
  - Runtime service configuration (3 methods)
  - Verification and troubleshooting

## ✅ Verification Checklist

- [ ] Driver installed (Device Manager shows "DeepX AI Accelerator")
- [ ] `dxrtd.exe` is running (check Task Manager)
- [ ] `dxrt-cli.exe -s` shows device information
- [ ] No errors in Device Manager

## 🐛 Troubleshooting

**Device not detected?**
- Verify proper PCIe/M.2 slot installation
- Check Device Manager for warnings
- Try reinstalling driver

**dxrtd.exe not running?**
- Run manually from `dx_rt` folder
- Check Windows Firewall/antivirus
- Run as Administrator

See [full troubleshooting guide](docs/v.3.1.1/Installation_on_Windows.md#troubleshooting) for more details.

## 🤝 Contributing

This repository hosts binary releases only. For issues, please submit a ticket with:
- Windows version
- Device model and connection type
- Error messages or logs

## 📄 License

See [LICENSE](LICENSE) for usage terms and distribution rights.