//
//  TSCWindowController.m
//  TSCToolBarSettingsController Demo
//
//  Created by Jonathan Rahn on 03.01.14.
//  Copyright (c) 2014 Jonathan Rahn. All rights reserved.
//

#import "TSCWindowController.h"
#import "TSCToolBarSettingsController.h"

@interface TSCWindowController ()

@property TSCToolBarSettingsController* controller;

@property NSViewController* category1Controller;
@property NSViewController* otherStuffController;
@property NSViewController* advancedController;

@end

@implementation TSCWindowController

- (id)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    if (self) {
        // Initialization code here.
    }
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    self.category1Controller = [[NSViewController alloc]initWithNibName:@"Preferences_Category1View" bundle:nil];
    self.otherStuffController = [[NSViewController alloc]initWithNibName:@"Preferences_OtherStuffView" bundle:nil];
    self.advancedController = [[NSViewController alloc]initWithNibName:@"Preferences_AdvancedView" bundle:nil];
    
    self.controller = [[TSCToolBarSettingsController alloc]initWithWindow:self.window];
    [self.controller addItemIdentifierWhichNeedsWorkaround:@"Category1"];
    [self.controller addSubView:self.category1Controller.view ToolbarItemIdentifier:@"Category1"];
    [self.controller addSubView:self.otherStuffController.view ToolbarItemIdentifier:@"Other Stuff"];
    [self.controller addSubView:self.advancedController.view ToolbarItemIdentifier:@"Advanced"];
}

@end
