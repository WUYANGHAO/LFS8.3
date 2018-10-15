```bash
cd $LFS/sources &&
tar xvf perl-5.28.0.tar.xz &&
cd perl-5.28.0 &&
sh Configure -des -Dprefix=/tools -Dlibs=-lm -Uloclibpth -Ulocincpth &&
make &&
cp -v perl cpan/podlators/scripts/pod2man /tools/bin &&
mkdir -pv /tools/lib/perl5/5.28.0 &&
cp -Rv lib/* /tools/lib/perl5/5.28.0 &&
cd $LFS/sources &&
rm -rvf perl-5.28.0
```
