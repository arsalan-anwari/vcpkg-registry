vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO NVIDIA/nvapi
    REF 4ba3384657149d63aa193f5a34e20efe1e42bf31
    SHA512 B1FE556BAA445924ACFA12F080DEFDF6244060554B47FD35FCCEE2829E4F9260052C7075AC0261683DB8AFCC510B3CF24B3353D6F997349BA30C1614FDFB96D7
    HEAD_REF master
)

# Define the installation directories
set(INCLUDE_DIR ${SOURCE_PATH})
set(LIB_DIR ${SOURCE_PATH}/amd64)

# Glob all header files in the root directory
file(GLOB HEADER_FILES "${INCLUDE_DIR}/*.h")

# Create the include directory in the Vcpkg installation
file(MAKE_DIRECTORY ${CURRENT_PACKAGES_DIR}/include)

# Copy all header files to the include directory in Vcpkg
foreach(header_file ${HEADER_FILES})
    file(COPY ${header_file} DESTINATION ${CURRENT_PACKAGES_DIR}/include)
endforeach()

# Copy the library file
file(COPY ${LIB_DIR}/nvapi64.lib DESTINATION ${CURRENT_PACKAGES_DIR}/lib)

# Create the CMake configuration files
file(WRITE ${CURRENT_PACKAGES_DIR}/share/nvapi/nvapiConfig.cmake
[[
include("${CMAKE_CURRENT_LIST_DIR}/nvapiTargets.cmake")
]])

file(WRITE ${CURRENT_PACKAGES_DIR}/share/nvapi/nvapiTargets.cmake
[[
# Define the targets
add_library(nvapi STATIC IMPORTED)
set_target_properties(nvapi PROPERTIES
    IMPORTED_LOCATION "${CURRENT_PACKAGES_DIR}/lib/nvapi64.lib"
    INTERFACE_INCLUDE_DIRECTORIES "${CURRENT_PACKAGES_DIR}/include"
)
]])