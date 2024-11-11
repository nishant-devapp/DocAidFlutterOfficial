package com.reshita.docaid;

import io.flutter.embedding.android.FlutterActivity;

public class MainActivity extends FlutterActivity {
}


/*
package com.reshita.docaid;

import android.content.ContentValues;
import android.net.Uri;
import android.os.Build;
import android.os.Bundle;
import android.provider.MediaStore;
import android.util.Log;
import androidx.annotation.NonNull;
import java.io.OutputStream;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class MainActivity extends FlutterActivity {
    private static final String CHANNEL = "pdf_saving_channel";

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);

        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
                .setMethodCallHandler(
                        (call, result) -> {
                            if (call.method.equals("saveToDownloads")) {
                                byte[] data = call.argument("data");
                                String fileName = call.argument("fileName");

                                if (data != null && fileName != null) {
                                    Uri uri = savePdfToDownloads(data, fileName);
                                    if (uri != null) {
                                        result.success(uri.toString());
                                    } else {
                                        result.error("UNAVAILABLE", "Failed to save PDF", null);
                                    }
                                } else {
                                    result.error("INVALID_ARGUMENTS", "Invalid arguments passed", null);
                                }
                            } else {
                                result.notImplemented();
                            }
                        }
                );
    }

    private Uri savePdfToDownloads(byte[] data, String fileName) {
        Uri uri = null;
        try {
            ContentValues contentValues = new ContentValues();
            contentValues.put(MediaStore.MediaColumns.DISPLAY_NAME, fileName);
            contentValues.put(MediaStore.MediaColumns.MIME_TYPE, "application/pdf");

            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
                // For Android 10 (API level 29) and above, use MediaStore and relative path.
                contentValues.put(MediaStore.MediaColumns.RELATIVE_PATH, "Download/");
                uri = getContentResolver().insert(MediaStore.Downloads.EXTERNAL_CONTENT_URI, contentValues);
            } else {
                // For Android 9 (API level 28) and below, directly save to the download folder
                uri = MediaStore.Files.getContentUri("external");
                contentValues.put(MediaStore.MediaColumns.DATA, "/storage/emulated/0/Download/" + fileName);
                uri = getContentResolver().insert(uri, contentValues);
            }

            if (uri != null) {
                try (OutputStream outputStream = getContentResolver().openOutputStream(uri)) {
                    if (outputStream != null) {
                        outputStream.write(data);
                        outputStream.flush();
                    }
                }
            }
        } catch (Exception e) {
            Log.e("MediaStore", "Failed to save PDF: " + e.getMessage());
            uri = null;
        }
        return uri;
    }
}
*/
