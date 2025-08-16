package com.shockwave.pdfium;

import android.util.Log;

/**
 * Centralized native library loader for PdfiumAndroid.
 * Loads JNI first; transitive deps are loaded by the linker.
 */
final class NativeLoader {

    private static final String TAG = "PdfiumNativeLoader";
    private static volatile boolean loaded = false;

    // Load our JNI wrapper; it DT_NEEDEDs libpdfium.cr.so and friends.
    private static final String[] PRIMARY = {
            "jniPdfium"
    };

    // Optional names to try (best-effort, do not fail if missing)
    private static final String[] OPTIONAL = {
            // If someone still ships a separate libpdfium, try both common names
            "pdfium.cr",
            "pdfium"
    };

    static void load() {
        if (loaded) return;
        synchronized (NativeLoader.class) {
            if (loaded) return;

            for (String lib : PRIMARY) loadOne(lib, false);
            for (String lib : OPTIONAL) loadOne(lib, true);

            loaded = true;
        }
    }

    private static void loadOne(String name, boolean optional) {
        try {
            System.loadLibrary(name);
            Log.i(TAG, "Loaded library: " + name);
        } catch (UnsatisfiedLinkError e) {
            if (optional) {
                Log.i(TAG, "Optional library not found: " + name);
            } else {
                throw e;
            }
        }
    }

    private NativeLoader() {}
}