#.rst:
# Findk4arecord
# -------------
#
# Find Azure Kinect Sensor SDK Record include dirs, and libraries.
#
# IMPORTED Targets
# ^^^^^^^^^^^^^^^^
#
# This module defines the :prop_tgt:`IMPORTED` targets:
#
# ``k4a::k4arecord``
#  Defined if the system has Azure Kinect Sensor SDK Record.
#
# Result Variables
# ^^^^^^^^^^^^^^^^
#
# This module sets the following variables:
#
# ::
#
#   k4arecord_FOUND               True in case Azure Kinect Sensor SDK Record is found, otherwise false
#   k4arecord_ROOT                Path to the root of found Azure Kinect Sensor SDK installation
#
# Example usage
# ^^^^^^^^^^^^^
#
# ::
#
#     find_package(k4arecord REQUIRED)
#
#     add_executable(foo foo.cc)
#     target_link_libraries(foo k4a::k4arecord)
#
# License
# ^^^^^^^
#
# Copyright (c) 2019 Tsukasa SUGIURA
# Distributed under the MIT License.
#
# Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
# The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#

file(GLOB K4A_DIR_PATHS "$ENV{PROGRAMW6432}/Azure Kinect SDK v*")
list(REVERSE K4A_DIR_PATHS)

foreach(K4A_DIR_PATH IN ITEMS ${K4A_DIR_PATHS})
  find_path(k4arecord_INCLUDE_DIR
    NAMES k4arecord/playback.h
    HINTS "${K4A_DIR_PATH}/sdk"
    PATH_SUFFIXES "include"
  )

  find_library(k4arecord_LIBRARY
    NAMES k4arecord
    HINTS "${K4A_DIR_PATH}/sdk"
    PATH_SUFFIXES "windows-desktop/amd64/release/lib"
  )

  if(k4arecord_INCLUDE_DIR AND k4arecord_LIBRARY)
    break()
  endif()
endforeach()

if(k4arecord_INCLUDE_DIR AND k4arecord_LIBRARY)
  get_filename_component(k4arecord_ROOT "${k4arecord_INCLUDE_DIR}" DIRECTORY)
  
  if(NOT TARGET k4a::k4arecord)
    add_library(k4a::k4arecord SHARED IMPORTED)
    set_target_properties(k4a::k4arecord PROPERTIES
      INTERFACE_INCLUDE_DIRECTORIES "${k4arecord_INCLUDE_DIR}"
      IMPORTED_LOCATION "${k4arecord_LIBRARY}"
      IMPORTED_IMPLIB "${k4arecord_LIBRARY}"
    )
  endif()
endif()

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(k4arecord
  FOUND_VAR k4arecord_FOUND
  REQUIRED_VARS k4arecord_LIBRARY k4arecord_INCLUDE_DIR
)

mark_as_advanced(k4arecord_INCLUDE_DIR k4arecord_LIBRARY)
