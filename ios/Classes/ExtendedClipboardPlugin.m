#import "ExtendedClipboardPlugin.h"
#if __has_include(<extended_clipboard/extended_clipboard-Swift.h>)
#import <extended_clipboard/extended_clipboard-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "extended_clipboard-Swift.h"
#endif

@implementation ExtendedClipboardPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftExtendedClipboardPlugin registerWithRegistrar:registrar];
}
@end
