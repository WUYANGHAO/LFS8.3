```bash
cd $LFS/sources &&
tar xvf glibc-2.28.tar.xz &&
cd glibc-2.28 &&
mkdir -v build &&
cd       build &&
../configure                             \
      --prefix=/tools                    \
      --host=$LFS_TGT                    \
      --build=$(../scripts/config.guess) \
      --enable-kernel=3.2             \
      --with-headers=/tools/include      \
      libc_cv_forced_unwind=yes          \
      libc_cv_c_cleanup=yes &&
make &&
make install &&
```
*检查*
```bash
echo 'int main(){}' > dummy.c
LFS_TGT-gcc dummy.c
readelf -l a.out | grep ': /tools'
```
*正确返回值*
```bash
[Requesting program interpreter: /tools/lib64/ld-linux-x86-64.so.2]
```
*清理*
```bash
cd $LFS/sources
rm -rf glibc-2.25
```
