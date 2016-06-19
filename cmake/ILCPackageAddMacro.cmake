include(ExternalProject)
include(CMakeParseArguments)

macro(ILCSoftPackage_Add name)

SET( targetname ${name} )

cmake_parse_arguments(ARG "" "DEPENDS;INSTALL_DIR;SOURCE_DIR;BUILD_IN_SOURCE" "" ${ARGN})

IF(ARG_INSTALL_DIR)
SET( targetdir ${ARG_INSTALL_DIR} )
ELSE ()
SET( targetdir ${ARG_SOURCE_DIR} )
ENDIF()

MESSAGE( STATUS "Package ${targetname} will be installed in ${targetdir}" )

 #---Add the external project -------------------------------------------------------------------
 
ExternalProject_Add( 
		${targetname}
        "${ARGN}"
)

#--- Add step to write init_ilcsoft.sh for the module --------

ExternalProject_Add_Step(${targetname} after_install 
	WORKING_DIRECTORY ${ILCSOFT_PATH}
	COMMAND ${CMAKE_COMMAND} -DILCSOFT_PATH=${ILCSOFT_PATH} -Dname=${targetname} -Dtargetdir=${targetdir} -P ${CMAKE_CURRENT_SOURCE_DIR}/cmake/WriteInit.cmake
	COMMENT "Writing environment variables to init_ilcsoft.sh"
	DEPENDEES install
)

endmacro()
