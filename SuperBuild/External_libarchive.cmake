#-----------------------------------------------------------------------------
# Get and build LIBARCHIVE (libarchive)

set(libarchive_URL http://libarchive.googlecode.com/files/libarchive-2.7.1.tar.gz)
set(libarchive_MD5 f43382413b4457d0e192771b100a66e7)

set(proj libarchive)

ExternalProject_Add(${proj}
  URL ${libarchive_URL}
  URL_MD5 ${libarchive_MD5}
  SOURCE_DIR libarchive
  BINARY_DIR libarchive-build
  INSTALL_DIR libarchive-install
  CMAKE_GENERATOR ${gen}
  CMAKE_ARGS
    ${ep_common_args}
    -DCMAKE_CXX_FLAGS:STRING=${ep_common_cxx_flags}
    -DCMAKE_C_FLAGS:STRING=${ep_common_c_flags}
    -DBUILD_SHARED_LIBS:BOOL=ON
    -DENABLE_TAR_SHARED:BOOL=ON
    -DENABLE_ACL:BOOL=OFF
    -DENABLE_TEST:BOOL=OFF
    -DCMAKE_INSTALL_PREFIX:PATH=<INSTALL_DIR>
  DEPENDS 
    ${libarchive_DEPENDENCIES}
)

set(LIBARCHIVE_DIR ${CMAKE_BINARY_DIR}/libarchive-install)
set(LIBARCHIVE_INCLUDE_DIR ${LIBARCHIVE_DIR}/include)
set(LIBARCHIVE_LIBRARY)

if(WIN32)
  set(LIBARCHIVE_LIBRARY ${LIBARCHIVE_DIR}/lib/archive.lib)
elseif(APPLE)
  set(LIBARCHIVE_LIBRARY ${LIBARCHIVE_DIR}/lib/libarchive.dylib)
else()
  set(LIBARCHIVE_LIBRARY ${LIBARCHIVE_DIR}/lib/libarchive.so)
endif()
