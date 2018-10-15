```bash
cd $LFS/sources &&
tar xvf binutils-2.31.1.tar.xz &&
cd binutils-2.31.1 &&
mkdir -v build &&
cd       build &&
CC=$LFS_TGT-gcc                \
AR=$LFS_TGT-ar                 \
RANLIB=$LFS_TGT-ranlib         \
../configure                   \
    --prefix=/tools            \
    --disable-nls              \
    --disable-werror           \
    --with-lib-path=/tools/lib \
    --with-sysroot &&
make &&
make install &&
make -C ld clean &&
make -C ld LIB_PATH=/usr/lib:/lib &&
cp -v ld/ld-new /tools/bin &&
cd $LFS/sources &&
rm -rf binutils-2.31.1
```
