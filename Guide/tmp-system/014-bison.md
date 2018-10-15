```bash
cd $LFS/sources &&
tar xvf bison-3.0.5.tar.xz &&
cd bison-3.0.5 &&
./configure --prefix=/tools &&
make && make install &&
cd $LFS/sources &&
rm -rvf bison-3.0.5
```
