# ome-files superbuild

# Options to build from git (defaults to source zip if unset)
set(ome-files-head ${head} CACHE BOOL "Force building from current git develop branch")
set(ome-files-dir "" CACHE PATH "Local directory containing the OME Files source code")
set(ome-files-git-url "" CACHE STRING "URL of OME Files git repository")
set(ome-files-git-branch "" CACHE STRING "URL of OME Files git repository")

# Current stable release.
set(RELEASE_URL "https://downloads.openmicroscopy.org/ome-files-cpp/0.2.2/source/ome-files-cpp-0.2.2.tar.xz")
set(RELEASE_HASH "SHA512=f454f86c698e10be1e6ec4c9bcba46d2183c1919f379562fa9630c49a7fb14b869d6c9732990c6edb0072169ba10e53bdc8e9ef28bfbbfa87e71f4176654711c")

# Current development branch (defaults for ome-files-head option).
set(GIT_URL "https://github.com/ome/ome-files.git")
set(GIT_BRANCH "develop")

if(NOT ome-files-head)
  if(ome-files-git-url)
    set(GIT_URL ${ome-files-git-url})
  endif()
  if(ome-files-git-branch)
    set(GIT_BRANCH ${ome-files-git-branch})
  endif()
endif()

if(ome-files-dir)
  set(EP_SOURCE_DOWNLOAD
    DOWNLOAD_COMMAND "")
  set(EP_SOURCE_DIR "${ome-files-dir}")
  message(STATUS "Building OME Files C++ from local directory (${ome-files-dir})")
elseif(ome-files-head OR ome-files-git-url OR ome-files-git-branch)
  set(EP_SOURCE_DOWNLOAD
    GIT_REPOSITORY "${GIT_URL}"
    GIT_TAG "${GIT_BRANCH}"
    UPDATE_DISCONNECTED 1)
  message(STATUS "Building OME Files C++ from git (URL ${GIT_URL}, branch/tag ${GIT_BRANCH})")
else()
  set(EP_SOURCE_DOWNLOAD
    URL "${RELEASE_URL}"
    URL_HASH "${RELEASE_HASH}")
  message(STATUS "Building OME Files C++ from source release (${RELEASE_URL})")
endif()

# Set dependency list
ome_add_dependencies(ome-files
                     DEPENDENCIES ome-xml
                     THIRD_PARTY_DEPENDENCIES boost png tiff
                                              py-sphinx gtest)

unset(CONFIGURE_OPTIONS)
list(APPEND CONFIGURE_OPTIONS
     "-DBOOST_ROOT=${OME_EP_INSTALL_DIR}"
     -DBoost_NO_BOOST_CMAKE:BOOL=true
     ${SUPERBUILD_OPTIONS})
if(TARGET gtest)
  list(APPEND CONFIGURE_OPTIONS "-DGTEST_SOURCE=${CMAKE_BINARY_DIR}/gtest-source")
endif()
if(SOURCE_ARCHIVE_DIR)
  list(APPEND CONFIGURE_OPTIONS "-DSOURCE_ARCHIVE_DIR=${SOURCE_ARCHIVE_DIR}")
endif()
string(REPLACE ";" "^^" CONFIGURE_OPTIONS "${CONFIGURE_OPTIONS}")

ExternalProject_Add(${EP_PROJECT}
  ${OME_EP_COMMON_ARGS}
  ${EP_SOURCE_DOWNLOAD}
  SOURCE_DIR ${EP_SOURCE_DIR}
  BINARY_DIR ${EP_BINARY_DIR}
  INSTALL_DIR ""
  CONFIGURE_COMMAND ${CMAKE_COMMAND}
    "-DSOURCE_DIR:PATH=${EP_SOURCE_DIR}"
    "-DBUILD_DIR:PATH=${EP_BINARY_DIR}"
    "-DCONFIGURE_OPTIONS=${CONFIGURE_OPTIONS}"
    "-DCONFIG:INTERNAL=$<CONFIG>"
    "-DEP_SCRIPT_CONFIG:FILEPATH=${EP_SCRIPT_CONFIG}"
    -P "${GENERIC_CMAKE_CONFIGURE}"
  BUILD_COMMAND ${CMAKE_COMMAND}
    "-DSOURCE_DIR:PATH=${EP_SOURCE_DIR}"
    "-DBUILD_DIR:PATH=${EP_BINARY_DIR}"
    "-DCONFIG:INTERNAL=$<CONFIG>"
    "-DEP_SCRIPT_CONFIG:FILEPATH=${EP_SCRIPT_CONFIG}"
    -P "${GENERIC_CMAKE_BUILD}"
  INSTALL_COMMAND ${CMAKE_COMMAND}
    "-DSOURCE_DIR:PATH=${EP_SOURCE_DIR}"
    "-DBUILD_DIR:PATH=${EP_BINARY_DIR}"
    "-DCONFIG:INTERNAL=$<CONFIG>"
    "-DEP_SCRIPT_CONFIG:FILEPATH=${EP_SCRIPT_CONFIG}"
    -P "${GENERIC_CMAKE_INSTALL}"
  TEST_COMMAND ${CMAKE_COMMAND}
    "-DSOURCE_DIR:PATH=${EP_SOURCE_DIR}"
    "-DBUILD_DIR:PATH=${EP_BINARY_DIR}"
    "-DCONFIG:INTERNAL=$<CONFIG>"
    "-DEP_SCRIPT_CONFIG:FILEPATH=${EP_SCRIPT_CONFIG}"
    -P "${GENERIC_CMAKE_TEST}"
  DEPENDS
    ${EP_PROJECT}-prerequisites
  )
