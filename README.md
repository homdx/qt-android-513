**Windows**

CLANG x86 (32 bit Windows)

`configure.bat -debug -static -recheck-all -I "C:/Program Files/OpenSSL-Win32/include" -L "C:/Program Files/OpenSSL-Win32/lib" -prefix H:/QtDebugClang -opensource -confirm-license -nomake examples -nomake tests  -skip qtwebengine  -platform win32-clang-msvc`

CLANG x86 (64 bit Windows)

`configure.bat -debug -recheck-all -I "C:/Program Files (x86)/OpenSSL-Win32/include" -L "C:/Program Files (x86)/OpenSSL-Win32/lib" -prefix H:/QtDebug514Clang -opensource -confirm-license -nomake examples -nomake tests  -skip qtwebengine  -platform win32-clang-msvc`
