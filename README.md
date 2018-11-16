Build Common-API for C
======================

Testing build of common-api for C, after building systemd also from source.

I got some strange errors depending on which systemd version was used to
link against, so I decided to write a script to test what's going on and in
particular to build on a clean machine where no systemd is installed to
interfere - only the version built from source will be used.

Usage:
```
   ./build.sh <systemd-version>
```

for example:

```
   ./build.sh v239
```

When done, the libcapic.so library should be created.

After latest update only the systemd versions that build with meson+ninja
are supported.  systemd has various dependencies that will need to be
installed with your package manager.

This is definitely not a complete list: libcap-devel, libmount-devel, gperf

The build-many script can be ignored.  Just read it, you'll see...

