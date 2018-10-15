# 编译临时系统
------------------------------------------------
#### *[[上一页](001-prepare-host-system.md)] [[下一页](003-build-lfs-system.md)]*
------------------------------------------------
### 准备
*1.切换到lfs用户*
```bash
su - lfs
```
*2.检查LFS变量(输出应该是 /mnt/lfs )*
```bash
echo $LFS
```
### 编译
#### 1.Binutils-2.31.1 - Pass 1
```bash
cd $LFS/sources &&
tar xvf binutils-2.31.1.tar.xz &&
cd binutils-2.31.1 &&
mkdir -v build &&
cd       build &&
../configure --prefix=/tools            \
             --with-sysroot=$LFS        \
             --with-lib-path=/tools/lib \
             --target=$LFS_TGT          \
             --disable-nls              \
             --disable-werror &&
make && 
case $(uname -m) in
  x86_64) mkdir -v /tools/lib && ln -sv lib /tools/lib64 ;;
esac &&
make install &&
cd $LFS/sources &&
rm -rf bibutils-2.31.1 &&
```
#### 2. GCC-8.2.0 - Pass 1
```bash
cd $LFS/sources &&
tar xvf gcc-8.2.0.tar.xz &&
cd gcc-8.2.0 &&
tar -xf ../mpfr-4.0.1.tar.xz &&
mv -v mpfr-4.0.1 mpfr &&
tar -xf ../gmp-6.1.2.tar.xz &&
mv -v gmp-6.1.2 gmp &&
tar -xf ../mpc-1.1.0.tar.gz &&
mv -v mpc-1.1.0 mpc &&
for file in gcc/config/{linux,i386/linux{,64}}.h
do
  cp -uv $file{,.orig}
  sed -e 's@/lib\(64\)\?\(32\)\?/ld@/tools&@g' \
      -e 's@/usr@/tools@g' $file.orig > $file
  echo '
#undef STANDARD_STARTFILE_PREFIX_1
#undef STANDARD_STARTFILE_PREFIX_2
#define STANDARD_STARTFILE_PREFIX_1 "/tools/lib/"
#define STANDARD_STARTFILE_PREFIX_2 ""' >> $file
  touch $file.orig
done &&
case $(uname -m) in
  x86_64)
    sed -e '/m64=/s/lib64/lib/' \
        -i.orig gcc/config/i386/t-linux64
 ;;
esac &&
mkdir -v build &&
cd       build &&
../configure                                       \
    --target=$LFS_TGT                              \
    --prefix=/tools                                \
    --with-glibc-version=2.11                      \
    --with-sysroot=$LFS                            \
    --with-newlib                                  \
    --without-headers                              \
    --with-local-prefix=/tools                     \
    --with-native-system-header-dir=/tools/include \
    --disable-nls                                  \
    --disable-shared                               \
    --disable-multilib                             \
    --disable-decimal-float                        \
    --disable-threads                              \
    --disable-libatomic                            \
    --disable-libgomp                              \
    --disable-libmpx                               \
    --disable-libquadmath                          \
    --disable-libssp                               \
    --disable-libvtv                               \
    --disable-libstdcxx                            \
    --enable-languages=c,c++ &&
make &&
make install &&
cd $LFS/sources &&
rm -rf gcc-8.2.0
```
