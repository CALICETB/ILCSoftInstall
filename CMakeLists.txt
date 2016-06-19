########################################################
# cmake file for building
# @author Eldwan Brianne
CMAKE_MINIMUM_REQUIRED(VERSION 2.6 FATAL_ERROR)
########################################################

# project name
PROJECT( ILCSoftInstall )

### PACKAGE VERSIONS ########################################################
SET( ${PROJECT_NAME}_VERSION_MAJOR 1 )
SET( ${PROJECT_NAME}_VERSION_MINOR 0 )
SET( ${PROJECT_NAME}_VERSION_PATCH 0 )

#################################################################
# Require C++11                                                 #
#################################################################

INCLUDE( CheckCXXCompilerFlag )

CHECK_CXX_COMPILER_FLAG("-std=c++11" COMPILER_SUPPORTS_CXX11)

IF( COMPILER_SUPPORTS_CXX11 )
SET (CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11")
ELSE()
MESSAGE( SEND_ERROR "Requires C++11 support. Please upgrade your compiler !" )
ENDIF()

###############################
# versions of ilcsoft subpackages
# don't forget to update when releasing 
# e.g. SET( Qt_version "v01-00-00" )

SET( QT_version       "4.7.4" )
SET( ROOT_version     "5.34.36")
SET( CLHEP_version    "2.1.4.1")
SET( GSL_version      "1.14")
SET( ILCUTIL_version  "v01-02-01")
SET( CED_version      "v01-09-02")
SET( CONDDB_version   "CondDBMySQL_ILC-0-9-6")
SET( XERCES_version   "3.1.3")

#repositories of ilcsoft packages

SET( QT_repository         "http://ftp.vim.org/languages/qt/archive/qt/4.7/qt-everywhere-opensource-src-${QT_version}.tar.gz" )
SET( ROOT_repository       "https://root.cern.ch/download/root_v${ROOT_version}.source.tar.gz" )
SET( CLHEP_repository      "http://proj-clhep.web.cern.ch/proj-clhep/DISTRIBUTION/tarFiles/clhep-${CLHEP_version}.tgz" )
SET( GSL_repository        "ftp://ftp.gnu.org/gnu/gsl/gsl-${GSL_version}.tar.gz" )
SET( XERCES_repository     "http://mirrors.ae-online.de/apache//xerces/c/3/sources/xerces-c-${XERCES_version}.tar.gz" )
SET( ILCUTIL_repository    "https://github.com/iLCSoft/iLCUtil.git" )
SET( CED_repository        "https://github.com/iLCSoft/CED.git" )
SET( CONDDB_repository     "https://github.com/iLCSoft/CondDBMySQL.git" )

###################################

LIST( APPEND CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR}/cmake )
INCLUDE( default_settings )

INCLUDE( ExternalProject )

# In order to pass semicolon-separated lists over the command line to all packages,
# we need to separate list elements with '%' instead of the standard cmake list separator ';'
# The list separator needs also to be redefined in the ExternalProject_Add calls by setting
# the variable LIST_SEPARATOR

FOREACH( _path ${CMAKE_PREFIX_PATH} )
    SET( CMAKE_PREFIX_PATH_FIXED ${CMAKE_PREFIX_PATH_FIXED}%${_path} )
ENDFOREACH()

FOREACH( _path ${CMAKE_MODULE_PATH} )
    SET( CMAKE_MODULE_PATH_FIXED ${CMAKE_MODULE_PATH_FIXED}%${_path} )
ENDFOREACH()

# ----- cmake arguments common to ALL cmake packages -------------------------
SET( common_cmake_args
     "-DCMAKE_PREFIX_PATH=${CMAKE_PREFIX_PATH_FIXED}"
     "-DCMAKE_MODULE_PATH=${CMAKE_MODULE_PATH_FIXED}"
     "-DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX}"
)

INCLUDE( DetectDistribution )

SET ( ILCSOFT_PATH  ${CMAKE_CURRENT_SOURCE_DIR}/ilcsoft )

# ------------ CLHEP ----------

