cmake_minimum_required(VERSION 3.1)

project(Victoria LANGUAGES CXX)

set(CMAKE_INCLUDE_CURRENT_DIR ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt5 COMPONENTS Core Widgets Quick QuickControls2 WebEngine LinguistTools REQUIRED)

SET(victoria_ts_files
    i18n/victoria_base.ts
    i18n/victoria_de.ts
)

qt5_add_translation(victoria_qm_files ${victoria_ts_files})

add_executable(${PROJECT_NAME} "main.cpp" "qml/qml.qrc" "fonts/fonts.qrc" ${victoria_qm_files})
target_compile_definitions(${PROJECT_NAME} PRIVATE $<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:QT_QML_DEBUG>)
target_link_libraries(${PROJECT_NAME} PRIVATE Qt5::Core Qt5::Widgets Qt5::Quick Qt5::QuickControls2 Qt5::WebEngine)

install(FILES ${victoria_qm_files} DESTINATION share/me.appadeia.Victoria/i18n)
install(FILES data/me.appadeia.Victoria.svg DESTINATION share/icons/hicolor/scalable/apps)
install(FILES data/me.appadeia.Victoria.desktop DESTINATION share/application)
