cmake_minimum_required (VERSION 2.6)
project (gesture)

set(GESTURE_VERSION_MAJOR "0")
set(GESTURE_VERSION_MINOR "0")
set(GESTURE_VERSION_PATCH "0")
set(GESTURE_VERSION "${GESTURE_VERSION_MAJOR}.${GESTURE_VERSION_MINOR}.${GESTURE_VERSION_PATCH}")
set(GESTURE_VERSION_DATE "2012.12.30")

# give GESTURE 1 series a few more soversions
set(GESTURE_SOVERSION "00")

set(CMAKE_INSTALL_PREFIX /usr/local)

# fetch all the local directories for generated code
get_filename_component(GESTURE_LIB_DIR ./lib ABSOLUTE)
get_filename_component(GESTURE_BIN_DIR ./bin ABSOLUTE)
get_filename_component(GESTURE_INC_DIR ./include ABSOLUTE)
get_filename_component(GESTURE_SRC_DIR ./src ABSOLUTE)
#get_filename_component(GESTURE_SHARE_DIR ./share ABSOLUTE)
get_filename_component(GESTURE_BUILD_DIR ./build ABSOLUTE)
#get_filename_component(GESTURE_SCRIPTS_DIR ./scripts ABSOLUTE)

set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_SOURCE_DIR}/cmake/Modules/")

set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} -Wall") # -fprofile-arcs -ftest-coverage")
set(CMAKE_C_FLAGS_DEBUG "${CMAKE_C_FLAGS_DEBUG} -Wall") # -fprofile-arcs -ftest-coverage")

set(EXECUTABLE_OUTPUT_PATH ${GESTURE_BIN_DIR})
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${GESTURE_LIB_DIR})

## set the cmake defaults for libraries and binaries
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${GESTURE_LIB_DIR} CACHE PATH 
  "Output directory for the dynamic libraries" )
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${GESTURE_BIN_DIR} CACHE PATH
  "Output directory for the binaries" )
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${GESTURE_LIB_DIR} CACHE PATH 
  "Output directory for the static libraries (archives)" )

## let cmake know where the headers are
include_directories(${GESTURE_INC_DIR})

## copy to jdds/include
file(GLOB_RECURSE INCLUDE_FILES RELATIVE ${GESTURE_SRC_DIR} src/*.h)
foreach(I ${INCLUDE_FILES})
  configure_file(${GESTURE_SRC_DIR}/${I} ${GESTURE_INC_DIR}/jdds/${I} @ONLY)
endforeach()

# Include headers from GRT and find the library
get_filename_component(GRT_ROOT_DIR ../3rd-party/gesture-recognition-toolkit-read-only ABSOLUTE)
get_filename_component(GRT_LIB ${GRT_ROOT_DIR}/GRTBuild/libgrt.a ABSOLUTE)

include_directories(${GRT_ROOT_DIR})

add_subdirectory(src)