ExternalProject_Add( CLHEP
    DOWNLOAD_COMMAND wget ${CLHEP_repository} && tar xzf clhep-${CLHEP_version}.tgz -C ${ILCSOFT_PATH}/CLHEP
    SOURCE_DIR ${ILCSOFT_PATH}/CLHEP/${CLHEP_version}/CLHEP
    UPDATE_COMMAND ""
    CMAKE_ARGS ${common_cmake_args} -DCMAKE_INSTALL_PREFIX=<INSTALL_DIR>
    BINARY_DIR ${ILCSOFT_PATH}/CLHEP/${CLHEP_version}/build
    BUILD_COMMAND make -j4
    INSTALL_DIR ${ILCSOFT_PATH}/CLHEP/${CLHEP_version}
    LIST_SEPARATOR %
)

LIST( APPEND Modules CLHEP/${CLHEP_version} )

# ------------ GSL ----------

ExternalProject_Add( GSL
    DOWNLOAD_COMMAND wget ${GSL_repository} && tar xzf gsl-${GSL_version}.tar.gz --strip 1 -C ${ILCSOFT_PATH}/GSL/${GSL_version}/GSL
    SOURCE_DIR ${ILCSOFT_PATH}/GSL/${GSL_version}/GSL
    UPDATE_COMMAND ""
    CONFIGURE_COMMAND ${ILCSOFT_PATH}/GSL/${GSL_version}/GSL/configure --prefix=${ILCSOFT_PATH}/GSL/${GSL_version}
    BINARY_DIR ${ILCSOFT_PATH}/GSL/${GSL_version}/build
    BUILD_COMMAND make -j4
    INSTALL_DIR ${ILCSOFT_PATH}/GSL/${GSL_version}
    LIST_SEPARATOR %
)

LIST( APPEND Modules GSL/${GSL_version} )

# ------------ XERCES ----------

ExternalProject_Add( XERCES
    DOWNLOAD_COMMAND wget ${XERCES_repository} && tar xzf xerces-c-${XERCES_version}.tar.gz --strip 1 -C ${ILCSOFT_PATH}/xerces/${XERCES_version}/xerces
    SOURCE_DIR ${ILCSOFT_PATH}/xerces/${XERCES_version}/xerces
    UPDATE_COMMAND ""
    CONFIGURE_COMMAND ${ILCSOFT_PATH}/xerces/${XERCES_version}/xerces/configure --prefix=${ILCSOFT_PATH}/xerces/${XERCES_version}
    BINARY_DIR ${ILCSOFT_PATH}/xerces/${XERCES_version}/build
    BUILD_COMMAND make -j4
    INSTALL_DIR ${ILCSOFT_PATH}/xerces/${XERCES_version}
    LIST_SEPARATOR %
)

LIST( APPEND Modules xerces/${XERCES_version} )

# ------------ ILCUTIL ----------

