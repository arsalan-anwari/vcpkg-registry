vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO NVIDIA/nvapi
    REF 4ba3384657149d63aa193f5a34e20efe1e42bf31
    SHA512 B1FE556BAA445924ACFA12F080DEFDF6244060554B47FD35FCCEE2829E4F9260052C7075AC0261683DB8AFCC510B3CF24B3353D6F997349BA30C1614FDFB96D7
    HEAD_REF master
)

# Define the installation directories
set(INSTALL_DIR ${SOURCE_PATH}/amd64)
set(INCLUDE_DIR ${SOURCE_PATH})

# Glob all header files in the root directory
file(GLOB HEADER_FILES "${INCLUDE_DIR}/*.h")

# Copy all header files to the include directory in Vcpkg
foreach(header_file ${HEADER_FILES})
    file(COPY ${header_file} DESTINATION ${CURRENT_PACKAGES_DIR}/include)
endforeach()

# Copy the library file
file(COPY ${INSTALL_DIR}/nvapi64.lib DESTINATION ${CURRENT_PACKAGES_DIR}/lib)
