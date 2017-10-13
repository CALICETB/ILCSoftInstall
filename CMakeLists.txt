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

OPTION( ENABLE_C++11 "Set to OFF to disable c++11 compilation" ON )
OPTION( BUILD_QT "Set to OFF to disable Qt build" ON )
OPTION( BUILD_BOOST "Set to OFF to disable BOOST build" ON )
OPTION( BUILD_MYSQL "Set to OFF to disable MySQL build" ON )
OPTION( BUILD_ROOT "Set to OFF to disable ROOT build" ON )
OPTION( BUILD_CED "Set to OFF to disable CED build" ON )
OPTION( BUILD_CONDDB "Set to OFF to disable CondDB build" ON )
OPTION( BUILD_XERCES "Set to OFF to disable Xerces build" ON )
OPTION( BUILD_GSL "Set to OFF to disable GSL build" ON )
OPTION( BUILD_ILCUTIL "Set to OFF to disable ilcutil build" ON )
OPTION( BUILD_CLHEP "Set to OFF to disable CLHEP build" ON )

OPTION( BUILD_CORE "Set to OFF to disable ILCSoft Core build" ON )

#################################################################
# Require C++11                                                 #
#################################################################

IF ( ENABLE_C++11 )

INCLUDE( CheckCXXCompilerFlag )
CHECK_CXX_COMPILER_FLAG("-std=c++11" COMPILER_SUPPORTS_CXX11)
IF( COMPILER_SUPPORTS_CXX11 )
SET (CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11")
ELSE()
MESSAGE( SEND_ERROR "Requires C++11 support. Please upgrade your compiler !" )
ENDIF()

ENDIF()

IF ( NOT ILCSOFT_PATH )
SET ( ILCSOFT_PATH  ${CMAKE_CURRENT_SOURCE_DIR}/ilcsoft )
ENDIF()

###############################
# versions of ilcsoft subpackages
# don't forget to update when releasing
# e.g. SET( Qt_version "v01-00-00" )

### Base
SET( QT_version       "4.7.4" )
SET( ROOT_version     "5.34.36")
SET( CLHEP_version    "2.1.4.1")
SET( GSL_version      "1.14")
SET( ILCUTIL_version  "v01-02-01")
SET( CED_version      "v01-09-02")
SET( CONDDB_version   "CondDBMySQL_ILC-0-9-6")
#SET( XERCES_version   "3.1.4")
SET( XERCES_version   "3.2.0")
SET( BOOST_version    "1.58.0" )
SET( MYSQL_version    "5.1.73" )

### Core
SET( MARLIN_version      "v01-08" )
SET( LCIO_version        "v02-07" )
SET( MarlinUtil_version "v01-09" )
SET( LCCD_version        "v01-03" )
SET( GEAR_version        "v01-05" )

#repositories of ilcsoft packages

### Base
SET( QT_repository         "http://ftp.vim.org/languages/qt/archive/qt/4.7/qt-everywhere-opensource-src-${QT_version}.tar.gz" )
SET( ROOT_repository       "https://root.cern.ch/download/root_v${ROOT_version}.source.tar.gz" )
SET( CLHEP_repository      "http://proj-clhep.web.cern.ch/proj-clhep/DISTRIBUTION/tarFiles/clhep-${CLHEP_version}.tgz" )
SET( GSL_repository        "ftp://ftp.gnu.org/gnu/gsl/gsl-${GSL_version}.tar.gz" )
SET( XERCES_repository     "http://mirrors.ae-online.de/apache//xerces/c/3/sources/xerces-c-${XERCES_version}.tar.gz" )
SET( ILCUTIL_repository    "https://github.com/iLCSoft/iLCUtil.git" )
SET( CED_repository        "https://github.com/iLCSoft/CED.git" )
SET( CONDDB_repository     "https://github.com/iLCSoft/CondDBMySQL.git" )
SET( BOOST_repository      "https://github.com/boostorg/boost.git" )
SET( MYSQL_repository      "http://dev.mysql.com/get/Downloads/MySQL-5.1/mysql-${MYSQL_version}.tar.gz" )

### Core
SET( MARLIN_repository      "https://github.com/iLCSoft/Marlin.git" )
SET( LCIO_repository        "https://github.com/iLCSoft/LCIO.git" )
SET( MarlinUtil_repository  "https://github.com/iLCSoft/MarlinUtil.git" )
SET( LCCD_repository        "https://github.com/iLCSoft/LCCD.git" )
SET( GEAR_repository        "https://github.com/iLCSoft/GEAR.git" )

###################################

LIST( APPEND CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR}/cmake )
INCLUDE( default_settings )
INCLUDE( ILCPackageAddMacro )

