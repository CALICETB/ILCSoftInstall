#####
#
#  CMake to write init_ilcsoft.sh
#
#
######

IF ( ${name} STREQUAL "QT" )

FILE( APPEND ${ILCSOFT_PATH}/init_ilcsoft.sh  "###########################\n" )
FILE( APPEND ${ILCSOFT_PATH}/init_ilcsoft.sh  "#\t ${name}\n" )
FILE( APPEND ${ILCSOFT_PATH}/init_ilcsoft.sh  "###########################\n" )
FILE( APPEND ${ILCSOFT_PATH}/init_ilcsoft.sh  "export QTDIR=\"${targetdir}\"\n" )
FILE( APPEND ${ILCSOFT_PATH}/init_ilcsoft.sh  "export QMAKESPEC=\"\$QTDIR/mkspecs/linux-g++\"\n" )
FILE( APPEND ${ILCSOFT_PATH}/init_ilcsoft.sh  "export PATH=\$QTDIR/bin:\$PATH\n" )
FILE( APPEND ${ILCSOFT_PATH}/init_ilcsoft.sh  "export LD_LIBRARY_PATH=\"\$QTDIR/lib:\$LD_LIBRARY_PATH\"\n" )
FILE( APPEND ${ILCSOFT_PATH}/init_ilcsoft.sh  "\n" )
FILE( APPEND ${ILCSOFT_PATH}/init_ilcsoft.sh  "\n" )

ENDIF()

IF ( ${name} STREQUAL "BOOST" )

FILE( APPEND ${ILCSOFT_PATH}/init_ilcsoft.sh  "###########################\n" )
FILE( APPEND ${ILCSOFT_PATH}/init_ilcsoft.sh  "#\t ${name}\n" )
FILE( APPEND ${ILCSOFT_PATH}/init_ilcsoft.sh  "###########################\n" )
FILE( APPEND ${ILCSOFT_PATH}/init_ilcsoft.sh  "export ${name}_ROOT=\"${targetdir}\"\n" )
FILE( APPEND ${ILCSOFT_PATH}/init_ilcsoft.sh  "\n" )
FILE( APPEND ${ILCSOFT_PATH}/init_ilcsoft.sh  "\n" )

ENDIF()

IF ( ${name} STREQUAL "ROOT" )

FILE( APPEND ${ILCSOFT_PATH}/init_ilcsoft.sh  "###########################\n" )
FILE( APPEND ${ILCSOFT_PATH}/init_ilcsoft.sh  "#\t ${name}\n" )
FILE( APPEND ${ILCSOFT_PATH}/init_ilcsoft.sh  "###########################\n" )
FILE( APPEND ${ILCSOFT_PATH}/init_ilcsoft.sh  "export ROOTSYS=\"${targetdir}\"\n" )
FILE( APPEND ${ILCSOFT_PATH}/init_ilcsoft.sh  "export PYTHONPATH=\"\$ROOTSYS/lib:\$PYTHONPATH\"\n" )
FILE( APPEND ${ILCSOFT_PATH}/init_ilcsoft.sh  "export PATH=\"\$ROOTSYS/bin:\$PATH\"\n" )
FILE( APPEND ${ILCSOFT_PATH}/init_ilcsoft.sh  "export LD_LIBRARY_PATH=\"\$ROOTSYS/lib:\$LD_LIBRARY_PATH\"\n" )
FILE( APPEND ${ILCSOFT_PATH}/init_ilcsoft.sh  "\n" )
FILE( APPEND ${ILCSOFT_PATH}/init_ilcsoft.sh  "\n" )

ENDIF()

IF ( ${name} STREQUAL "MARLIN" )

FILE( APPEND ${ILCSOFT_PATH}/init_ilcsoft.sh  "###########################\n" )
FILE( APPEND ${ILCSOFT_PATH}/init_ilcsoft.sh  "#\t ${name}\n" )
FILE( APPEND ${ILCSOFT_PATH}/init_ilcsoft.sh  "###########################\n" )
FILE( APPEND ${ILCSOFT_PATH}/init_ilcsoft.sh  "export ${name}=\"${targetdir}\"\n" )
FILE( APPEND ${ILCSOFT_PATH}/init_ilcsoft.sh  "export PATH=\"\$MARLIN/bin:\$PATH\"\n" )
FILE( APPEND ${ILCSOFT_PATH}/init_ilcsoft.sh  "export MARLIN_DLL=\":\$MARLIN_DLL\"\n" )
FILE( APPEND ${ILCSOFT_PATH}/init_ilcsoft.sh  "\n" )
FILE( APPEND ${ILCSOFT_PATH}/init_ilcsoft.sh  "\n" )

