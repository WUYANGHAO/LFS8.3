```bash
cd $LFS/sources &&
tar xvf make-4.2.1.tar.bz2 &&
cd make-4.2.1 &&
sed -i '211,217 d; 219,229 d; 232 d' glob/glob.c &&
./configure --prefix=/tools --without-guile &&
make && make install &&
cd $LFS/sources &&
rm -rvf make-4.2.1
```
