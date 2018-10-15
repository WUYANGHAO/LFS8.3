```bash
cd $LFS/sources &&
tar xvf bzip2-1.0.6.tar.gz &&
cd bzip2-1.0.6 &&
make && make PREFIX=/tools install &&
cd $LFS/sources &&
rm -rvf bzip2-1.0.6
```
