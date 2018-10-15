```bash
cd $LFS/sources &&
tar xvf gawk-4.2.1.tar.xz &&
cd gawk-4.2.1 &&
./configure --prefix=/tools &&
make && make install &&
cd $LFS/sources &&
rm -rvf gawk-4.2.1
```
