include(ExternalProject)
include(CMakeParseArguments)

set (dependency_split_pattern "([^-]+)-(.+)")

macro(ILCSoftPackage_Add name)

SET( targetname ${name} )

replace_conditional_args(ARGUMENTS "${ARGN}")
cmake_parse_arguments(ARG "" "DEPENDS;INSTALL_DIR;SOURCE_DIR;BUILD_IN_SOURCE" "" ${ARGUMENTS})

IF(ARG_INSTALL_DIR)
SET( targetdir ${ARG_INSTALL_DIR} )
ELSE ()
SET( targetdir ${ARG_SOURCE_DIR} )
ENDIF()

MESSAGE( STATUS "Package ${targetname} will be installed in ${targetdir}" )

 #---Add the external project -------------------------------------------------------------------
 
ExternalProject_Add( 
		${targetname}
        "${ARGUMENTS}"
)

#--- Add step to write init_ilcsoft.sh for the module --------

ExternalProject_Add_Step(${targetname} after_install 
	WORKING_DIRECTORY ${ILCSOFT_PATH}
	COMMAND ${CMAKE_COMMAND} -DILCSOFT_PATH=${ILCSOFT_PATH} -Dname=${targetname} -Dtargetdir=${targetdir} -P ${CMAKE_CURRENT_SOURCE_DIR}/cmake/WriteInit.cmake
	COMMENT "Writing environment variables to init_ilcsoft.sh"
	DEPENDEES install build
	ALWAYS 1
)

endmacro()

#---------------------------------------------------------------------------------------------------
# Helper function to substibute conditional code in arguments
#   o Expession like IF <condition> THEN <arguments1> [ELSE <arguments2> ] ENDIF gets
#     replaced by <arguments1> or <argummens2> depending on the conditioon
#---------------------------------------------------------------------------------------------------

function(replace_conditional_args outvar input)
  while(1)
    set(pattern)
    set(flag 0)
    set (idx 0) # incapsulate counter
    foreach(a IN LISTS input)
      if(a STREQUAL IF)
        set(flag 1)
        MATH (EXPR idx "${idx} + 1")
        list(APPEND pattern "${a}-${idx}")
      elseif(a STREQUAL ENDIF)
        list(APPEND pattern "${a}-${idx}")
        MATH (EXPR idx "${idx} - 1")
        if (idx EQUAL 0)
          break()
        endif()
      elseif(flag)
        if (a STREQUAL THEN)
          list (APPEND pattern "${a}-${idx}")
        elseif(a STREQUAL "ELSE")
          list (APPEND pattern "${a}-${idx}")
        else()
          list(APPEND pattern "${a}")
        endif()
      endif()
    endforeach()
    if(pattern)
      # Mark levels of IF statements: IF-1, THEN-1, ENDIF-1 ...
      if("${pattern}" MATCHES "IF-[0-9];(.+);THEN-\\1;(.+);ELSE-\\1;(.+);ENDIF-\\1")
        set(condition "${CMAKE_MATCH_1}")
        set(casetrue  "${CMAKE_MATCH_2}")
        set(casefalse "${CMAKE_MATCH_3}")
      elseif("${pattern}"  MATCHES "IF-[0-9];(.+);THEN-\\1;(.+);ENDIF-\\1")
        set(condition "${CMAKE_MATCH_1}")
        set(casetrue  "${CMAKE_MATCH_2}")
        set(casefalse "")
      else()
        message(FATAL_ERROR "Unsupported IF...THEN...ELSE..ENDIF construct: '${pattern}'")
      endif()
      if(${condition})
        set(value "${casetrue}")
      else()
        set(value "${casefalse}")
      endif()
      # Revert IF-# hack ...
      foreach (s IF THEN ELSE ENDIF)
        string(REGEX REPLACE "${s}-[0-9]" "${s}" pattern "${pattern}")
        string(REGEX REPLACE "${s}-[0-9]" "${s}" value "${value}")
      endforeach()
      string(REPLACE "${pattern}" "${value}" input "${input}")
    else()
      set(${outvar} "${input}" PARENT_SCOPE)
      return()
    endif()
  endwhile()
endfunction()