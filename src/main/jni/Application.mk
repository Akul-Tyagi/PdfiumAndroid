APP_STL := c++_static
APP_CPPFLAGS += -fexceptions
APP_PLATFORM := android-21
# Build only 64-bit (recommended for Play)
APP_ABI := arm64-v8a x86_64

# 16KB compatibility flags (both common- and max-page-size)
APP_LDFLAGS += -Wl,-z,common-page-size=16384 -Wl,-z,max-page-size=16384