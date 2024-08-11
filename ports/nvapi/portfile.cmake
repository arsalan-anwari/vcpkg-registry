vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO NVIDIA/nvapi
    REF 4ba3384657149d63aa193f5a34e20efe1e42bf31
    SHA512 B1FE556BAA445924ACFA12F080DEFDF6244060554B47FD35FCCEE2829E4F9260052C7075AC0261683DB8AFCC510B3CF24B3353D6F997349BA30C1614FDFB96D7
    HEAD_REF master
)

# Ensure destination directories exist
file(MAKE_DIRECTORY "${CURRENT_PACKAGES_DIR}/include")
file(MAKE_DIRECTORY "${CURRENT_PACKAGES_DIR}/lib")
file(MAKE_DIRECTORY "${CURRENT_PACKAGES_DIR}/share/nvapi/")

# Install headers if they exist
if(EXISTS "${SOURCE_PATH}/nvapi.h")
  file(INSTALL
    DESTINATION "${CURRENT_PACKAGES_DIR}/include"
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

# Create CMake configuration files
file(WRITE "${CURRENT_PACKAGES_DIR}/share/nvapi/nvapiConfig.cmake"
  "include(CMakeFindDependencyMacro)\n"
  "find_dependency(PkgConfig)\n"
  "include(${CMAKE_CURRENT_LIST_DIR}/nvapiTargets.cmake)\n"
)

file(WRITE "${CURRENT_PACKAGES_DIR}/share/nvapi/nvapiTargets.cmake"
  "include(CMakeFindDependencyMacro)\n"
  "include(CMakePackageConfigHelpers)\n"
  "include(CMakeFindDependencyMacro)\n"
  "set_and_check(NVAPI_INCLUDE_DIRS \"${CURRENT_PACKAGES_DIR}/include\")\n"
  "set_and_check(NVAPI_LIBRARIES \"${CURRENT_PACKAGES_DIR}/lib/nvapi64.lib\")\n"
  "add_library(nvapi::nvapi UNKNOWN IMPORTED)\n"
  "set_target_properties(nvapi::nvapi PROPERTIES\n"
  "  INTERFACE_INCLUDE_DIRECTORIES \"${CURRENT_PACKAGES_DIR}/include\"\n"
  "  IMPORTED_LOCATION \"${CURRENT_PACKAGES_DIR}/lib/nvapi64.lib\"\n"
  ")\n"
)