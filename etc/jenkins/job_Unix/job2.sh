#!/bin/bash

## This job must be executed on VM1 machines
## See ./README.md

echo "Job 2"
casejob=2

set -e

# change default  compiler
change_compiler=etc/jenkins/change_compiler/change_compiler-`uname -s`-`uname -r`-$casejob.sh
echo try to source file  "$change_compiler"
test -f "$change_compiler" && echo  source file "$change_compiler"
test -f "$change_compiler" && cat  "$change_compiler"
test -f "$change_compiler" && source "$change_compiler"

# configuration & build
tar xvf AutoGeneratedFile.tar.gz \
  && ./configure --without-mpi --prefix=/builds/workspace/freefem \
  && ./etc/jenkins/blob/build.sh

if [ $? -eq 0 ]
then
  echo "Build process complete"
else
  echo "Build process failed"
  exit 1
fi

# check
 ./etc/jenkins/blob/check.sh

if [ $? -eq 0 ]
then
  echo "Check process complete"
else
  echo "Check process failed"
exit 1
fi

# install
 ./etc/jenkins/blob/install.sh

if [ $? -eq 0 ]
then
  echo "Install process complete"
else
  echo "Install process failed"
fi

# uninstall
./etc/jenkins/blob/uninstall.sh

if [ $? -eq 0 ]
then
echo "Uninstall process complete"
else
echo "Uninstall process failed"
exit 1
fi


# visu for jenkins tests results analyser
./etc/jenkins/resultForJenkins/resultForJenkins.sh
