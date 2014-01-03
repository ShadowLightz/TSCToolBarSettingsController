    //
//  TSCAppDelegate.m
//  TSCToolBarSettingsController Demo
//
//  Created by Jonathan Rahn on 03.01.14.
//  Copyright (c) 2014 Jonathan Rahn. All rights reserved.
//

#import "TSCAppDelegate.h"
#import "TSCToolBarSettingsController.h"
#import "TSCWindowController.h"

@interface TSCAppDelegate ()

@property TSCWindowController* windowController;

@end

@implementation TSCAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
}

- (IBAction)openPreferences:(id)sender
{
    if (!self.windowController)
    {
        self.windowController = [[TSCWindowController alloc]initWithWindowNibName:@"Preferences"];
    }
    [self.windowController.window makeKeyAndOrderFront:self];
}

@end
