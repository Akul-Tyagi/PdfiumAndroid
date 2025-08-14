package com.shockwave.pdfium;

import android.util.Log;

/**
 * Centralized native library loader for PdfiumAndroid.
 * Loads new canonical libraries first, then (optionally) legacy names if present.
 */
final class NativeLoader {

    private static final String TAG = "PdfiumNativeLoader";
    private static volatile boolean loaded = false;

    // Required modern libs (fail hard if missing)
    private static final String[] PRIMARY = {
            "pdfium",
            "jniPdfium"
    };

    // We link libc++ statically; don't attempt to load it.
    private static final String[] OPTIONAL_STL = { };

    // Legacy libs we used to ship (best-effort)
    private static final String[] LEGACY = {
            "modpdfium",
            "modpng",
            "modft2"
    };

    static void load() {
        if (loaded) return;
        synchronized (NativeLoader.class) {
            if (loaded) return;

            for (String lib : OPTIONAL_STL) loadOne(lib, true);
            for (String lib : PRIMARY) loadOne(lib, false);
            for (String lib : LEGACY) loadOne(lib, true);

            loaded = true;
        }
    }

    private static void loadOne(String name, boolean optional) {
        try {
            System.loadLibrary(name);
            Log.i(TAG, "Loaded library: " + name);
        } catch (UnsatisfiedLinkError e) {
            if (optional) {
                Log.i(TAG, "Optional/legacy library not found: " + name);
            } else {
                throw e;
            }
        }
    }

    private NativeLoader() {}
}