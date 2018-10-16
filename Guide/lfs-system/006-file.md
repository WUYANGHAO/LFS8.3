```bash
cd /sources &&
tar zxvf file-5.34.tar.gz &&
cd file-5.34 &&
./configure --prefix=/usr &&
make && make install &&
cd /sources &&
rm -rvf file-5.34 &&
```
