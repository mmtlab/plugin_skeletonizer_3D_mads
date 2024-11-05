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


## INI settings

The plugin supports the following settings in the INI file:

```ini
[hpe]
# Describe the settings available to the plugin
```

All settings are optional; if omitted, the default values are used.


## Executable demo

<Explain what happens if the test executable is run>

---