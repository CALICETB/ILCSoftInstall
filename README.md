# ILCSoftInstall
## CMake package to install all sub-packages for ilcsoft

### Options
 * ENABLE_C++11 (default ON) to build using c++11
 * BUILD_QT (default ON) to build Qt 4.7.4
 * BUILD_BOOST (default ON) to build boost 1.58
 * BUILD_MYSQL (default ON) to build mysql

Example :
```
cmake -DENABLE_C++11=ON -DBUILD_QT=OFF ..
```

### Building 
ILCSoft Base :
 * Qt 4.7.4
 * ROOT
 * Boost 1.58
 * GSL
 * CLHEP
 * MySQL 5.1.73
 * ILCUtil
 * CED
 * CondDBMySQL
 * XercesC
 
ILCSoft Core :
 * Marlin
 * MarlinUtil
 * LCIO
 * LCCD
 * Gear

### Installation

if MySQL is already on your machine :

```
mkdir build
cmake -DMYSQL_DIR=<path/to/mysql> ..
make
```

Otherwise :

```
mkdir build
cmake ..
make
```
