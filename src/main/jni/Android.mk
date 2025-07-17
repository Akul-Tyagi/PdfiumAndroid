LOCAL_PATH := $(call my-dir)

#Prebuilt libraries
include $(CLEAR_VARS)
LOCAL_MODULE := aospPdfium

ARCH_PATH = $(TARGET_ARCH_ABI)

LOCAL_SRC_FILES := $(LOCAL_PATH)/lib/$(ARCH_PATH)/libmodpdfium.so

# Add page size flag
LOCAL_LDFLAGS += -Wl,-z,max-page-size=16384

include $(PREBUILT_SHARED_LIBRARY)

#c++_shared
include $(CLEAR_VARS)
LOCAL_MODULE := libmodc++_shared

LOCAL_SRC_FILES := $(LOCAL_PATH)/lib/$(ARCH_PATH)/libc++_shared.so

# Add page size flag
LOCAL_LDFLAGS += -Wl,-z,max-page-size=16384

include $(PREBUILT_SHARED_LIBRARY)

#libmodft2
include $(CLEAR_VARS)
LOCAL_MODULE := libmodft2

LOCAL_SRC_FILES := $(LOCAL_PATH)/lib/$(ARCH_PATH)/libmodft2.so

# Add page size flag
LOCAL_LDFLAGS += -Wl,-z,max-page-size=16384

include $(PREBUILT_SHARED_LIBRARY)

#libmodpng
include $(CLEAR_VARS)
LOCAL_MODULE := libmodpng

LOCAL_SRC_FILES := $(LOCAL_PATH)/lib/$(ARCH_PATH)/libmodpng.so

# Add page size flag
LOCAL_LDFLAGS += -Wl,-z,max-page-size=16384

include $(PREBUILT_SHARED_LIBRARY)

#Main JNI library
include $(CLEAR_VARS)
LOCAL_MODULE := jniPdfium

LOCAL_CFLAGS += -DHAVE_PTHREADS
LOCAL_C_INCLUDES += $(LOCAL_PATH)/include
LOCAL_SHARED_LIBRARIES += aospPdfium
LOCAL_LDLIBS += -llog -landroid -ljnigraphics

# Add page size flag
LOCAL_LDFLAGS += -Wl,-z,max-page-size=16384

LOCAL_SRC_FILES :=  $(LOCAL_PATH)/src/mainJNILib.cpp

include $(BUILD_SHARED_LIBRARY)
