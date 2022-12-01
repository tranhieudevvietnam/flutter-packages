#import "DownloadsPathProviderPlugin.h"

@implementation DownloadsPathProviderPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"downloads_path_provider"
            binaryMessenger:[registrar messenger]];
  DownloadsPathProviderPlugin* instance = [[DownloadsPathProviderPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([call.method isEqualToString:@"getDownloadsDirectory"]) {
    result([self getDownloadsDirectory]);
  }
  else if( [call.method isEqualToString:@"getPictureDirectory"]){
      result([self getPictureDirectory]);
  }
  else {
    result(FlutterMethodNotImplemented);
  }
}

- (NSString*)getDownloadsDirectory {
  NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDownloadsDirectory, NSUserDomainMask, YES);
  return paths.firstObject;
}

- (NSString*)getPictureDirectory {
  NSArray* paths = NSSearchPathForDirectoriesInDomains(NSPicturesDirectory, NSUserDomainMask, YES);
  return paths.firstObject;
}

@end
