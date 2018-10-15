*Time:0.1 SBU*
```bash
cd $LFS/sources &&
tar xvf linux-4.18.5.tar.xz &&
cd linux-4.18.5 &&
make mrproper &&
make INSTALL_HDR_PATH=dest headers_install &&
cp -rv dest/include/* /tools/include
cd $LFS/sources &&
rm -rf linux-4.18.5
```
