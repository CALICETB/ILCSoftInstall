# ------------ BOOST ----------

IF ( BUILD_BOOST )

ILCSoftPackage_Add( BOOST
	GIT_REPOSITORY ${BOOST_repository}
    GIT_TAG boost-${BOOST_version}
    SOURCE_DIR ${ILCSOFT_PATH}/boost/${BOOST_version}/boost
    UPDATE_COMMAND ""
    CONFIGURE_COMMAND ${ILCSOFT_PATH}/boost/${BOOST_version}/boost/bootstrap.sh 
    BUILD_IN_SOURCE 1
    BUILD_COMMAND ${ILCSOFT_PATH}/boost/${BOOST_version}/boost/b2 install 
    									--prefix=${ILCSOFT_PATH}/boost/${BOOST_version}
    									--threading=multi
    									--link=shared
    									-j4
    INSTALL_COMMAND ""
    LIST_SEPARATOR %
)

ENDIF()

# ------------ MySQL ----------

IF ( BUILD_MYSQL )

ILCSoftPackage_Add( MYSQL
	DOWNLOAD_COMMAND wget ${MYSQL_repository} && tar xzf mysql-${MYSQL_version}.tar.gz --strip 1 -C ${ILCSOFT_PATH}/mysql/${MYSQL_version}/mysql
    SOURCE_DIR ${ILCSOFT_PATH}/mysql/${MYSQL_version}/mysql
    UPDATE_COMMAND ""
    CONFIGURE_COMMAND ${ILCSOFT_PATH}/mysql/${MYSQL_version}/mysql/configure --prefix=${ILCSOFT_PATH}/mysql/${MYSQL_version}
																			 --with-system-type=debian-linux-gnu
																			 --enable-shared
																			 --enable-static
																			 --enable-thread-safe-client
																			 --enable-assembler
																			 --enable-local-infile
																			 --with-fast-mutexes
																			 --with-big-tables
																			 --with-unix-socket-path=/var/run/mysqld/mysqld.sock
																			 --with-mysqld-user=mysql
																			 --with-libwrap
																			 --with-readline
																			 --with-ssl
																			 --without-docs
																			 --with-extra-charsets=all
																			 --with-plugins=max
																			 --with-embedded-server
																			 --with-embedded-privilege-control
    BINARY_DIR ${ILCSOFT_PATH}/mysql/${MYSQL_version}/build
    BUILD_COMMAND make -j4
    INSTALL_COMMAND make install
    INSTALL_DIR ${ILCSOFT_PATH}/mysql/${MYSQL_version}
    LIST_SEPARATOR %
)

ENDIF()

# ------------ CLHEP ----------

ILCSoftPackage_Add( CLHEP
    DOWNLOAD_COMMAND wget ${CLHEP_repository} && tar xzf clhep-${CLHEP_version}.tgz -C ${ILCSOFT_PATH}/CLHEP
    SOURCE_DIR ${ILCSOFT_PATH}/CLHEP/${CLHEP_version}/CLHEP
    UPDATE_COMMAND ""
    CMAKE_ARGS ${common_cmake_args} -DCMAKE_INSTALL_PREFIX=<INSTALL_DIR>
    BINARY_DIR ${ILCSOFT_PATH}/CLHEP/${CLHEP_version}/build
    BUILD_COMMAND make -j4
    INSTALL_DIR ${ILCSOFT_PATH}/CLHEP/${CLHEP_version}
    LIST_SEPARATOR %
)

# ------------ GSL ----------

ILCSoftPackage_Add( GSL
    DOWNLOAD_COMMAND wget ${GSL_repository} && tar xzf gsl-${GSL_version}.tar.gz --strip 1 -C ${ILCSOFT_PATH}/GSL/${GSL_version}/GSL
    SOURCE_DIR ${ILCSOFT_PATH}/GSL/${GSL_version}/GSL
    UPDATE_COMMAND ""
    CONFIGURE_COMMAND ${ILCSOFT_PATH}/GSL/${GSL_version}/GSL/configure --prefix=${ILCSOFT_PATH}/GSL/${GSL_version}
    BINARY_DIR ${ILCSOFT_PATH}/GSL/${GSL_version}/build
    BUILD_COMMAND make -j4
    INSTALL_DIR ${ILCSOFT_PATH}/GSL/${GSL_version}
    LIST_SEPARATOR %
)


# ------------ XERCES ----------

ILCSoftPackage_Add( XERCES
    DOWNLOAD_COMMAND wget ${XERCES_repository} && tar xzf xerces-c-${XERCES_version}.tar.gz --strip 1 -C ${ILCSOFT_PATH}/xerces/${XERCES_version}/xerces
    SOURCE_DIR ${ILCSOFT_PATH}/xerces/${XERCES_version}/xerces
    UPDATE_COMMAND ""
    CONFIGURE_COMMAND ${ILCSOFT_PATH}/xerces/${XERCES_version}/xerces/configure --prefix=${ILCSOFT_PATH}/xerces/${XERCES_version}
    BINARY_DIR ${ILCSOFT_PATH}/xerces/${XERCES_version}/build
    BUILD_COMMAND make -j4
    INSTALL_DIR ${ILCSOFT_PATH}/xerces/${XERCES_version}
    LIST_SEPARATOR %
)

