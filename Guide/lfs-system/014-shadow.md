*使用强密码*
获取软件包
[cracklib-2.9.6.tar.gz](https://github.com/cracklib/cracklib/releases/download/cracklib-2.9.6/cracklib-2.9.6.tar.gz)
[cracklib-words-2.9.6.gz](https://github.com/cracklib/cracklib/releases/download/cracklib-2.9.6/cracklib-words-2.9.6.gz)
```bash
cd /sources &&
tar zxvf cracklib-2.9.6.tar.gz &&
cd cracklib-2.9.6 &&
sed -i '/skipping/d' util/packer.c &&

./configure --prefix=/usr    \
            --disable-static \
            --with-default-dict=/lib/cracklib/pw_dict &&
make &&
make install                      &&
mv -v /usr/lib/libcrack.so.* /lib &&
ln -sfv ../../lib/$(readlink /usr/lib/libcrack.so) /usr/lib/libcrack.so &&
install -v -m644 -D    ../cracklib-words-2.9.6.gz \
                         /usr/share/dict/cracklib-words.gz     &&

gunzip -v                /usr/share/dict/cracklib-words.gz     &&
ln -v -sf cracklib-words /usr/share/dict/words                 &&
echo $(hostname) >>      /usr/share/dict/cracklib-extra-words  &&
install -v -m755 -d      /lib/cracklib                         &&

create-cracklib-dict     /usr/share/dict/cracklib-words \
                         /usr/share/dict/cracklib-extra-words &&
cd /sources &&
rm -rvf cracklib-2.9.6
```

```bash
cd /sources &&
tar xvf shadow-4.6.tar.xz &&
cd shadow-4.6 &&
sed -i 's/groups$(EXEEXT) //' src/Makefile.in &&
find man -name Makefile.in -exec sed -i 's/groups\.1 / /'   {} \; &&
find man -name Makefile.in -exec sed -i 's/getspnam\.3 / /' {} \; &&
find man -name Makefile.in -exec sed -i 's/passwd\.5 / /'   {} \; &&
sed -i -e 's@#ENCRYPT_METHOD DES@ENCRYPT_METHOD SHA512@' \
       -e 's@/var/spool/mail@/var/mail@' etc/login.defs &&
sed -i 's@DICTPATH.*@DICTPATH\t/lib/cracklib/pw_dict@' etc/login.defs &&
sed -i 's/1000/999/' etc/useradd &&
./configure --sysconfdir=/etc --with-group-name-max-length=32 --with-libcrack &&
make && make install &&
mv -v /usr/bin/passwd /bin &&
pwconv && grpconv &&
sed -i 's/yes/no/' /etc/default/useradd &&
cd /sources &&
rm -rvf shadow-4.6 
```
*修改root密码*
```bash
passwd root
```
