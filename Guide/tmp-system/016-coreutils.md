```bash
cd $LFS/sources &&
tar xvf coreutils-8.30.tar.xz &&
cd coreutils-8.30 &&
./configure --prefix=/tools --enable-install-program=hostname &&
make && make install &&
cd $LFS/sources &&
rm -rvf coreutils-8.30
```
