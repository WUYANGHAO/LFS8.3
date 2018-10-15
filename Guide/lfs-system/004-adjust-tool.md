```bash
mv -v /tools/bin/{ld,ld-old}
mv -v /tools/$(uname -m)-pc-linux-gnu/bin/{ld,ld-old}
mv -v /tools/bin/{ld-new,ld}
ln -sv /tools/bin/ld /tools/$(uname -m)-pc-linux-gnu/bin/ld
gcc -dumpspecs | sed -e 's@/tools@@g'                   \
    -e '/\*startfile_prefix_spec:/{n;s@.*@/usr/lib/ @}' \
    -e '/\*cpp:/{n;s@$@ -isystem /usr/include@}' >      \
    `dirname $(gcc --print-libgcc-file-name)`/specs
```

*校验*
```bash
echo 'int main(){}' > dummy.c
cc dummy.c -v -Wl,--verbose &> dummy.log
readelf -l a.out | grep ': /lib'
```
*返回值*
```bash
[Requesting program interpreter: /lib64/ld-linux-x86-64.so.2]
```
*校验2*
```bash
grep -o '/usr/lib.*/crt[1in].*succeeded' dummy.log
```
*返回值2*
```bash
/usr/lib/../lib/crt1.o succeeded
/usr/lib/../lib/crti.o succeeded
/usr/lib/../lib/crtn.o succeeded
```
*校验3*
```bash
grep -B1 '^ /usr/include' dummy.log
```
*返回值3*
```bash
#include <...> search starts here:
 /usr/include
```
*校验4*
```bash
grep 'SEARCH.*/usr/lib' dummy.log |sed 's|; |\n|g'
```
*返回值4*
```bash
SEARCH_DIR("/usr/lib")
SEARCH_DIR("/lib")
```

*校验5*
```bash
grep "/lib.*/libc.so.6 " dummy.log
```
*返回值5*
```bash
attempt to open /lib/libc.so.6 succeeded
```
*校验6*
```bash
grep found dummy.log
```
*返回值6*
```bash
found ld-linux-x86-64.so.2 at /lib/ld-linux-x86-64.so.2
```
### 清理
```bash
rm -v dummy.c a.out dummy.log
```
