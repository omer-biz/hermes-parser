find_package(PkgConfig REQUIRED)
pkg_check_modules(CHECK REQUIRED check)

find_package(Lua REQUIRED)

add_executable(test_effect
    test_effect.c
    ${CMAKE_SOURCE_DIR}/src/effect.c
)

target_include_directories(test_effect PRIVATE
    ${CHECK_INCLUDE_DIRS}
    ${LUA_INCLUDE_DIR}
    ${CMAKE_SOURCE_DIR}/src
)

target_link_libraries(test_effect PRIVATE
    core
    ${CHECK_LIBRARIES}
    m
    ${LUA_LIBRARIES}
)

target_compile_definitions(test_effect PRIVATE
    LUA_SRC_DIR="${CMAKE_SOURCE_DIR}/lua"
)

add_test(NAME EffectTests COMMAND test_effect)
set_tests_properties(EffectTests PROPERTIES WORKING_DIRECTORY ${CMAKE_SOURCE_DIR})

message(STATUS "CMAKE_SOURCE_DIR = ${CMAKE_SOURCE_DIR}")
