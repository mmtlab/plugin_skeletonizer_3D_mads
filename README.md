# hpe plugin for MADS

This is a Source plugin for [MADS](https://github.com/MADS-NET/MADS). 

<provide here some introductory info>

## Requirements

OpenCV, OpenVINO, VTK, PCL and Libcamera. 

On Linux, including RaspbianOS, OpenCV can be installed with `sudo apt install libopencv-dev`. OpenVino must be installed following the instructions here: <https://docs.openvino.ai/2024/get-started/install-openvino/install-openvino-archive-linux.html> . VTK can be installed with 'sudo apt-get install libvtk9-dev'. PCL can be installed with 'sudo apt install libpcl-dev'. Libcamera can be installed with 'sudo apt install libcamera-dev'.

PS Verify the OpenVINO installation path in the CMakeLists.txt file to ensure it points to the correct directory in your PC. 

## Supported platforms

Currently, the supported platforms are:

* **Linux** 
* **MacOS**
* **Windows**


## Installation

Linux and MacOS:

```bash
cmake -Bbuild -DCMAKE_INSTALL_PREFIX="$(mads -p)"
cmake --build build -j2
sudo cmake --install build
```

Windows:

```powershell
cmake -Bbuild -DCMAKE_INSTALL_PREFIX="$(mads -p)"
cmake --build build --config Release
cmake --install build --config Release
```

After building, copy the `hpe.exe` and `hpe.plugin` files from `usr/bin` to `usr/local/bin` within your MADS installation directory (for example, `C:\Program Files\MADS\usr\local\bin` on Windows).

## INI settings

The plugin supports the following settings in the INI file:

```ini
[hpe]
pub_topic = "hpe"
period = 30
camera_device = 0
azure_device = 0
fps = 25
CUDA = false
model_file = "path/to/model/human-pose-estimation-0001.xml"
dummy = false
resolution_rgb = "1280x720"
debug = {skeleton_from_depth_compute = false, skeleton_from_rgb_compute = false, hessian_compute = false, cov3D_compute = false, consistency_check = false, point_cloud_filter = false, coordinate_transfrom = false, viewer = false }
```


## Executable demo

<Explain what happens if the test executable is run>

---