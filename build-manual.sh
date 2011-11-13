#!/bin/sh -e

clean_up() {
  if [ -d "$1" ]
  then
    echo "    [rmdir] remove directory '$1' ..."
    rm -r "$1"
  fi
}

make_dir() {
  echo "    [mkdir] create directory '$1' ..."
  mkdir "$1"
}

# clean
echo
echo "cleanup:"
clean_up "./build"
clean_up "./dist"

# prepare
echo
echo "prepare:"
make_dir "./build"
make_dir "./dist"

# compile
echo
echo "compile:"
echo "    [javac] compile sources from './src/' ..."
JAVAC_ARGS="-Xlint:deprecation"
javac ${JAVAC_ARGS} -d ./build ./src/sub/optimal/wms/*.java

# createExecutable
echo
echo "createExecutable:"
echo "Main-Class: sub.optimal.wms.MainFrame" > manifest.mf
echo "    [jar] build jar './dist/WMS-Setup.jar' ..."
jar cfm ./dist/WMS-Setup.jar manifest.mf -C ./build/ .
rm manifest.mf
