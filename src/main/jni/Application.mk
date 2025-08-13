APP_STL := c++_shared
APP_CPPFLAGS += -fexceptions
APP_PLATFORM := android-21
APP_ABI := armeabi-v7a arm64-v8a x86 x86_64

# 16KB compatibility flag
APP_LDFLAGS += -Wl,-z,max-page-size=16384