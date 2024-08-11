vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO NVIDIA/nvapi
    REF 4ba3384657149d63aa193f5a34e20efe1e42bf31
    SHA512 F8A1E3BCC2EB71D4020347B5B950C1376C82724915C587262B2FAAB1D8AEB1D81DA24827C11C64DD4CDF3C93076CAB24E45F675C4C6168510A06D1D561CD2A5C
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
