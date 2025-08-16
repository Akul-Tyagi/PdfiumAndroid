LOCAL_PATH := $(call my-dir)

# Only build/link for these ABIs (match what you actually ship in jniLibs/)
SUPPORTED_ABIS := arm64-v8a x86_64

ifeq (,$(filter $(TARGET_ARCH_ABI),$(SUPPORTED_ABIS)))
$(warning Skipping unsupported ABI $(TARGET_ARCH_ABI) for PdfiumAndroid)
# Do not define any modules for unsupported ABIs
else

# Single modern pdfium prebuilt
include $(CLEAR_VARS)
LOCAL_MODULE := pdfium
# Point to the packaged .so in jniLibs so the linker finds the same file we ship
LOCAL_SRC_FILES := ../jniLibs/$(TARGET_ARCH_ABI)/libpdfium.cr.so
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

endif