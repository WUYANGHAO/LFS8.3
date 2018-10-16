```bash
cd /sources &&
tar zxvf pkg-config-0.29.2.tar.gz &&
cd pkg-config-0.29.2 &&
./configure --prefix=/usr              \
            --with-internal-glib       \
            --disable-host-tool        \
            --docdir=/usr/share/doc/pkg-config-0.29.2 &&
make && make install &&
cd /sources &&
rm -rvf pkg-config-0.29.2
```