###################################

# Append Modules to a list

IF( BUILD_CLHEP )
LIST( APPEND Modules CLHEP/${CLHEP_version} )
ENDIF()
IF( BUILD_GSL )
LIST( APPEND Modules GSL/${GSL_version} )
ENDIF()
IF( BUILD_XERCES )
LIST( APPEND Modules xerces/${XERCES_version} )
ENDIF()
IF( BUILD_ILCUTIL )
LIST( APPEND Modules ilcutil/${ILCUTIL_version} )
ENDIF()
IF( BUILD_CED )
LIST( APPEND Modules CED/${CED_version} )
ENDIF()
IF( BUILD_QT )
LIST( APPEND Modules QT/${QT_version} )
ENDIF()
IF( BUILD_CONDDB )
LIST( APPEND Modules CondDBMySQL/${CONDDB_version} )
ENDIF()
IF( BUILD_ROOT )
LIST( APPEND Modules root/${ROOT_version} )
ENDIF()
IF( BUILD_CORE )
LIST( APPEND Modules MarlinUtil/${MarlinUtil_version} )
LIST( APPEND Modules Marlin/${MARLIN_version} )
LIST( APPEND Modules LCIO/${LCIO_version} )
LIST( APPEND Modules lccd/${LCCD_version} )
LIST( APPEND Modules gear/${GEAR_version} )
ENDIF()
IF( BUILD_BOOST )
LIST( APPEND Modules boost/${BOOST_version} )
ENDIF()

IF( BUILD_MYSQL )
LIST( APPEND Modules mysql/${MYSQL_version} )
ENDIF()

###################################

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
     "-DINSTALL_DOC=OFF"
)

INCLUDE( DetectDistribution )

INCLUDE ( ILCSoft_Base )

IF( BUILD_CORE)
INCLUDE ( ILCSoft_Core )
ENDIF()

# ------ Prepare init_ilcsoft.sh ------------

FILE( WRITE ${ILCSOFT_PATH}/init_ilcsoft.sh "#!/bin/bash\n" )
FILE( APPEND ${ILCSOFT_PATH}/init_ilcsoft.sh "\n" )
FILE( APPEND ${ILCSOFT_PATH}/init_ilcsoft.sh "export ILCSOFT=${ILCSOFT_PATH}" )
FILE( APPEND ${ILCSOFT_PATH}/init_ilcsoft.sh "\n" )
FILE( APPEND ${ILCSOFT_PATH}/init_ilcsoft.sh "\n" )

# ------- Create MySQL environment and make symbolic link in ILCSOFT_PATH ------

IF( NOT BUILD_MYSQL )

IF( NOT MYSQL_DIR )
MESSAGE ( FATAL_ERROR "Provide MYSQL_DIR as CMake argument like -DMYSQL_DIR=/usr" )
ENDIF()

FIND_PACKAGE( MySQL REQUIRED )
IF ( MYSQL_FOUND )

MESSAGE( STATUS "MySQL found in ${MYSQL_DIR}" )

execute_process(
	COMMAND mkdir mysql
	WORKING_DIRECTORY ${ILCSOFT_PATH}
	)

execute_process(
	COMMAND ln -s ${MYSQL_DIR} ${MYSQL_version}
	WORKING_DIRECTORY ${ILCSOFT_PATH}/mysql
	)

execute_process(
	COMMAND ${CMAKE_COMMAND} -DILCSOFT_PATH=${ILCSOFT_PATH} -Dname=MYSQL -Dtargetdir=${ILCSOFT_PATH}/mysql/${MYSQL_version} -P ${CMAKE_CURRENT_SOURCE_DIR}/cmake/WriteInit.cmake
	WORKING_DIRECTORY ${ILCSOFT_PATH}
	)

LIST( APPEND Modules mysql/${MYSQL_version} )

ENDIF()
ENDIF()

MESSAGE( STATUS "Writing init_ilcsoft.sh in ${ILCSOFT_PATH}" )

# ------ Creates ILCSoft.cmake --------------

INCLUDE( CreateILCSoftCMake )

# display some variables and write them to cache
DISPLAY_STD_VARIABLES()
