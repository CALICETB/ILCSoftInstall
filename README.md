# ILCSoftInstall
## CMake package to install all sub-packages for ilcsoft

### Pre-Requirements

You need to have theses packages installed :
 * python-dev
 * libbz2-dev
 * g++ 4.8 minimum
 * ROOT Pre-requirements : https://root.cern.ch/build-prerequisites
 * CMake 2.8 minimum 
 * git
 * OpenSSL
 * subversion with neon/serf modules
 * perl > 5.14
 * python > 2.6
 * openjdk-7-jdk (Java development toolkit)
 * libncurses5-dev
 * freeglut3-dev and opengl
 * /!\ Maybe some missing there /!\
 
For Ubuntu:
```
sudo apt-get install python-dev libbz2-dev g++-4.8 cmake git openssl subversion perl python2.6 openjdk-7-jdk libncurses5-dev freeglut3-dev dpkg-dev g++ gcc binutils libx11-dev libxpm-dev libxft-dev libxext-dev gfortran libssl-dev libpcre3-dev xlibmesa-glu-dev libglew1.5-dev libftgl-dev libmysqlclient-dev libfftw3-dev graphviz-dev libavahi-compat-libdnssd-dev libldap2-dev python-dev libxml2-dev libkrb5-dev libgsl0-dev libqt4-dev autoconf
```

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
cd build
cmake -DMYSQL_DIR=<path/to/mysql> ..
make
```

Otherwise :

```
mkdir build
cd build
cmake ..
make
```
