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
#### 5.[Libstdc++ from GCC-8.2.0](tmp-system/005-libstdc++.md)
#### 6.[Binutils-2.31.1 - Pass 2](tmp-system/006-binutils-paas2.md)
#### 7.[GCC-8.2.0 - Pass 2](tmp-system/007-gcc-pass2.md)
#### 8.[Tcl-8.6.8](tmp-system/008-tcl.md)
#### 9.[Expect-5.45.4](tmp-system/009-expect.md)
#### 10.[DejaGNU-1.6.1](tmp-system/010-dejagnu.md)
#### 11.[M4-1.4.18](tmp-system/011-m4.md)
#### 12.[Ncurses-6.1](tmp-system/012-ncurses.md)
#### 13.[Bash-4.4.18](tmp-system/013-bash.md)
#### 14.[Bison-3.0.5](tmp-system/014-bison.md)
#### 15.[Bzip2-1.0.6](tmp-system/015-bzip.md)
#### 16.[Coreutils-8.30](tmp-system/016-coreutils.md)
#### 17.[Diffutils-3.6](tmp-system/017-diffutils.md)
#### 18.[File-5.34](tmp-system/018-file.md)
#### 19.[Findutils-4.6.0](tmp-system/019-findutils.md)
#### 20.[Gawk-4.2.1](tmp-system/020-gawk.md)
#### 21.[Gettext-0.19.8.1](tmp-system/021-gettext.md)
#### 22.[Grep-3.1](tmp-system/022-grep.md)
#### 23.[Gzip-1.9](tmp-system/023-gzip.md)
#### 24.[Make-4.2.1](tmp-system/024-make.md)
#### 25.[Patch-2.7.6](tmp-system/025-patch.md)
#### 26.[Perl-5.28.0](tmp-system/026-perl.md)
#### 27.[Sed-4.5](tmp-system/027-sed.md)
#### 28.[Tar-1.30](tmp-system/028-tar.md)
#### 29.[Texinfo-6.5](tmp-system/029-texinfo.md)
#### 30.[Util-linux-2.32.1](tmp-system/030-util.md)
#### 31.[Xz-5.2.4](tmp-system/031-xz.com)
#### 32.[Stripping](tmp-system/032-stripping.md)
#### 33.[Changing Ownership](tmp-system/033-change-ownership.md)
------------------------------------------------
*[[上一页](001-prepare-host-system.md)]  [[下一页](003-build_lfs-system.md)]
