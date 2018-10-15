*Time:0.1 SBU*
```bash
make mrproper &&
make INSTALL_HDR_PATH=dest headers_install &&
cp -rv dest/include/* /tools/include
```
