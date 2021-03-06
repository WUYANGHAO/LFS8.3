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
*SBU 时间单位，以编译binutils为一个单位*
#### 1.[Binutils-2.31.1 - Pass 1](tmp-system/001-binutils-pass1.md)———1 SBU
#### 2.[GCC-8.2.0 - Pass 1](tmp-system/002-gcc-pass1.md)———14.3 SBU
#### 3.[Linux-4.18.5 API Headers](tmp-system/003-linux-header.md)———0.1 SBU
#### 4.[Glibc-2.28](tmp-system/004-glibc.md)———4.7 SBU
#### 5.[Libstdc++ from GCC-8.2.0](tmp-system/005-libstdc++.md)———0.5 SBU
#### 6.[Binutils-2.31.1 - Pass 2](tmp-system/006-binutils-paas2.md)———1.1 SBU
#### 7.[GCC-8.2.0 - Pass 2](tmp-system/007-gcc-pass2.md)———11 SBU
#### 8.[Tcl-8.6.8](tmp-system/008-tcl.md)———0.9 SBU
#### 9.[Expect-5.45.4](tmp-system/009-expect.md)———0.1 SBU
#### 10.[DejaGNU-1.6.1](tmp-system/010-dejagnu.md)——— <0.1 SBU
#### 11.[M4-1.4.18](tmp-system/011-m4.md)———0.2 SBU
#### 12.[Ncurses-6.1](tmp-system/012-ncurses.md)———0.6 SBU
#### 13.[Bash-4.4.18](tmp-system/013-bash.md)———0.4 SBU
#### 14.[Bison-3.0.5](tmp-system/014-bison.md)———0.3 SBU
#### 15.[Bzip2-1.0.6](tmp-system/015-bzip.md)——— <0.1 SBU
#### 16.[Coreutils-8.30](tmp-system/016-coreutils.md)———0.7 SBU
#### 17.[Diffutils-3.6](tmp-system/017-diffutils.md)———0.2 SBU
#### 18.[File-5.34](tmp-system/018-file.md)———0.1 SBU
#### 19.[Findutils-4.6.0](tmp-system/019-findutils.md)———0.3 SBU
#### 20.[Gawk-4.2.1](tmp-system/020-gawk.md)———0.2 SBU
#### 21.[Gettext-0.19.8.1](tmp-system/021-gettext.md)———0.9 SBU
#### 22.[Grep-3.1](tmp-system/022-grep.md)———0.2 SBU
#### 23.[Gzip-1.9](tmp-system/023-gzip.md)———0.1 SBU
#### 24.[Make-4.2.1](tmp-system/024-make.md)———0.1 SBU
#### 25.[Patch-2.7.6](tmp-system/025-patch.md)———0.2 SBU
#### 26.[Perl-5.28.0](tmp-system/026-perl.md)———1.5 SBU
#### 27.[Sed-4.5](tmp-system/027-sed.md)———0.2 SBU
#### 28.[Tar-1.30](tmp-system/028-tar.md)———0.4 SBU
#### 29.[Texinfo-6.5](tmp-system/029-texinfo.md)———0.2 SBU
#### 30.[Util-linux-2.32.1](tmp-system/030-util.md)———1 SBU
#### 31.[Xz-5.2.4](tmp-system/031-xz.md)———0.2 SBU
### Stripping
```bash
cd $LFS
strip --strip-debug /tools/lib/*
/usr/bin/strip --strip-unneeded /tools/{,s}bin/*
rm -rf /tools/{,share}/{info,man,doc}
find /tools/{lib,libexec} -name \*.la -delete
```
### 更改工具链属组（root用户下执行）
```bash
chown -R root:root $LFS/tools
```
------------------------------------------------
*[[上一页](001-prepare-host-system.md)]  [[下一页](003-build_lfs-system.md)]