ExternalProject_Add( ILCUTIL
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

LIST( APPEND Modules ilcutil/${ILCUTIL_version} )

# ------------ CED ----------

ExternalProject_Add( CED
    DEPENDS ILCUTIL
    GIT_REPOSITORY ${CED_repository}
    GIT_TAG ${CED_version}
    SOURCE_DIR ${ILCSOFT_PATH}/CED/${CED_version}/CED
    UPDATE_COMMAND ""
    CMAKE_ARGS ${common_cmake_args} -DCMAKE_INSTALL_PREFIX=<INSTALL_DIR> -DCMAKE_PREFIX_PATH=<INSTALL_DIR>
    BINARY_DIR ${ILCSOFT_PATH}/CED/${CED_version}/build
    BUILD_COMMAND make -j4
    INSTALL_DIR ${ILCSOFT_PATH}/CED/${CED_version}
    LIST_SEPARATOR %
)

LIST( APPEND Modules CED/${CED_version} )

# ------------ CONDDB ----------

ExternalProject_Add( CONDDB
    DEPENDS ILCUTIL
    GIT_REPOSITORY ${CONDDB_repository}
    GIT_TAG ${CONDDB_version}
    SOURCE_DIR ${ILCSOFT_PATH}/CondDBMySQL/${CONDDB_version}/CondDBMySQL
    UPDATE_COMMAND ""
    CMAKE_ARGS ${common_cmake_args} -DCMAKE_INSTALL_PREFIX=<INSTALL_DIR> -DCMAKE_PREFIX_PATH=<INSTALL_DIR>
    BINARY_DIR ${ILCSOFT_PATH}/CondDBMySQL/build
    BUILD_COMMAND make -j4
    INSTALL_DIR ${ILCSOFT_PATH}/CondDBMySQL/${CONDDB_version}
    LIST_SEPARATOR %
)

LIST( APPEND Modules CondDBMySQL/${CONDDB_version} )

# ----- QT package -----

ExternalProject_Add( QT
    URL ${QT_repository}
    SOURCE_DIR ${ILCSOFT_PATH}/QT/${QT_version}
    UPDATE_COMMAND ""
    BUILD_IN_SOURCE 1
    CONFIGURE_COMMAND ./configure -debug-and-release -opensource -confirm-license -no-qt3support -webkit -nomake examples -nomake demos
    BUILD_COMMAND make -j4
    INSTALL_COMMAND ""
    LIST_SEPARATOR %
)

LIST( APPEND Modules QT/${QT_version} )

# ------------ ROOT -----------

ExternalProject_Add( ROOT
    DEPENDS QT GSL
    URL ${ROOT_repository}
    SOURCE_DIR ${ILCSOFT_PATH}/root/${ROOT_version}
    UPDATE_COMMAND ""
    BUILD_IN_SOURCE 1
    CONFIGURE_COMMAND export QTDIR=${ILCSOFT_PATH}/QT/${QT_version} && 
    							  ./configure --with-cc=${CMAKE_C_COMPILER}
                                  --with-cxx=${CMAKE_CXX_COMPILER}
                                  --with-ld=${CMAKE_CXX_COMPILER}
                                  --fail-on-missing
                                  --enable-gdml
                                  --enable-genvector
                                  --enable-krb5
                                  --enable-mathmore
                                  --enable-minuit2
                                  --enable-mysql
                                  --disable-oracle
				                  --disable-gfal
                                  --enable-python
                                  --enable-qt
                                  --enable-roofit
                                  --enable-table
    BUILD_COMMAND make -j4
    INSTALL_COMMAND ""
    LIST_SEPARATOR %
)

LIST( APPEND Modules root/${ROOT_version} )

# ------ Creates ILCSoft.cmake --------------

STRING( TIMESTAMP TIME "%Y-%m-%d %H:%M:%S" )

FILE( WRITE ${ILCSOFT_PATH}/ILCSoft.cmake  "################################################################################\n" )
FILE( APPEND ${ILCSOFT_PATH}/ILCSoft.cmake "# Environment script generated by CMake on ${TIME} \n" )
FILE( APPEND ${ILCSOFT_PATH}/ILCSoft.cmake "# for the installation located at [ ${ILCSOFT_PATH} ]\n" )
FILE( APPEND ${ILCSOFT_PATH}/ILCSoft.cmake "################################################################################\n" )
FILE( APPEND ${ILCSOFT_PATH}/ILCSoft.cmake "\n" )
FILE( APPEND ${ILCSOFT_PATH}/ILCSoft.cmake "SET( ILC_HOME \"${ILCSOFT_PATH}\" CACHE PATH \"Path to ILC Software\" FORCE)\n" )
FILE( APPEND ${ILCSOFT_PATH}/ILCSoft.cmake "MARK_AS_ADVANCED( ILC_HOME )\n" )
FILE( APPEND ${ILCSOFT_PATH}/ILCSoft.cmake "\n" )
FILE( APPEND ${ILCSOFT_PATH}/ILCSoft.cmake "SET( CMAKE_PREFIX_PATH\n" )
FOREACH( mod ${Modules} )
FILE( APPEND ${ILCSOFT_PATH}/ILCSoft.cmake "\t \${ILC_HOME}/${mod};\n" )
ENDFOREACH()
FILE( APPEND ${ILCSOFT_PATH}/ILCSoft.cmake "CACHE PATH \"CMAKE_PREFIX_PATH\" FORCE )\n" )


# display some variables and write them to cache
DISPLAY_STD_VARIABLES()
