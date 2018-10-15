```bash
cd $LFS/sources &&
tar xvf diffutils-3.6.tar.xz &&
cd diffutils-3.6 &&
./configure --prefix=/tools &&
make && make install &&
cd $LFS/sources &&
rm -rvf diffutils-3.6
```
