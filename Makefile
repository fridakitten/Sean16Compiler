# Makefile - Sean16Compiler

all:
	clang -isysroot $(shell xcrun --show-sdk-path) -target arm64-apple-macosx11.0 -shared libasmfile/*.c -o libasmfile.dylib
	clang -isysroot $(shell xcrun --show-sdk-path) -target arm64-apple-macosx11.0 *.c -L. -lasmfile -I./include -o sean16cmp
