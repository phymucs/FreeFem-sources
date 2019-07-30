#!C:\msys64\usr\bin\bash.exe --login
source shell mingw64

echo "Job 1"

autoreconf -i \
&& ./configure --enable-generic --enable-optim --without-mpi --enable-maintainer-mode \
        CXXFLAGS=-mtune=generic CFLAGS=-mtune=generic FFLAGS=-mtune=generic \
        --prefix=/builds/workspace/freefem \
  && make

if [ $? -eq 0 ]
then
  echo "Build process complete"
else
  echo "Build process failed"
  exit 1
fi

# check
make check

if [ $? -eq 0 ]
then
  echo "Check process complete"
else
  echo "Check process failed"
fi

# install
make install

if [ $? -eq 0 ]
then
  echo "Install process complete"
else
  echo "Install process failed"
fi
