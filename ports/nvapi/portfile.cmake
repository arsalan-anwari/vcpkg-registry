vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO NVIDIA/nvapi
    REF 4ba3384657149d63aa193f5a34e20efe1e42bf31
    SHA512 B1FE556BAA445924ACFA12F080DEFDF6244060554B47FD35FCCEE2829E4F9260052C7075AC0261683DB8AFCC510B3CF24B3353D6F997349BA30C1614FDFB96D7
    HEAD_REF master
)

# Install headers
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

# Install the .lib file
file(INSTALL
  DESTINATION "${CURRENT_PACKAGES_DIR}/lib"
  FILES
    ${SOURCE_PATH}/amd64/nvapi64.lib
)

# Set up the CMake configuration
vcpkg_cmake_configure(
  SOURCE_PATH ${SOURCE_PATH}
  PREFER_NINJA
)

vcpkg_cmake_build()
vcpkg_cmake_install()