ENDIF()

IF ( ${name} STREQUAL "LCIO" )

FILE( APPEND ${ILCSOFT_PATH}/init_ilcsoft.sh  "###########################\n" )
FILE( APPEND ${ILCSOFT_PATH}/init_ilcsoft.sh  "#\t ${name}\n" )
FILE( APPEND ${ILCSOFT_PATH}/init_ilcsoft.sh  "###########################\n" )
FILE( APPEND ${ILCSOFT_PATH}/init_ilcsoft.sh  "export ${name}=\"${targetdir}\"\n" )
FILE( APPEND ${ILCSOFT_PATH}/init_ilcsoft.sh  "export PYTHONPATH=\"\$LCIO/src/python:\$LCIO/examples/python:\$PYTHONPATH\"\n" )
FILE( APPEND ${ILCSOFT_PATH}/init_ilcsoft.sh  "export PATH=\"\$LCIO/bin:\$PATH\"\n" )
FILE( APPEND ${ILCSOFT_PATH}/init_ilcsoft.sh  "export LD_LIBRARY_PATH=\"\$LCIO/lib:\$LD_LIBRARY_PATH\"\n" )
FILE( APPEND ${ILCSOFT_PATH}/init_ilcsoft.sh  "\n" )
FILE( APPEND ${ILCSOFT_PATH}/init_ilcsoft.sh  "\n" )

ENDIF()

IF ( ${name} STREQUAL "LCCD" )

FILE( APPEND ${ILCSOFT_PATH}/init_ilcsoft.sh  "###########################\n" )
FILE( APPEND ${ILCSOFT_PATH}/init_ilcsoft.sh  "#\t ${name}\n" )
FILE( APPEND ${ILCSOFT_PATH}/init_ilcsoft.sh  "###########################\n" )
FILE( APPEND ${ILCSOFT_PATH}/init_ilcsoft.sh  "export ${name}=\"${targetdir}\"\n" )
FILE( APPEND ${ILCSOFT_PATH}/init_ilcsoft.sh  "\n" )
FILE( APPEND ${ILCSOFT_PATH}/init_ilcsoft.sh  "\n" )

ENDIF()

IF ( ${name} STREQUAL "CONDDB" )

FILE( APPEND ${ILCSOFT_PATH}/init_ilcsoft.sh  "###########################\n" )
FILE( APPEND ${ILCSOFT_PATH}/init_ilcsoft.sh  "#\t CondDBMySQL\n" )
FILE( APPEND ${ILCSOFT_PATH}/init_ilcsoft.sh  "###########################\n" )
FILE( APPEND ${ILCSOFT_PATH}/init_ilcsoft.sh  "export COND_DB_DEBUGLOG=\"/dev/stdout\"\n" )
FILE( APPEND ${ILCSOFT_PATH}/init_ilcsoft.sh  "export CondDBMySQL=\"${targetdir}\"\n" )
FILE( APPEND ${ILCSOFT_PATH}/init_ilcsoft.sh  "export LD_LIBRARY_PATH=\"\$CondDBMySQL/lib:\$LD_LIBRARY_PATH\"\n" )
FILE( APPEND ${ILCSOFT_PATH}/init_ilcsoft.sh  "\n" )
FILE( APPEND ${ILCSOFT_PATH}/init_ilcsoft.sh  "\n" )

ENDIF()

IF ( ${name} STREQUAL "CLHEP" )

