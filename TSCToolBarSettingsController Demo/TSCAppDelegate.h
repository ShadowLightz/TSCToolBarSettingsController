//
//  TSCAppDelegate.h
//  TSCToolBarSettingsController Demo
//
//  Created by Jonathan Rahn on 03.01.14.
//  Copyright (c) 2014 Jonathan Rahn. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface TSCAppDelegate : NSObject <NSApplicationDelegate, NSWindowDelegate>

@property (assign) IBOutlet NSWindow *window;

- (IBAction)openPreferences:(id)sender;

@end
