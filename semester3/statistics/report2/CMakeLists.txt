cmake_minimum_required(VERSION 3.2)

project(mpislist2 VERSION 1.0.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS}\
                    -Wall\
                    -Wextra\
                    -Wpedantic\
")


file(GLOB_RECURSE SOURCE_FILES src/*.cpp)

add_executable(mpislist2 ${SOURCE_FILES})
