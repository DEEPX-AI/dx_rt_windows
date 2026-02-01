# DxEngine C# SDK

DeepX NPU Runtime C# SDK for .NET 8.0

## Directory Structure

```
csharp/
├── lib/                          # DxEngine libraries
│   ├── DxEngine.dll              # C# managed library
│   ├── DxEngineNative.dll        # C++/CLI native bridge
│   ├── dxrt.dll                  # DeepX Runtime core
│   ├── onnxruntime.dll           # ONNX Runtime
│   ├── onnxruntime_providers_shared.dll
│   └── Ijwhost.dll               # C++/CLI host
│
└── examples/                     # Example projects
    └── YoloV5/                   # YOLOv5 object detection example
        ├── YoloV5Example.csproj
        ├── Program.cs            # Main entry point
        └── YoloV5Sync.cs         # YOLOv5 class implementation
```

## Requirements

- .NET 8.0 SDK
- Windows x64
- Visual Studio 2022 (recommended)

## Build

```bash
cd examples/YoloV5
dotnet build -c Release
```

## Run

```bash
# Image processing
YoloV5Example.exe -m <model.dxnn> -i <input.jpg>

# Video processing
YoloV5Example.exe -m <model.dxnn> -v <input.mp4>

# Webcam
YoloV5Example.exe -m <model.dxnn> -c 0
```

## Options

| Option | Description |
|--------|-------------|
| `-m, --model` | DXNN model file path (required) |
| `-i, --image` | Input image path |
| `-v, --video` | Input video path |
| `-c, --camera` | Webcam index |
| `-o, --output` | Output file path |
| `--no-display` | Disable display output |

## Using DxEngine in Your Project

### 1. Add DLL Reference

```xml
<ItemGroup>
  <Reference Include="DxEngine">
    <HintPath>path\to\lib\DxEngine.dll</HintPath>
  </Reference>
</ItemGroup>
```

### 2. Configure Native DLL Copy

```xml
<ItemGroup>
  <None Include="path\to\lib\DxEngineNative.dll">
    <CopyToOutputDirectory>PreserveNewest</CopyToOutputDirectory>
  </None>
  <None Include="path\to\lib\dxrt.dll">
    <CopyToOutputDirectory>PreserveNewest</CopyToOutputDirectory>
  </None>
  <None Include="path\to\lib\onnxruntime.dll">
    <CopyToOutputDirectory>PreserveNewest</CopyToOutputDirectory>
  </None>
  <None Include="path\to\lib\onnxruntime_providers_shared.dll">
    <CopyToOutputDirectory>PreserveNewest</CopyToOutputDirectory>
  </None>
  <None Include="path\to\lib\Ijwhost.dll">
    <CopyToOutputDirectory>PreserveNewest</CopyToOutputDirectory>
  </None>
</ItemGroup>
```

### 3. Code Example

```csharp
using DxEngine;

// Configure options
var option = new InferenceOption
{
    UseOrt = false,
    BoundOption = BoundOption.NpuAll,
    BufferCount = 6
};

// Create engine
using var engine = new InferenceEngineNative(modelPath, option);

// Run inference
var outputs = engine.Run(inputData);

// Timing information
double latencyMs = engine.GetLatency() / 1000.0;
double npuTimeMs = engine.GetNpuInferenceTime() / 1000.0;
```

## License

Copyright (C) 2018- DEEPX Ltd. All rights reserved.