FILE( APPEND ${ILCSOFT_PATH}/init_ilcsoft.sh  "###########################\n" )
FILE( APPEND ${ILCSOFT_PATH}/init_ilcsoft.sh  "#\t ${name}\n" )
FILE( APPEND ${ILCSOFT_PATH}/init_ilcsoft.sh  "###########################\n" )
FILE( APPEND ${ILCSOFT_PATH}/init_ilcsoft.sh  "export ${name}=\"${targetdir}\"\n" )
FILE( APPEND ${ILCSOFT_PATH}/init_ilcsoft.sh  "export CLHEP_BASE_DIR=\"\$CLHEP\"\n" )
FILE( APPEND ${ILCSOFT_PATH}/init_ilcsoft.sh  "export CLHEP_INCLUDE_DIR=\"\$CLHEP/include\"\n" )
FILE( APPEND ${ILCSOFT_PATH}/init_ilcsoft.sh  "export PATH=\"\$CLHEP_BASE_DIR/bin:\$PATH\"\n" )
FILE( APPEND ${ILCSOFT_PATH}/init_ilcsoft.sh  "export LD_LIBRARY_PATH=\"\$CLHEP_BASE_DIR/lib:\$LD_LIBRARY_PATH\"\n" )
FILE( APPEND ${ILCSOFT_PATH}/init_ilcsoft.sh  "\n" )
FILE( APPEND ${ILCSOFT_PATH}/init_ilcsoft.sh  "\n" )

ENDIF()

IF ( ${name} STREQUAL "GEAR" )

FILE( APPEND ${ILCSOFT_PATH}/init_ilcsoft.sh  "###########################\n" )
FILE( APPEND ${ILCSOFT_PATH}/init_ilcsoft.sh  "#\t ${name}\n" )
FILE( APPEND ${ILCSOFT_PATH}/init_ilcsoft.sh  "###########################\n" )
FILE( APPEND ${ILCSOFT_PATH}/init_ilcsoft.sh  "export ${name}=\"${targetdir}\"\n" )
FILE( APPEND ${ILCSOFT_PATH}/init_ilcsoft.sh  "export PATH=\"\$GEAR/tools:\$GEAR/bin:\$PATH\"\n" )
FILE( APPEND ${ILCSOFT_PATH}/init_ilcsoft.sh  "export LD_LIBRARY_PATH=\"\$GEAR/lib:\$LD_LIBRARY_PATH\"\n" )
FILE( APPEND ${ILCSOFT_PATH}/init_ilcsoft.sh  "\n" )
FILE( APPEND ${ILCSOFT_PATH}/init_ilcsoft.sh  "\n" )

ENDIF()

IF ( ${name} STREQUAL "XERCES" )

FILE( APPEND ${ILCSOFT_PATH}/init_ilcsoft.sh  "###########################\n" )
FILE( APPEND ${ILCSOFT_PATH}/init_ilcsoft.sh  "#\t XercesC\n" )
FILE( APPEND ${ILCSOFT_PATH}/init_ilcsoft.sh  "###########################\n" )
FILE( APPEND ${ILCSOFT_PATH}/init_ilcsoft.sh  "export XercesC_HOME=\"${targetdir}\"\n" )
FILE( APPEND ${ILCSOFT_PATH}/init_ilcsoft.sh  "export PATH=\"\$XercesC_HOME/bin:\$PATH\"\n" )
FILE( APPEND ${ILCSOFT_PATH}/init_ilcsoft.sh  "export LD_LIBRARY_PATH=\"\$XercesC_HOME/lib:\$LD_LIBRARY_PATH\"\n" )
FILE( APPEND ${ILCSOFT_PATH}/init_ilcsoft.sh  "\n" )
FILE( APPEND ${ILCSOFT_PATH}/init_ilcsoft.sh  "\n" )

ENDIF()

IF ( ${name} STREQUAL "GSL" )

FILE( APPEND ${ILCSOFT_PATH}/init_ilcsoft.sh  "###########################\n" )
FILE( APPEND ${ILCSOFT_PATH}/init_ilcsoft.sh  "#\t ${name}\n" )
FILE( APPEND ${ILCSOFT_PATH}/init_ilcsoft.sh  "###########################\n" )
FILE( APPEND ${ILCSOFT_PATH}/init_ilcsoft.sh  "export ${name}_HOME=\"${targetdir}\"\n" )
FILE( APPEND ${ILCSOFT_PATH}/init_ilcsoft.sh  "export PATH=\"\$GSL_HOME/bin:\$PATH\"\n" )
FILE( APPEND ${ILCSOFT_PATH}/init_ilcsoft.sh  "export LD_LIBRARY_PATH=\"\$GSL_HOME/lib:\$LD_LIBRARY_PATH\"\n" )
FILE( APPEND ${ILCSOFT_PATH}/init_ilcsoft.sh  "\n" )
FILE( APPEND ${ILCSOFT_PATH}/init_ilcsoft.sh  "\n" )

