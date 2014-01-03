//
//  TSCToolBarSettingsController.h
//  MathApps
//
//  Created by Jonathan Rahn on 02.01.14.
//  Copyright (c) 2014 Jonathan Rahn. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface TSCToolBarSettingsController : NSWindowController

- (void) addSubView: (NSView*) newSubView ToolbarItemIdentifier: (NSString*) toolbarItemIdentifier;
- (void) addItemIdentifierWhichNeedsWorkaround: (NSString*) identifier;

@end
