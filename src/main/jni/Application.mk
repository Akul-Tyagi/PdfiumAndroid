APP_STL := c++_shared
APP_CPPFLAGS += -fexceptions

# Add page size flags to support 16KB pages
APP_LDFLAGS += -Wl,--page-size=16384

#For ANativeWindow support
APP_PLATFORM = android-19

APP_ABI :=  armeabi-v7a \
            arm64-v8a \
            x86 \
            x86_64
