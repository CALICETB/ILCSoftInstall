# ------ Gear ---------------------

ILCSoftPackage_Add( GEAR
    DEPENDS ROOT ILCUTIL
    GIT_REPOSITORY ${GEAR_repository}
    GIT_TAG ${GEAR_version}
    SOURCE_DIR ${ILCSOFT_PATH}/gear/${GEAR_version}/gear
    UPDATE_COMMAND ""
    CMAKE_ARGS ${common_cmake_args} -DCMAKE_INSTALL_PREFIX=<INSTALL_DIR> -DGEAR_TGEO=ON -C ${ILCSOFT_PATH}/ILCSoft.cmake
    BINARY_DIR ${ILCSOFT_PATH}/gear/${GEAR_version}/build
    BUILD_COMMAND make -j4
    INSTALL_DIR ${ILCSOFT_PATH}/gear/${GEAR_version}
    LIST_SEPARATOR %
)

# ------ LCIO ---------------------

ILCSoftPackage_Add( LCIO
    DEPENDS ROOT CLHEP
    GIT_REPOSITORY ${LCIO_repository}
    GIT_TAG ${LCIO_version}
    SOURCE_DIR ${ILCSOFT_PATH}/LCIO/${LCIO_version}/LCIO
    UPDATE_COMMAND ""
    CMAKE_ARGS ${common_cmake_args} -DCMAKE_INSTALL_PREFIX=<INSTALL_DIR> -DBUILD_ROOTDICT=ON -C ${ILCSOFT_PATH}/ILCSoft.cmake
    BINARY_DIR ${ILCSOFT_PATH}/LCIO/${LCIO_version}/build
    BUILD_COMMAND make -j4
    INSTALL_DIR ${ILCSOFT_PATH}/LCIO/${LCIO_version}
    LIST_SEPARATOR %
)

# ------ LCCD ---------------------

ILCSoftPackage_Add( LCCD
    DEPENDS ILCUTIL LCIO CONDDB
    GIT_REPOSITORY ${LCCD_repository}
    GIT_TAG ${LCCD_version}
    SOURCE_DIR ${ILCSOFT_PATH}/lccd/${LCCD_version}/lccd
    UPDATE_COMMAND ""
    CMAKE_ARGS ${common_cmake_args} -DCMAKE_INSTALL_PREFIX=<INSTALL_DIR> -C ${ILCSOFT_PATH}/ILCSoft.cmake
    BINARY_DIR ${ILCSOFT_PATH}/lccd/${LCCD_version}/build
    BUILD_COMMAND make -j4
    INSTALL_DIR ${ILCSOFT_PATH}/lccd/${LCCD_version}
    LIST_SEPARATOR %
)

# ------ Marlin ---------------------

ILCSoftPackage_Add( MARLIN
    DEPENDS ILCUTIL LCIO GEAR CLHEP LCCD 
    GIT_REPOSITORY ${MARLIN_repository}
    GIT_TAG ${MARLIN_version}
    SOURCE_DIR ${ILCSOFT_PATH}/Marlin/${MARLIN_version}/Marlin
    UPDATE_COMMAND ""
    CMAKE_ARGS ${common_cmake_args} -DCMAKE_INSTALL_PREFIX=<INSTALL_DIR> -DMARLIN_AIDA=OFF -C ${ILCSOFT_PATH}/ILCSoft.cmake
    BINARY_DIR ${ILCSOFT_PATH}/Marlin/${MARLIN_version}/build
    BUILD_COMMAND make -j4
    INSTALL_DIR ${ILCSOFT_PATH}/Marlin/${MARLIN_version}
    LIST_SEPARATOR %
)

# ------ MarlinUtil ------------------

ILCSoftPackage_Add( MARLINUTIL
    DEPENDS ILCUTIL MARLIN CED CLHEP GSL
    GIT_REPOSITORY ${MarlinUtil_repository}
    GIT_TAG ${MarlinUtil_version}
    SOURCE_DIR ${ILCSOFT_PATH}/MarlinUtil/${MarlinUtil_version}/MarlinUtil
    UPDATE_COMMAND ""
    CMAKE_ARGS ${common_cmake_args} -DCMAKE_INSTALL_PREFIX=<INSTALL_DIR> -C ${ILCSOFT_PATH}/ILCSoft.cmake
    BINARY_DIR ${ILCSOFT_PATH}/MarlinUtil/${MarlinUtil_version}/build
    BUILD_COMMAND make -j4
    INSTALL_DIR ${ILCSOFT_PATH}/MarlinUtil/${MarlinUtil_version}
    LIST_SEPARATOR %
)
