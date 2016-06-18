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
MESSAGE( SEND_ERROR "dCache-gui requires C++11 support. Please upgrade your compiler !" )
ENDIF()

###############################
# versions of ilcsoft subpackages
# don't forget to update when releasing 
# e.g. SET( Qt_version "v01-00-00" )

SET( Qt_version     "4.7.4" )
SET( ROOT_version   "5.34.36")

#repositories of ilcsoft packages

SET( Qt_repository  "http://ftp.vim.org/languages/qt/archive/qt/4.7/qt-everywhere-opensource-src-${Qt_version}.tar.gz" )
SET( ROOT_repository "https://root.cern.ch/download/root_v${ROOT_version}.source.tar.gz" )

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

# ----- Qt package -----

ExternalProject_Add( Qt
    URL ${Qt_repository}
    SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/ilcsoft/QT
    UPDATE_COMMAND ""
    BUILD_IN_SOURCE 1
    CONFIGURE_COMMAND ./configure -debug-and-release -opensource -confirm-license -no-qt3support -webkit -nomake examples -nomake demos
    BUILD_COMMAND make -j4
    INSTALL_COMMAND ""
    LIST_SEPARATOR %
)

# ------------ ROOT -----------

ExternalProject_Add( ROOT
    DEPENDS Qt
    URL ${ROOT_repository}
    SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/ilcsoft/root
    UPDATE_COMMAND ""
    BUILD_IN_SOURCE 1
    CONFIGURE_COMMAND ./configure --with-cc=${CMAKE_C_COMPILER}
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


# display some variables and write them to cache
DISPLAY_STD_VARIABLES()
