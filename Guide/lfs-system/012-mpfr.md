```bash
cd /sources &&
tar xvf mpfr-4.0.1.tar.xz &&
cd mpfr-4.0.1 &&
./configure --prefix=/usr        \
            --disable-static     \
            --enable-thread-safe \
            --docdir=/usr/share/doc/mpfr-4.0.1 &&
make && make install &&
cd /sources &&
rm -rvf mpfr-4.0.1
```
