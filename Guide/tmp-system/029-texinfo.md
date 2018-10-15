```bash
cd $LFS/sources &&
tar xvf texinfo-6.5.tar.xz &&
cd texinfo-6.5 &&
./configure --prefix=/tools &&
make && make install &&
cd $LFS/sources &&
rm -rvf texinfo-6.5
```
