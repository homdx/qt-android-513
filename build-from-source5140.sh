#!/bin/bash

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

export NDK_VERSION=r20 && \
export    ANDROID_NDK_ARCH=arch-arm c && \
export    ANDROID_NDK_EABI=llvm c && \
export    ANDROID_NDK_HOST=linux-x86_64 c && \
export    ANDROID_NDK_TOOLCHAIN_PREFIX=arm-linux-androideabi c && \
export    ANDROID_NDK_TOOLCHAIN_VERSION=4.9 c && \
export    ANDROID_BUILD_TOOLS_REVISION=29.0.2 && \
export DEBIAN_FRONTEND=noninteractive c && \
cd /${FOLDER}/Qt/${QT_VERSION}/Src && echo start build && date && LANG=C ./configure -android-arch armeabi-v7a -opensource -confirm-license \
-release -nomake tests -nomake examples -no-compile-examples -android-sdk /android-sdk-linux -android-ndk /android-ndk-r20 \
-xplatform android-clang -no-warnings-are-errors --disable-rpath \
-openssl -I /android_openssl/openssl-1.1.1d/include -L /android_openssl/arm \
-prefix /usr/local/armv7 \
&& make -j5 -s --no-print-directory && echo end build && date && echo build done \
&& make install && cd /${FOLDER}/Qt/${QT_VERSION}/Src/qtbase/src/tools/androiddeployqt && make && make install \
&& echo done1 && date && echo rm -rf /${FOLDER} && date && echo all done ok || echo error build
