```bash
cd $LFS/sources &&
tar xvf patch-2.7.6.tar.xz &&
cd patch-2.7.6 &&
./configure --prefix=/tools &&
make && make install &&
cd $LFS/sources &&
rm -rvf patch-2.7.6
```
