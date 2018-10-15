```bash
cd $LFS/sources && 
tar zxvf dejagnu-1.6.1.tar.gz &&
cd dejagnu-1.6.1 &&
./configure --prefix=/tools &&
make install &&
cd $LFS/sources && 
rm -rf dejagnu-1.6.1
```
