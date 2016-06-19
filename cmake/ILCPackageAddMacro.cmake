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
	COMMAND write_init
	COMMENT "Writing environment variables to init_ilcsoft.sh"
	DEPENDEES install
)

function( write_init )
FILE( WRITE ${ILCSOFT_PATH}/init_ilcsoft.sh  "###########################\n" )
FILE( APPEND ${ILCSOFT_PATH}/init_ilcsoft.sh  "${name}\n" )
FILE( APPEND ${ILCSOFT_PATH}/init_ilcsoft.sh  "###########################\n" )
FILE( APPEND ${ILCSOFT_PATH}/init_ilcsoft.sh  "export ${name}_DIR=${targetdir}\n" )
	IF( EXISTS "${targetdir}/bin" AND IS_DIRECTORY "${targetdir}/bin")
FILE( APPEND ${ILCSOFT_PATH}/init_ilcsoft.sh  "export PATH=\${PATH}:${targetdir}/bin\n" )
	ENDIF()
	IF( EXISTS "${targetdir}/lib" AND IS_DIRECTORY "${targetdir}/lib")
FILE( APPEND ${ILCSOFT_PATH}/init_ilcsoft.sh  "export LD_LIBRARY_PATH=\${LD_LIBRARY_PATH}:${targetdir}/bin\n" )
	ENDIF()
FILE( APPEND ${ILCSOFT_PATH}/init_ilcsoft.sh  "\n" )
FILE( APPEND ${ILCSOFT_PATH}/init_ilcsoft.sh  "\n" )
endfunction( write_init )

endmacro()
