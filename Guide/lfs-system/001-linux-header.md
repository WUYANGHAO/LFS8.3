```bash
cd /sources &&
tar xvf linux-4.18.5.tar.xz &&
cd linux-4.18.5 &&
make mrproper &&
make INSTALL_HDR_PATH=dest headers_install &&
find dest/include \( -name .install -o -name ..install.cmd \) -delete &&
cp -rv dest/include/* /usr/include &&
cd /sources &&
rm -rf linux-4.18.5
```
