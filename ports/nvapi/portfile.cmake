vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO NVIDIA/nvapi
    REF 4ba3384657149d63aa193f5a34e20efe1e42bf31
    SHA512 B1FE556BAA445924ACFA12F080DEFDF6244060554B47FD35FCCEE2829E4F9260052C7075AC0261683DB8AFCC510B3CF24B3353D6F997349BA30C1614FDFB96D7
    HEAD_REF master
)

# Ensure destination directories exist
file(MAKE_DIRECTORY "${CURRENT_PACKAGES_DIR}/lib")
file(MAKE_DIRECTORY "${CURRENT_PACKAGES_DIR}/lib/pkgconfig")
file(MAKE_DIRECTORY "${CURRENT_PACKAGES_DIR}/include/nvapi")
file(MAKE_DIRECTORY "${CURRENT_PACKAGES_DIR}/share/nvapi")

# Install headers if they exist
if(EXISTS "${SOURCE_PATH}/nvapi.h")
  file(INSTALL
    DESTINATION "${CURRENT_PACKAGES_DIR}/include/nvapi"
    FILES
      ${SOURCE_PATH}/nvapi.h
      ${SOURCE_PATH}/NvApiDriverSettings.h
      ${SOURCE_PATH}/nvapi_interface.h
      ${SOURCE_PATH}/nvapi_lite_common.h
      ${SOURCE_PATH}/nvapi_lite_d3dext.h
      ${SOURCE_PATH}/nvapi_lite_salend.h
      ${SOURCE_PATH}/nvapi_lite_salstart.h
      ${SOURCE_PATH}/nvapi_lite_sli.h
      ${SOURCE_PATH}/nvapi_lite_stereo.h
      ${SOURCE_PATH}/nvapi_lite_surround.h
      ${SOURCE_PATH}/nvHLSLExtns.h
      ${SOURCE_PATH}/nvHLSLExtnsInternal.h
      ${SOURCE_PATH}/nvShaderExtnEnums.h
  )
else()
  message(WARNING "Header files not found in ${SOURCE_PATH}")
endif()

# Install library file if it exists
if(EXISTS "${SOURCE_PATH}/amd64/nvapi64.lib")
  file(INSTALL
    DESTINATION "${CURRENT_PACKAGES_DIR}/lib"
    FILES
      ${SOURCE_PATH}/amd64/nvapi64.lib
  )
else()
  message(WARNING "Library file not found in ${SOURCE_PATH}/amd64")
endif()


# Write files vcpkg directory

set(NVAPI_PC_TEXT
"prefix=${pcfiledir}/../..\n"
"libdir=${prefix}/lib\n"
"includedir=${prefix}/include\n\n"
"Name: nvapi\n"
"Description: NVAPI is NVIDIA's core software development kit that allows direct access to NVIDIA GPUs and drivers on all Windows platforms. NVAPI provides support for operations such as querying the installed driver version, enumerating GPUs and displays, monitoring GPU memory consumption, clocks, and temperature, DirectX and HLSL extensions, and more.\n"
"Version: R560\n"
)

# Write the content to a file named 'copyright'
file(WRITE "${CURRENT_PACKAGES_DIR}/share/nvapi/copyright"
    "nvapi.lib and nvapi64.lib are licensed under the following terms:\n\n"
    "SPDX-FileCopyrightText: Copyright (c) 2024 NVIDIA CORPORATION & AFFILIATES. All rights reserved.\n"
    "SPDX-License-Identifier: MIT\n\n"
    "Permission is hereby granted, free of charge, to any person obtaining a\n"
    "copy of this software and associated documentation files (the \"Software\"),\n"
    "to deal in the Software without restriction, including without limitation\n"
    "the rights to use, copy, modify, merge, publish, distribute, sublicense,\n"
    "and/or sell copies of the Software, and to permit persons to whom the\n"
    "Software is furnished to do so, subject to the following conditions:\n\n"
    "The above copyright notice and this permission notice shall be included in\n"
    "all copies or substantial portions of the Software.\n\n"
    "THE SOFTWARE IS PROVIDED \"AS IS\", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR\n"
    "IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,\n"
    "FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL\n"
    "THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER\n"
    "LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING\n"
    "FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER\n"
    "DEALINGS IN THE SOFTWARE.\n"
)

# Write the content to a file named 'usage'
file(WRITE "${CURRENT_PACKAGES_DIR}/share/nvapi/usage"
    "The package nvapi provides CMake targets:\n\n"
    "    find_package(nvapi CONFIG REQUIRED)\n"
    "    target_link_libraries(main PRIVATE nvapi::nvapi)\n"
)

# Write the content to a file named 'nvapi.pc'
file(WRITE "${CURRENT_PACKAGES_DIR}/lib/pkgconfig/nvapi.pc"
    "prefix=${pcfiledir}/../..\n"
    "libdir=${prefix}/lib\n"
    "includedir=${prefix}/include\n\n"
    "Name: nvapi\n"
    "Description: NVAPI is NVIDIA's core software development kit that allows direct access to NVIDIA GPUs and drivers on all Windows platforms. NVAPI provides support for operations such as querying the installed driver version, enumerating GPUs and displays, monitoring GPU memory consumption, clocks, and temperature, DirectX and HLSL extensions, and more.\n"
    "Version: R560\n"
)


# Create CMake configuration files
file(WRITE "${CURRENT_PACKAGES_DIR}/share/nvapi/nvapi-config.cmake"
  "include(${CMAKE_CURRENT_LIST_DIR}/nvapi-targets.cmake)\n"
)

file(WRITE "${CURRENT_PACKAGES_DIR}/share/nvapi/nvapi-targets.cmake"
  "# Compute the installation prefix relative to this file.\n"
  "get_filename_component(_IMPORT_PREFIX \"${CMAKE_CURRENT_LIST_FILE}\" PATH)\n"
  "get_filename_component(_IMPORT_PREFIX \"${_IMPORT_PREFIX}\" PATH)\n"
  "get_filename_component(_IMPORT_PREFIX \"${_IMPORT_PREFIX}\" PATH)\n"
  "if(_IMPORT_PREFIX STREQUAL \"/\")\n"
  " set(_IMPORT_PREFIX \"\")\n"
  "endif()\n"
  "add_library(nvapi::nvapi STATIC IMPORTED)\n"
  "set_target_properties(nvapi::nvapi PROPERTIES\n" 
    "IMPORTED_LOCATION \"${_IMPORT_PREFIX}/lib/nvapi64.lib\"\n"
    "INTERFACE_INCLUDE_DIRECTORIES \"${_IMPORT_PREFIX}/include\"\n"
  ")\n"
)