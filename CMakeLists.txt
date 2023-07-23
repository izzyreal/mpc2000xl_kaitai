cmake_minimum_required(VERSION 3.18)

include(FetchContent)

FetchContent_Declare(kaitai_runtime
        GIT_REPOSITORY https://github.com/izzyreal/kaitai_struct_cpp_stl_runtime
        GIT_TAG        master-easy-cmake-include
)

FetchContent_MakeAvailable(kaitai_runtime)

set(CMAKE_CXX_STANDARD 11)

project(mpc2000xl_ksy_test VERSION 0.1)

add_executable(mpc2000xl_ksy_test src/main.cpp src/parser/mpc2000xl_all.h src/parser/mpc2000xl_all.cpp)

target_link_libraries(mpc2000xl_ksy_test PRIVATE kaitai_struct_cpp_stl_runtime)

target_include_directories(mpc2000xl_ksy_test PRIVATE
        ${kaitai_runtime_SOURCE_DIR})

