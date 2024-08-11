# Compute the installation prefix relative to this file.
get_filename_component(_IMPORT_PREFIX "${CMAKE_CURRENT_LIST_FILE}" PATH)
get_filename_component(_IMPORT_PREFIX "${_IMPORT_PREFIX}" PATH)
get_filename_component(_IMPORT_PREFIX "${_IMPORT_PREFIX}" PATH)
if(_IMPORT_PREFIX STREQUAL "/")
 set(_IMPORT_PREFIX "")
endif()
add_library(nvapi::nvapi STATIC IMPORTED)
set_target_properties(nvapi::nvapi PROPERTIES
IMPORTED_LOCATION "${_IMPORT_PREFIX}/lib/nvapi64.lib"
INTERFACE_INCLUDE_DIRECTORIES "${_IMPORT_PREFIX}/include"
)
