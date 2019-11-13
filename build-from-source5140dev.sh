#!/bin/bash

export QT_VERSION=5.14.0
#export FOLDER=qt5
export FOLDER=Qt/5.14.0/Src

export NDK_VERSION=r20 && \
cd /${FOLDER} && echo start build && date && LANG=C ./configure -opensource -confirm-license \
-release -nomake tests -nomake examples -no-compile-examples -android-sdk /android-sdk-linux -android-ndk /android-ndk-r20 \
-xplatform android-clang -no-warnings-are-errors --disable-rpath \
-openssl -I /android_openssl/openssl-1.1.1d/include -L /android_openssl/arm \
-android-abis armeabi-v7a -developer-build \
-prefix /usr/local \
&& make -s --no-print-directory && echo end build && date && echo build done \
&& make install && cd /${FOLDER}/qtbase/src/tools/androiddeployqt && make && make install \
&& echo done1 && date && cd / && rm -rf /${FOLDER} && date && echo all done ok || echo error build
#-android-abis armeabi-v7a,x86,arm64-v8a,x86_64 -developer-build \
