```bash
cd $LFS/sources &&
tar xvf grep-3.1.tar.xz &&
cd grep-3.1 &&
./configure --prefix=/tools &&
make && make install &&
cd $LFS/sources &&
rm -rvf grep-3.1
```
