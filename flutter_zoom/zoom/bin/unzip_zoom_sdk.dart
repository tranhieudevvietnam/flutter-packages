import 'dart:core';
import 'dart:io';
import 'dart:convert';
//import 'package:dio/dio.dart';

void main(List<String> args) async {
  var location = Platform.script.toString();
  var isNewFlutter = location.contains(".snapshot");
  if (isNewFlutter) {
    var sp = Platform.script.toFilePath();
    var sd = sp.split(Platform.pathSeparator);
    sd.removeLast();
    var scriptDir = sd.join(Platform.pathSeparator);
    var packageConfigPath = [scriptDir, '..', '..', '..', 'package_config.json']
        .join(Platform.pathSeparator);
    // print(packageConfigPath);
    var jsonString = File(packageConfigPath).readAsStringSync();
    // print(jsonString);
    Map<String, dynamic> packages = jsonDecode(jsonString);
    var packageList = packages["packages"];
    String? zoomFileUri;
    for (var package in packageList) {
      if (package["name"] == "zoom") {
        zoomFileUri = package["rootUri"];
        break;
      }
    }
    if (zoomFileUri == null) {
      print("zoom package not found!");
      return;
    }
    location = zoomFileUri;
  }
  if (Platform.isWindows) {
    location = location.replaceFirst("file:///", "");
  } else {
    location = location.replaceFirst("file://", "");
  }
  if (!isNewFlutter)
    location = location.replaceFirst("/bin/unzip_zoom_sdk.dart", "");
  // var filename =
  //     location + '/ios-sdk/MobileRTC${(args.length == 0) ? "" : "-dev"}.zip';

  await checkAndDownloadSDK(location);
  // print('Decompressing ' + filename);

  // final bytes = File(filename).readAsBytesSync();

  // final archive = ZipDecoder().decodeBytes(bytes);

  // var current = new File(location + '/ios/MobileRTC.framework/MobileRTC');
  // var exist = await current.exists();
  // if (exist) current.deleteSync();

  // for (final file in archive) {
  //   final filename = file.name;
  //   if (file.isFile) {
  //     final data = file.content as List<int>;
  //     File(location + '/ios/MobileRTC.framework/' + filename)
  //       ..createSync(recursive: true)
  //       ..writeAsBytesSync(data);
  //   }
  // }

  print('Complete');
}

Future<void> checkAndDownloadSDK(String location) async {
  var iosSDKFile = location +
      '/ios/MobileRTC.xcframework/ios-arm64/MobileRTC.framework/MobileRTC';
  bool exists = await File(iosSDKFile).exists();

  if (!exists) {
    // await downloadFile(
    //     Uri.parse('https://com21-static.s3.sa-east-1.amazonaws.com/zoom/ios/ios-arm64_armv7/MobileRTC?dl=1'),
    //     iosSDKFile);
    await downloadFile(
        Uri.parse(
            'https://drive.google.com/uc?id=1TxApfi_DUeQwyRvxzrQ5zZdYkVGoY8U4&export=download'),
        iosSDKFile);
  }

  var iosSimulateSDKFile = location +
      '/ios/MobileRTC.xcframework/ios-x86_64-simulator/MobileRTC.framework/MobileRTC';
  exists = await File(iosSimulateSDKFile).exists();

  if (!exists) {
    // await downloadFile(
    //     Uri.parse('https://com21-static.s3.sa-east-1.amazonaws.com/zoom/ios/ios-x86_64-simulator/MobileRTC'),
    //     iosSimulateSDKFile);
    await downloadFile(
        Uri.parse(
            'https://drive.google.com/uc?id=1FHmsnncbguc2WhFzBluqZ4JAhA6-nPMe&export=download'),
        iosSimulateSDKFile);
  }

  var androidCommonLibFile = location + '/android/libs/commonlib.aar';
  exists = await File(androidCommonLibFile).exists();
  if (!exists) {
    // await downloadFile(
    //     Uri.parse(
    //         'https://com21-static.s3.sa-east-1.amazonaws.com/zoom/android/commonlib.aar?dl=1'),
    await downloadFile(
        Uri.parse(
            'https://drive.google.com/u/1/uc?id=1b6jykGxH7KJtf0tVz0eTiBUMdM2MJUUY&export=download'),
        androidCommonLibFile);
  }
  var androidRTCLibFile = location + '/android/libs/mobilertc.aar';
  exists = await File(androidRTCLibFile).exists();
  if (!exists) {
    // await downloadFile(
    //     Uri.parse(
    //         'https://com21-static.s3.sa-east-1.amazonaws.com/zoom/android/mobilertc.aar?dl=1'),
    //     androidRTCLibFile);
    await downloadFile(
        Uri.parse(
            'https://doc-08-10-docs.googleusercontent.com/docs/securesc/3k8mo6c3vp0c2m3bvi172ufeifcggv6p/b360u4mkcp0p7t6om4vsd1cv2iig892e/1670468550000/02969869246661642938/13551815699291675095Z/1XIQJ71ZnomXCQB5vwETSKJ2O6uWfCYwR?e=download&uuid=3e4e86ff-5843-460b-8f23-3af148a0f991&nonce=jf5a23lpthmtk&user=13551815699291675095Z&hash=mp021ptc55q82hboo98vs9l14inb09d5'),
        androidRTCLibFile);
  }
}

Future<void> downloadFile(Uri uri, String savePath) async {
  print('Download ${uri.toString()} to $savePath');
  File destinationFile = await File(savePath).create(recursive: true);
  // var dio = Dio();
  // dio.options.connectTimeout = 1000000;
  // dio.options.receiveTimeout = 1000000;
  // dio.options.sendTimeout = 1000000;
  // await dio.downloadUri(uri, savePath);
  final request = await HttpClient().getUrl(uri);
  final response = await request.close();
  await response.pipe(destinationFile.openWrite());
}
