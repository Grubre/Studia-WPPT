cmake_minimum_required(VERSION 3.18)
project(MyCudaProject LANGUAGES CXX CUDA)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

if(CMAKE_PROJECT_NAME STREQUAL PROJECT_NAME)
  set(CMAKE_CXX_STANDARD 20)
  set(CMAKE_CUDA_STANDARD 20)
  set(CMAKE_CXX_STANDARD_REQUIRED ON)

  set_property(GLOBAL PROPERTY USE_FOLDERS ON)
endif()

add_subdirectory(src)
