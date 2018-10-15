```bash
cd $LFS/sources &&
tar zxvf file-5.34.tar.gz &&
cd file-5.34 &&
./configure --prefix=/tools &&
make && make install &&
cd $LFS/sources &&
rm -rvf file-5.34
```
