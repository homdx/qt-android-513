#!/bin/bash

#cd /Qt5140
#ls -la /qt514-beta2.tar.gz
#time tar -xf qt514-beta2.tar.gz && time rm qt514-beta2.tar.gz && date
#mv Qt514/ Qt

export QT_VERSION=5.13.2
echo QT version is $QT_VERSION
echo show envs in build script
set
export FOLDER=Qt5132
export PATH="/${FOLDER}/Qt/$QT_VERSION/gcc_64/bin:${PATH}"

echo show new envs in build script
set
echo search whereis
whereis qmake

echo export NDK_VERSION=r20 && \
echo export    ANDROID_NDK_ARCH=arch-arm c && \
echo export    ANDROID_NDK_EABI=llvm c && \
echo export    ANDROID_NDK_HOST=linux-x86_64 c && \
echo export    ANDROID_NDK_TOOLCHAIN_PREFIX=arm-linux-androideabi c && \
echo export    ANDROID_NDK_TOOLCHAIN_VERSION=4.9 c && \
echo export    ANDROID_BUILD_TOOLS_REVISION=29.0.5 && \
echo export DEBIAN_FRONTEND=noninteractive c && \
cd /${FOLDER}/Qt/${QT_VERSION}/Src && echo start build && date && \
./configure -android-arch x86 -opensource -confirm-license -release -nomake tests -nomake examples  -no-compile-examples \
 -android-sdk /android-sdk-linux -android-ndk /android-ndk-r20 -no-warnings-are-errors --disable-rpath \
-openssl -I /android_openssl/openssl-1.1.1d/include -L /android_openssl/arm -xplatform android-clang \
-prefix /usr/local/x86 \
&& make -j5 -s --no-print-directory && echo end build && date && echo build done && make install && \
cd /${FOLDER}/Qt/${QT_VERSION}/Src/qtbase/src/tools/androiddeployqt && make && make install &&  echo done1 && \
date && cd / && rm -rf /${FOLDER} && date && echo all done ok || echo error build
