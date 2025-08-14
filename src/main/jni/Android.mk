LOCAL_PATH := $(call my-dir)

# Single modern pdfium prebuilt
include $(CLEAR_VARS)
LOCAL_MODULE := pdfium
LOCAL_SRC_FILES := lib/$(TARGET_ARCH_ABI)/libpdfium.so
LOCAL_EXPORT_C_INCLUDES := $(LOCAL_PATH)/include
include $(PREBUILT_SHARED_LIBRARY)

# JNI wrapper that calls into pdfium
include $(CLEAR_VARS)
LOCAL_MODULE := jniPdfium
LOCAL_CFLAGS += -DHAVE_PTHREADS
LOCAL_C_INCLUDES += $(LOCAL_PATH)/include
LOCAL_SHARED_LIBRARIES += pdfium
LOCAL_LDLIBS += -llog -landroid -ljnigraphics
# Force 16KB page alignment on the JNI library too
LOCAL_LDFLAGS += -Wl,-z,common-page-size=16384 -Wl,-z,max-page-size=16384
LOCAL_SRC_FILES := src/mainJNILib.cpp
include $(BUILD_SHARED_LIBRARY)