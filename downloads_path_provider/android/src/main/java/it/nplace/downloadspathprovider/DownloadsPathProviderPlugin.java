package it.nplace.downloadspathprovider;

import android.os.Environment;

import java.io.File;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/**
 * DownloadsPathProviderPlugin
 */
public class DownloadsPathProviderPlugin implements MethodCallHandler {
    /**
     * Plugin registration.
     */
    public static void registerWith(Registrar registrar) {
        final MethodChannel channel = new MethodChannel(registrar.messenger(), "downloads_path_provider");
        channel.setMethodCallHandler(new DownloadsPathProviderPlugin());
    }

    @Override
    public void onMethodCall(MethodCall call, Result result) {
        if (call.method.equals("getDownloadsDirectory")) {
            result.success(getDownloadsDirectory());
        } else if (call.method.equals("getPictureDirectory")) {
            result.success(getPictureDirectory());
        } else {
            result.notImplemented();
        }
    }

    private String getDownloadsDirectory() {
        return Environment.getExternalStoragePublicDirectory(Environment.DIRECTORY_DOWNLOADS).getAbsolutePath();
    }



    private String getPictureDirectory() {
        String albumFolderPath = Environment.getExternalStorageDirectory().getPath();
        if (android.os.Build.VERSION.SDK_INT < 29) {
            albumFolderPath += File.separator + Environment.DIRECTORY_DCIM;
            return  albumFolderPath;
        }
        return createDirIfNotExist(
                Environment.getExternalStoragePublicDirectory(Environment.DIRECTORY_PICTURES).getPath()
        );
//        return Environment.getExternalStoragePublicDirectory(Environment.DIRECTORY_PICTURES).getAbsolutePath();
    }

    private String createDirIfNotExist(String dirPath) {
        File dir = new File(dirPath);
        if (!dir.exists()) {
            if (dir.mkdirs()) {
                return dir.getPath();
            } else {
                return null;
            }
        } else {
            return dir.getPath();
        }
    }

}