# ------------ ILCUTIL ----------

ILCSoftPackage_Add( ILCUTIL
    GIT_REPOSITORY ${ILCUTIL_repository}
    GIT_TAG ${ILCUTIL_version}
    SOURCE_DIR ${ILCSOFT_PATH}/ilcutil/${ILCUTIL_version}/ilcutil
    UPDATE_COMMAND ""
    CMAKE_ARGS ${common_cmake_args} -DCMAKE_INSTALL_PREFIX=<INSTALL_DIR>
    BINARY_DIR ${ILCSOFT_PATH}/ilcutil/${ILCUTIL_version}/build
    BUILD_COMMAND make -j4
    INSTALL_DIR ${ILCSOFT_PATH}/ilcutil/${ILCUTIL_version}
    LIST_SEPARATOR %
)

# ------------ CED ----------

ILCSoftPackage_Add( CED
    DEPENDS ILCUTIL
    GIT_REPOSITORY ${CED_repository}
    GIT_TAG ${CED_version}
    SOURCE_DIR ${ILCSOFT_PATH}/CED/${CED_version}/CED
    UPDATE_COMMAND ""
    CMAKE_ARGS ${common_cmake_args} -DCMAKE_INSTALL_PREFIX=<INSTALL_DIR> -C ${ILCSOFT_PATH}/ILCSoft.cmake
    BINARY_DIR ${ILCSOFT_PATH}/CED/${CED_version}/build
    BUILD_COMMAND make -j4
    INSTALL_DIR ${ILCSOFT_PATH}/CED/${CED_version}
    LIST_SEPARATOR %
)

# ------------ CONDDB ----------

ILCSoftPackage_Add( CONDDB
    DEPENDS ILCUTIL MYSQL
    GIT_REPOSITORY ${CONDDB_repository}
    GIT_TAG ${CONDDB_version}
    SOURCE_DIR ${ILCSOFT_PATH}/CondDBMySQL/${CONDDB_version}/CondDBMySQL
    UPDATE_COMMAND ""
    CMAKE_ARGS ${common_cmake_args} -DCMAKE_INSTALL_PREFIX=<INSTALL_DIR> IF BUILD_MYSQL THEN -DMySQL_DIR=${ILCSOFT_PATH}/mysql/${MYSQL_version} ENDIF -C ${ILCSOFT_PATH}/ILCSoft.cmake
    BINARY_DIR ${ILCSOFT_PATH}/CondDBMySQL/${CONDDB_version}/build
    BUILD_COMMAND make -j4
    INSTALL_DIR ${ILCSOFT_PATH}/CondDBMySQL/${CONDDB_version}
    LIST_SEPARATOR %
)

# ----- QT package -----

IF( BUILD_QT )

ILCSoftPackage_Add( QT
    URL ${QT_repository}
    SOURCE_DIR ${ILCSOFT_PATH}/QT/${QT_version}
    UPDATE_COMMAND ""
    BUILD_IN_SOURCE 1
    CONFIGURE_COMMAND ./configure -prefix ${ILCSOFT_PATH}/QT/${QT_version} -opensource -confirm-license -fast -make libs -no-separate-debug-info -no-xkb -no-xinerama
    BUILD_COMMAND make -j4
    INSTALL_COMMAND make install
    LIST_SEPARATOR %
)

ENDIF()

# ------------ ROOT -----------

ILCSoftPackage_Add( ROOT
    DEPENDS GSL CLHEP XERCES
    		IF BUILD_QT THEN
    		QT
    		ENDIF
    		IF BUILD_MYSQL THEN
    		MYSQL
    		ENDIF
    URL ${ROOT_repository}
    SOURCE_DIR ${ILCSOFT_PATH}/root/${ROOT_version}
    UPDATE_COMMAND ""
    BUILD_IN_SOURCE 1
    CONFIGURE_COMMAND IF BUILD_QT THEN 
    				  export QTDIR=${ILCSOFT_PATH}/QT/${QT_version} && 
    				  ENDIF 
    				  ./configure --with-cc=${CMAKE_C_COMPILER}
                                    --with-cxx=${CMAKE_CXX_COMPILER}
                                    --with-ld=${CMAKE_CXX_COMPILER}
                                    --fail-on-missing
                                    --enable-builtin-pcre 
                                    --enable-explicitlink 
                                    --enable-soversion
                                    --enable-gdml
                                    --enable-genvector
                                    --enable-krb5
                                    --enable-mathmore
                                    --enable-minuit2
                                    --enable-mysql
                                    --enable-unuran
                                    --enable-gsl-shared 
                                    --with-gsl-incdir=${ILCSOFT_PATH}/GSL/${GSL_version}/include
                                    --with-gsl-libdir=${ILCSOFT_PATH}/GSL/${GSL_version}/lib
                                    --disable-oracle
				                    --disable-gfal
                                    --enable-python
                                    --enable-roofit
                                    --enable-table
                                    IF BUILD_QT THEN
                                    --enable-qt
                                    ENDIF
    BUILD_COMMAND make -j4
    INSTALL_COMMAND ""
    LIST_SEPARATOR %
)
