vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO NVIDIA/nvapi
    REF 4ba3384657149d63aa193f5a34e20efe1e42bf31
    SHA512 B1FE556BAA445924ACFA12F080DEFDF6244060554B47FD35FCCEE2829E4F9260052C7075AC0261683DB8AFCC510B3CF24B3353D6F997349BA30C1614FDFB96D7
    HEAD_REF master
)

# Supress all install messages
set(CMAKE_INSTALL_MESSAGE NEVER)

# Ensure destination directories exists
file(MAKE_DIRECTORY "${CURRENT_PACKAGES_DIR}/lib")
file(MAKE_DIRECTORY "${CURRENT_PACKAGES_DIR}/lib/pkgconfig")
file(MAKE_DIRECTORY "${CURRENT_PACKAGES_DIR}/include/nvapi")
file(MAKE_DIRECTORY "${CURRENT_PACKAGES_DIR}/share/nvapi")

# Add library information files
install(FILES "${PORT_PATH}/copyright" DESTINATION "${CURRENT_PACKAGES_DIR}/share/nvapi")
install(FILES "${PORT_PATH}/usage" DESTINATION "${CURRENT_PACKAGES_DIR}/share/nvapi")
install(FILES "${PORT_PATH}/nvapi.pc" DESTINATION "${CURRENT_PACKAGES_DIR}/lib/pkgconfig")

# Find all header files in the root directory
file(GLOB_RECURSE NVAPI_HEADERS
    LIST_DIRECTORIES false
    "${SOURCE_PATH}/*.h"
    "${SOURCE_PATH}/*.hpp"
)

# Copy headers to include folder
install(FILES ${NVAPI_HEADERS} DESTINATION "${CURRENT_PACKAGES_DIR}/include/nvapi")

# Copy library to lib folder
install(FILES "${SOURCE_PATH}/amd64/nvapi64.lib" DESTINATION "${CURRENT_PACKAGES_DIR}/lib")

# Copy CMake configuration files
install(FILES "${PORT_PATH}/nvapi-targets.cmake" DESTINATION "${CURRENT_PACKAGES_DIR}/share/nvapi")
install(FILES "${PORT_PATH}/nvapi-config.cmake" DESTINATION "${CURRENT_PACKAGES_DIR}/share/nvapi")