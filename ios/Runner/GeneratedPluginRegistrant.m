//
//  Generated file. Do not edit.
//

// clang-format off

#import "GeneratedPluginRegistrant.h"

#if __has_include(<package_info_plus/FLTPackageInfoPlusPlugin.h>)
#import <package_info_plus/FLTPackageInfoPlusPlugin.h>
#else
@import package_info_plus;
#endif

#if __has_include(<sentry_flutter/SentryFlutterPlugin.h>)
#import <sentry_flutter/SentryFlutterPlugin.h>
#else
@import sentry_flutter;
#endif

@implementation GeneratedPluginRegistrant

+ (void)registerWithRegistry:(NSObject<FlutterPluginRegistry>*)registry {
  [FLTPackageInfoPlusPlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTPackageInfoPlusPlugin"]];
  [SentryFlutterPlugin registerWithRegistrar:[registry registrarForPlugin:@"SentryFlutterPlugin"]];
}

@end
