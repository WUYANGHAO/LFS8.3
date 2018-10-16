```bash
cd /sources &&
tar xvf binutils-2.31.1.tar.xz &&
cd binutils-2.31.1 &&
expect -c "spawn ls" &&
mkdir -v build &&
cd       build &&
../configure --prefix=/usr       \
             --enable-gold       \
             --enable-ld=default \
             --enable-plugins    \
             --enable-shared     \
             --disable-werror    \
             --enable-64-bit-bfd \
             --with-system-zlib &&
make tooldir=/usr &&
make tooldir=/usr install &&
cd /sources &&
rm -rvf binutils-2.31.1
```