ENDIF()

IF ( ${name} STREQUAL "CED" )

FILE( APPEND ${ILCSOFT_PATH}/init_ilcsoft.sh  "###########################\n" )
FILE( APPEND ${ILCSOFT_PATH}/init_ilcsoft.sh  "#\t ${name}\n" )
FILE( APPEND ${ILCSOFT_PATH}/init_ilcsoft.sh  "###########################\n" )
FILE( APPEND ${ILCSOFT_PATH}/init_ilcsoft.sh  "export PATH=\"${targetdir}/bin:\$PATH\"\n" )
FILE( APPEND ${ILCSOFT_PATH}/init_ilcsoft.sh  "\n" )
FILE( APPEND ${ILCSOFT_PATH}/init_ilcsoft.sh  "\n" )

ENDIF()

IF ( ${name} STREQUAL "ILCUTIL" )

FILE( APPEND ${ILCSOFT_PATH}/init_ilcsoft.sh  "###########################\n" )
FILE( APPEND ${ILCSOFT_PATH}/init_ilcsoft.sh  "#\t ${name}\n" )
FILE( APPEND ${ILCSOFT_PATH}/init_ilcsoft.sh  "###########################\n" )
FILE( APPEND ${ILCSOFT_PATH}/init_ilcsoft.sh  "export ilcutil=\"${targetdir}\"\n" )
FILE( APPEND ${ILCSOFT_PATH}/init_ilcsoft.sh  "export LD_LIBRARY_PATH=\"\$ilcutil/lib:\$LD_LIBRARY_PATH\"\n" )
FILE( APPEND ${ILCSOFT_PATH}/init_ilcsoft.sh  "\n" )
FILE( APPEND ${ILCSOFT_PATH}/init_ilcsoft.sh  "\n" )

ENDIF()

IF ( ${name} STREQUAL "MARLINUTIL" )

ENDIF()

IF ( ${name} STREQUAL "MYSQL" )

FILE( APPEND ${ILCSOFT_PATH}/init_ilcsoft.sh  "###########################\n" )
FILE( APPEND ${ILCSOFT_PATH}/init_ilcsoft.sh  "#\t ${name}\n" )
FILE( APPEND ${ILCSOFT_PATH}/init_ilcsoft.sh  "###########################\n" )
FILE( APPEND ${ILCSOFT_PATH}/init_ilcsoft.sh  "export ${name}_HOME=\"${targetdir}\"\n" )
FILE( APPEND ${ILCSOFT_PATH}/init_ilcsoft.sh  "export ${name}_LIBDIR=\"\$MYSQL_HOME/lib/mysql\"\n" )
FILE( APPEND ${ILCSOFT_PATH}/init_ilcsoft.sh  "export ${name}_PATH=\"\$MYSQL_HOME\"\n" )
FILE( APPEND ${ILCSOFT_PATH}/init_ilcsoft.sh  "export ${name}=\"\$MYSQL_HOME\"\n" )
FILE( APPEND ${ILCSOFT_PATH}/init_ilcsoft.sh  "export PATH=\"\$MYSQL_HOME/bin:\$PATH\"\n" )
FILE( APPEND ${ILCSOFT_PATH}/init_ilcsoft.sh  "export LD_LIBRARY_PATH=\"\$MYSQL_HOME/lib64/mysql:\$MYSQL_HOME/lib64:\$MYSQL_HOME/lib/mysql:\$MYSQL_HOME/lib:\$LD_LIBRARY_PATH\"\n" )
FILE( APPEND ${ILCSOFT_PATH}/init_ilcsoft.sh  "\n" )
FILE( APPEND ${ILCSOFT_PATH}/init_ilcsoft.sh  "\n" )

ENDIF()