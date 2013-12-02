//  Copyright (c) 2012 Jonathan 'Wolf' Rentzsch: http://rentzsch.com
//  Some rights reserved: http://opensource.org/licenses/MIT

#import "ForceQuitUnresponsiveAppsAppDelegate.h"
#import "CGSNotifications.h"

void MyNotifyProc(CGSNotificationType type, void *data, unsigned int dataLength, void *userData) {
    assert(kCGSNotificationAppUnresponsive == type);
    assert(data);
    assert(dataLength >= sizeof(CGSProcessNotificationData));
    
    CGSProcessNotificationData *noteData = (CGSProcessNotificationData*)data;
    
    NSRunningApplication *unresponsiveProcess = [NSRunningApplication runningApplicationWithProcessIdentifier:noteData->pid];
    
    NSString* name = unresponsiveProcess.localizedName;
    NSString* path = unresponsiveProcess.executableURL.absoluteString;
    
    if ([name isEqualToString:@"instruments"] ||
        [path hasSuffix:@"instruments"]) {
      NSLog(@"Force quitting: '%@' at '%@'", name, path);
      [unresponsiveProcess forceTerminate];
    } else {
      NSLog(@"Ignoring. Unresponsive app '%@' at '%@' is not instruments.", name, path);
    }
}

@implementation ForceQuitUnresponsiveAppsAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification*)notification_ {
	CGError err = CGSRegisterNotifyProc(MyNotifyProc,
                                        kCGSNotificationAppUnresponsive,
                                        NULL);
    if (err) {
        CGSGlobalError(err, "");
        [NSApp terminate:nil];
    }
}

@end
