import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';

class DownloadsPathProvider {
  static const MethodChannel _channel =
      const MethodChannel('downloads_path_provider');

  static Future<Directory?> get downloadsDirectory async {
    try{
      final String path = await _channel.invokeMethod('getDownloadsDirectory');
      return Directory(path);
    }catch(error)
    {
      print("DownloadsPathProvider---- error: $error}");
      return null;
    }
  }
  static Future<Directory?> get pictureDirectory async {
    try{
      final String path = await _channel.invokeMethod('getPictureDirectory');
      return Directory(path);
    }catch(error)
    {
      print("DownloadsPathProvider---- error: $error}");
      return null;
    }
  }
}
