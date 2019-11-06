FROM fedora:31

ARG NDK_VERSION=r20
ARG SDK_INSTALL_PARAMS=platform-tool,build-tools;29.0.2
ARG ANDROID_SDK_ROOT=/android-sdk-linux

RUN dnf update -y && dnf install clang unzip wget time java-1.8.0-openjdk java-1.8.0-openjdk-devel aria2 which patch git make -y

#COPY install-android-sdk /tmp/install-android-sdk
RUN JAVA_HOME=$(dirname $( readlink -f $(which java) )) \
   && JAVA_HOME=$(realpath "$JAVA_HOME"/../) \
   && export JAVA_HOME && echo $JAVA_HOME \
   && wget https://raw.githubusercontent.com/homdx/qtci/513/bin/install-android-sdk --directory-prefix=/tmp \
   &&  chmod u+rx /tmp/install-android-sdk \
   && /tmp/install-android-sdk $SDK_INSTALL_PARAMS

RUN cd /android-sdk-linux/tools/bin/ && ./sdkmanager "platforms;android-21" && cd / && git clone https://github.com/homdx/android_openssl.git  && \
mkdir ~/android && ln -s /android-ndk-r20 ~/android/ndk-bundle && cd /android_openssl && echo time ./build_ssl.sh

ARG ADBCACHE_HASH=2d79d59fb56374337f3b7b09712f3d2e92b6b494d9a386861fdffe3879246a0ca792ab9c295a20beb1835c063aff5736ea1c559ab6765dc490add4b9fc337bd5

RUN mkdir /Qt5132 && cd /Qt5132 && curl -SL https://github.com/homdx/qt-download-2/releases/download/3/qt-installed-5132.aa -o qt-installed-5132.aa \
   && curl -SL https://github.com/homdx/qt-download-2/releases/download/3/qt-installed-5132.ab -o qt-installed-5132.ab \
   && cat qt-installed-5132.?? > qt-5132.tar.gz && rm -vf qt-installed-5132.*  \
   && set -ex && echo "${ADBCACHE_HASH}  qt-5132.tar.gz" | sha512sum -c  \
   && time tar -xf qt-5132.tar.gz && time rm qt-5132.tar.gz && date && ls /

RUN echo build OpenSSL from sources && \
export NDK_VERSION=r20 && \
export    ANDROID_NDK_ARCH=arch-arm c && \
export    ANDROID_NDK_EABI=llvm c && \
export    ANDROID_NDK_HOST=linux-x86_64 c && \
export    ANDROID_NDK_TOOLCHAIN_PREFIX=arm-linux-androideabi c && \
export    ANDROID_NDK_TOOLCHAIN_VERSION=4.9 c && \
export DEBIAN_FRONTEND=noninteractive c && \
export ANDROID_NDK_HOME=/android-ndk-r20 && \
cd /android_openssl/ && git checkout 5140  && echo patch -p0 ssl.patch && echo start build ssl && date && time ./build_ssl.sh && date && echo build done && \
ls -la arm

COPY build-from-source5140x86.sh /
COPY build-from-source5140.sh /

RUN cd /android-sdk-linux/tools/bin && ./sdkmanager "build-tools;29.0.2" && time /build-from-source5140x86.sh && echo build all done || echo error build

RUN time rm -rf /Qt5132 && mkdir /Qt5132 && cd /Qt5132 && curl -SL https://github.com/homdx/qt-download-2/releases/download/3/qt-installed-5132.aa -o qt-installed-5132.aa \
   && curl -SL https://github.com/homdx/qt-download-2/releases/download/3/qt-installed-5132.ab -o qt-installed-5132.ab \
   && cat qt-installed-5132.?? > qt-5132.tar.gz && rm -vf qt-installed-5132.*  \
   && set -ex && echo "${ADBCACHE_HASH}  qt-5132.tar.gz" | sha512sum -c  \
   && time tar -xf qt-5132.tar.gz && time rm qt-5132.tar.gz && date && ls /

RUN time /build-from-source5140.sh && echo build all done || echo error build


CMD tail -f /bin/true
