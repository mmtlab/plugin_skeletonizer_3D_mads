# Human Pose Estimation (HPE) Plugin for MADS

This is a comprehensive 3D Human Pose Estimation Source plugin for [MADS](https://github.com/MADS-NET/MADS) (Modular Architecture for Distributed Systems). The plugin performs real-time 3D human pose estimation using OpenVINO's optimized deep learning models, supporting multiple input sources including regular webcams, Raspberry Pi cameras, and Microsoft Azure Kinect sensors.

## Overview

The HPE plugin implements a sophisticated computer vision pipeline that:
- Captures video input from various camera sources
- Processes RGB and depth data (when available)
- Runs OpenPose-based human pose estimation using Intel's OpenVINO framework
- Generates 3D skeletal representations with 18 key body joints
- Publishes results as JSON data for downstream processing in MADS ecosystem

## Key Features

- **Multi-platform support**: Linux, macOS, and Windows
- **Multiple input sources**: USB cameras, Raspberry Pi cameras, Azure Kinect
- **Real-time processing**: Optimized inference using OpenVINO
- **3D pose estimation**: Combines RGB and depth data for spatial positioning
- **Flexible configuration**: Extensive parameter customization
- **Debug capabilities**: Comprehensive debugging options for development
- **High accuracy**: Uses Intel's pre-trained human-pose-estimation-0001 model

## Functional Block Diagram

```
┌─────────────────────────────────────────────────────────────────────────────────┐
│                           HPE Plugin Architecture                                │
└─────────────────────────────────────────────────────────────────────────────────┘

    ┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
    │   Camera Input  │    │  Azure Kinect   │    │  Dummy/File     │
    │   (USB/CSI)     │    │   (RGB+Depth)   │    │    Input        │
    └─────────┬───────┘    └─────────┬───────┘    └─────────┬───────┘
              │                      │                      │
              └──────────────────────┼──────────────────────┘
                                     │
                            ┌────────▼────────┐
                            │ Video Capture   │
                            │   Setup         │
                            │ (Resolution,    │
                            │  FPS, Format)   │
                            └────────┬────────┘
                                     │
                            ┌────────▼────────┐
                            │  Frame          │
                            │ Acquisition     │
                            │ & Preprocessing │
                            └────────┬────────┘
                                     │
                   ┌─────────────────┼─────────────────┐
                   │                 │                 │
          ┌────────▼────────┐  ┌─────▼──────┐  ┌──────▼──────┐
          │  RGB Processing │  │   Depth    │  │ Point Cloud │
          │    Pipeline     │  │ Processing │  │ Generation  │
          └────────┬────────┘  └─────┬──────┘  └──────┬──────┘
                   │                 │                 │
                   └─────────────────┼─────────────────┘
                                     │
                            ┌────────▼────────┐
                            │   OpenVINO      │
                            │ Model Loading   │
                            │ (HPE OpenPose)  │
                            └────────┬────────┘
                                     │
                            ┌────────▼────────┐
                            │  Inference      │
                            │   Pipeline      │
                            │ (Async/Sync)    │
                            └────────┬────────┘
                                     │
              ┌──────────────────────┼──────────────────────┐
              │                      │                      │
     ┌────────▼────────┐    ┌────────▼────────┐    ┌────────▼────────┐
     │   Heat Maps     │    │      PAFs       │    │   Embeddings    │
     │  Generation     │    │  (Part Affinity │    │  (Associative)  │
     │                 │    │    Fields)      │    │                 │
     └────────┬────────┘    └────────┬────────┘    └────────┬────────┘
              │                      │                      │
              └──────────────────────┼──────────────────────┘
                                     │
                            ┌────────▼────────┐
                            │   Peak/Joint    │
                            │   Detection     │
                            │ & Association   │
                            └────────┬────────┘
                                     │
                            ┌────────▼────────┐
                            │  Pose Assembly  │
                            │ & Refinement    │
                            │ (18 Keypoints)  │
                            └────────┬────────┘
                                     │
                   ┌─────────────────┼─────────────────┐
                   │                 │                 │
          ┌────────▼────────┐  ┌─────▼──────┐  ┌──────▼──────┐
          │  2D Skeleton    │  │ 3D Spatial │  │ Confidence  │
          │  Rendering      │  │ Mapping    │  │  Scoring    │
          └────────┬────────┘  └─────┬──────┘  └──────┬──────┘
                   │                 │                 │
                   └─────────────────┼─────────────────┘
                                     │
                            ┌────────▼────────┐
                            │   JSON Output   │
                            │   Generation    │
                            │ (MADS Format)   │
                            └────────┬────────┘
                                     │
                            ┌────────▼────────┐
                            │  Debug/Viewer   │
                            │   (Optional)    │
                            └─────────────────┘

Key Components:
- Input Sources: USB Camera, Raspberry Pi Camera, Azure Kinect
- Processing: OpenVINO inference engine with async pipeline
- Model: Intel's human-pose-estimation-0001 (OpenPose architecture)
- Output: 18-point skeletal representation with 3D coordinates
- Keypoints: Nose, Neck, Shoulders, Elbows, Wrists, Hips, Knees, Ankles, Eyes, Ears
```

## System Requirements

### Hardware Requirements
- **CPU**: Intel x86_64 or ARM64 processor (Raspberry Pi 4+ supported)
- **RAM**: Minimum 4GB, recommended 8GB+
- **Camera**: USB webcam, Raspberry Pi camera, or Azure Kinect
- **GPU**: Optional but recommended for CUDA acceleration (when available)

### Software Dependencies

#### Core Dependencies
- **OpenCV** (≥4.0): Computer vision library for image processing
- **OpenVINO** (≥2024.0): Intel's deep learning inference framework
- **VTK** (≥9.0): Visualization toolkit for 3D graphics
- **PCL** (≥1.13): Point Cloud Library for 3D data processing
- **Eigen3** (≥3.4): Linear algebra library
- **nlohmann/json** (≥3.11): JSON parsing and generation
- **pugg**: Plugin architecture framework

#### Platform-Specific Dependencies

**Linux (including Raspberry Pi):**
- **libcamera-dev**: Camera abstraction layer
- **LCCV**: LibCamera Computer Vision wrapper
- **MPI**: Message Passing Interface

**Windows:**
- **Azure Kinect SDK** (optional): For Kinect sensor support
- **Visual Studio 2019+**: Build tools

**macOS:**
- **Homebrew**: Package manager for dependencies

## Supported Platforms

- **Linux** (Ubuntu 20.04+, Debian 11+, Raspberry Pi OS)
- **macOS** (10.15+)
- **Windows** (10/11 with Visual Studio 2019+)

## Installation

### Prerequisites Setup

#### Linux (Ubuntu/Debian)
```bash
# Install basic dependencies
sudo apt update
sudo apt install -y build-essential cmake pkg-config git

# Install OpenCV
sudo apt install -y libopencv-dev

# Install VTK
sudo apt install -y libvtk9-dev

# Install PCL
sudo apt install -y libpcl-dev

# Install libcamera (for Raspberry Pi)
sudo apt install -y libcamera-dev

# Install MPI
sudo apt install -y libopenmpi-dev
```

#### Install OpenVINO
```bash
# Download OpenVINO 2024.0+
wget https://storage.openvinotoolkit.org/repositories/openvino/packages/2024.0/linux/l_openvino_toolkit_ubuntu20_2024.0.0.14509.34caeefd078_x86_64.tgz

# Extract and install
tar -xzf l_openvino_toolkit_ubuntu20_2024.0.0.14509.34caeefd078_x86_64.tgz
sudo mv l_openvino_toolkit_ubuntu20_2024.0.0.14509.34caeefd078_x86_64 /opt/intel/openvino_2024.0.0

# Setup environment
echo 'source /opt/intel/openvino_2024.0.0/setupvars.sh' >> ~/.bashrc
source ~/.bashrc
```

#### Windows
```powershell
# Set environment variables for OpenCV and OpenVINO
$env:OpenCV_DIR = "C:\opencv\build"
$env:OpenVINO_DIR = "C:\Program Files (x86)\Intel\openvino_2024"

# Install Azure Kinect SDK (optional)
# Download from: https://github.com/microsoft/Azure-Kinect-Sensor-SDK
```

#### macOS
```bash
# Install Homebrew dependencies
brew install opencv vtk pcl eigen pkg-config cmake

# Install OpenVINO
# Download from Intel's website and follow installation instructions
```

### Build and Installation

#### Linux and macOS
```bash
# Clone the repository (if not already done)
cd /path/to/plugin_skeletonizer_3D_mads

# Configure build
cmake -Bbuild -DCMAKE_INSTALL_PREFIX="$(mads -p)"

# Build with parallel jobs
cmake --build build -j$(nproc)

# Install
sudo cmake --install build
```

#### Windows
```powershell
# Open PowerShell as Administrator
cd C:\path\to\plugin_skeletonizer_3D_mads

# Configure build
cmake -Bbuild -DCMAKE_INSTALL_PREFIX="$(mads -p)"

# Build release version
cmake --build build --config Release

# Install
cmake --install build --config Release
```

### Post-Installation
After building, ensure the plugin files are in the correct MADS directory:
- Copy `hpe.exe` and `hpe.plugin` from `usr/bin` to `usr/local/bin` in your MADS installation
- Verify the OpenVINO model files are downloaded to the `models/` directory

## Configuration

### INI Settings

The plugin supports extensive configuration through INI files:

```ini
[hpe]
# Publication settings
pub_topic = "hpe"              # MADS topic for publishing results
period = 30                    # Processing period in milliseconds

# Camera configuration
camera_device = 0              # Camera device ID (0 for default)
azure_device = 0              # Azure Kinect device ID
fps = 25                       # Target frame rate
resolution_rgb = "1280x720"    # RGB camera resolution

# Model configuration
model_file = "models/human-pose-estimation-0001.xml"  # OpenVINO model path
CUDA = false                   # Enable CUDA acceleration (if available)
dummy = false                  # Use dummy input for testing

# Debug configuration
debug = {
    skeleton_from_depth_compute = false,    # Enable depth-based skeleton computation
    skeleton_from_rgb_compute = false,      # Enable RGB-based skeleton computation
    hessian_compute = false,                # Enable Hessian matrix computation
    cov3D_compute = false,                  # Enable 3D covariance computation
    consistency_check = false,              # Enable consistency checking
    point_cloud_filter = false,             # Enable point cloud filtering
    coordinate_transfrom = false,           # Enable coordinate transformation
    viewer = false                          # Enable visualization window
}
```

### Model Configuration

The plugin automatically downloads the Intel OpenVINO human pose estimation model:
- **Model**: `human-pose-estimation-0001`
- **Format**: OpenVINO IR (XML + BIN)
- **Input**: 256x456 RGB image
- **Output**: 18 keypoint coordinates + confidence scores

### Keypoint Mapping

The plugin detects 18 human body keypoints:

```cpp
// OpenPose keypoint mapping
0: "NOS_" (Nose)        10: "ANKR" (Right Ankle)
1: "NEC_" (Neck)        11: "HIPL" (Left Hip)
2: "SHOR" (Right Shoulder) 12: "KNEL" (Left Knee)
3: "ELBR" (Right Elbow)  13: "ANKL" (Left Ankle)
4: "WRIR" (Right Wrist)  14: "EYER" (Right Eye)
5: "SHOL" (Left Shoulder) 15: "EYEL" (Left Eye)
6: "ELBL" (Left Elbow)   16: "EARR" (Right Ear)
7: "WRIL" (Left Wrist)   17: "EARL" (Left Ear)
8: "HIPR" (Right Hip)
9: "KNER" (Right Knee)
```

## Usage

### Running the Plugin

#### As MADS Plugin
```bash
# Start MADS with HPE plugin
mads -c config.ini

# The plugin will automatically:
# 1. Initialize camera capture
# 2. Load OpenVINO model
# 3. Start processing frames
# 4. Publish pose data to specified topic
```

#### Standalone Execution
```bash
# Run as standalone application
./hpe

# Or with custom parameters
./hpe --config params.json
```

### Output Format

The plugin publishes JSON data with the following structure:

```json
{
  "timestamp": "2024-01-01T12:00:00.000Z",
  "frame_id": 12345,
  "poses": [
    {
      "person_id": 0,
      "keypoints": [
        {
          "name": "NOS_",
          "position_2d": {"x": 320.5, "y": 240.2},
          "position_3d": {"x": 0.1, "y": 0.0, "z": 2.5},
          "confidence": 0.95
        },
        // ... additional keypoints
      ],
      "total_score": 0.85
    }
    // ... additional persons
  ],
  "processing_time_ms": 15.2,
  "camera_info": {
    "resolution": "1280x720",
    "fps": 25,
    "device_id": 0
  }
}
```

### Debug Mode

Enable debug visualization to see real-time processing:

```bash
# Enable debug viewer
# Set debug.viewer = true in configuration
```

The debug viewer shows:
- Original camera feed
- Detected keypoints (colored circles)
- Skeletal connections (colored lines)
- Confidence scores
- Processing statistics

## Performance Optimization

### Inference Optimization
- **Model Precision**: Use FP16 precision for faster inference on supported hardware
- **Batch Processing**: Process multiple frames simultaneously when possible
- **Async Pipeline**: Utilizes OpenVINO's asynchronous inference for better throughput

### Hardware Acceleration
```ini
# Enable CUDA acceleration (NVIDIA GPUs)
CUDA = true

# Or use Intel GPU acceleration
# Set OpenVINO device to GPU in model configuration
```

### Performance Tuning
- **Resolution**: Lower resolution improves speed but reduces accuracy
- **FPS**: Adjust target FPS based on hardware capabilities
- **Threading**: Utilize multiple CPU cores for parallel processing

## Troubleshooting

### Common Issues

1. **OpenVINO Model Not Found**
```bash
# Manually download model
wget https://storage.openvinotoolkit.org/repositories/open_model_zoo/2023.0/models_bin/1/human-pose-estimation-0001/FP32/human-pose-estimation-0001.xml
wget https://storage.openvinotoolkit.org/repositories/open_model_zoo/2023.0/models_bin/1/human-pose-estimation-0001/FP32/human-pose-estimation-0001.bin
```

2. **Camera Access Issues**
```bash
# Linux: Check camera permissions
sudo usermod -a -G video $USER
# Logout and login again
```

3. **Build Errors**
```bash
# Verify OpenVINO path in CMakeLists.txt
# Update paths to match your installation
```

4. **Performance Issues**
```bash
# Check CPU/GPU utilization
htop
nvidia-smi  # For NVIDIA GPUs

# Reduce resolution or FPS if needed
```

### Debug Logs

Enable verbose logging for troubleshooting:
```bash
export OPENVINO_LOG_LEVEL=1
./hpe --verbose
```

## API Reference

### Main Classes

#### `HpePlugin`
- **Purpose**: Main plugin class implementing MADS Source interface
- **Key Methods**:
  - `setup_VideoCapture()`: Initialize camera input
  - `setup_OpenPoseModel()`: Load OpenVINO model
  - `setup_Pipeline()`: Configure inference pipeline
  - `process_frame()`: Process single frame
  - `publish_results()`: Send results to MADS

#### `HPEOpenPose`
- **Purpose**: OpenVINO model wrapper for pose estimation
- **Key Methods**:
  - `preprocess()`: Prepare input data
  - `postprocess()`: Parse model output
  - `extractPoses()`: Generate pose structures

### Configuration Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `camera_device` | int | 0 | Camera device ID |
| `azure_device` | int | 0 | Azure Kinect device ID |
| `fps` | int | 25 | Target frame rate |
| `resolution_rgb` | string | "1280x720" | Camera resolution |
| `model_file` | string | "models/..." | OpenVINO model path |
| `CUDA` | bool | false | Enable CUDA acceleration |
| `dummy` | bool | false | Use dummy input |

## License

This project is licensed under the Apache License 2.0 - see the LICENSE file for details.

**Note**: This plugin requires proper camera setup and OpenVINO installation. Ensure all dependencies are correctly installed before building.