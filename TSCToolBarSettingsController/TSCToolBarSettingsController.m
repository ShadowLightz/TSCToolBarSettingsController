//
//  TSCToolBarSettingsController.m
//  MathApps
//
//  Created by Jonathan Rahn on 02.01.14.
//  Copyright (c) 2014 Jonathan Rahn. All rights reserved.
//

#import "TSCToolBarSettingsController.h"

@interface TSCToolBarSettingsController ()

@property NSMutableDictionary* views;
@property NSMutableSet* workaroundIdentifiers;
@property NSToolbarItem* selectedItem;

@end

@implementation TSCToolBarSettingsController

- (id)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    if (self)
    {
        self.window.toolbar.allowsUserCustomization = NO;
        self.views = [NSMutableDictionary dictionary];
        self.workaroundIdentifiers = [NSMutableSet new];
    }
    return self;
}

- (void) addItemIdentifierWhichNeedsWorkaround:(NSString *)identifier
{
    [self.workaroundIdentifiers addObject:identifier];
}

- (void) addSubView:(NSView *)newSubView ToolbarItemIdentifier: (NSString*) toolbarItemIdentifier;
{
        [self.window close];
        [self.views setObject:newSubView forKey:toolbarItemIdentifier];
        [self.window.toolbar insertItemWithItemIdentifier:toolbarItemIdentifier atIndex:self.window.toolbar.items.count];
        for (NSToolbarItem* item in self.window.toolbar.items)
        {
            item.target = self;
            item.action = @selector(toolbarItemclick:);
            item.Enabled = YES;
        }
        [self displayView:[self.views objectForKey:[self.window.toolbar.items[0] itemIdentifier]] forToolBarItem:self.window.toolbar.items[0] Animates:NO];
        [self.window display];
}

- (void) toolbarItemclick: (NSToolbarItem*) sender
{
    if (self.selectedItem != sender)
    {
        self.selectedItem = sender;
        [self displayView:[self.views objectForKey:sender.itemIdentifier] forToolBarItem:sender Animates:YES];
    }
}

- (void) displayView: (NSView*) view forToolBarItem: (NSToolbarItem*) item Animates: (BOOL) animates
{
    double delay = 0;
    if ([self.workaroundIdentifiers containsObject:item.itemIdentifier])
    {
            //Strange, but the following lines have to be repeated to solve a layout bug
        [view setFrame:NSMakeRect(0, 0, 0, 0)];
        [view layoutSubtreeIfNeeded];
        [view setFrame:NSMakeRect(0, 0, 0, 0)];
        if (animates)
        {
            delay = 0.27;
        }
    }
    [view layoutSubtreeIfNeeded];
    [self.window.toolbar setSelectedItemIdentifier:item.itemIdentifier];
    CGRect newViewFrame = view.frame;
    CGRect newWindowFrame = [self calculateWindowFrameForViewFrame:newViewFrame];
    self.window.title = item.label;
    self.window.contentView = [NSView new];
    
    [[self.window.contentView animator] addSubview:view];
    [[self.window animator]setFrame:newWindowFrame display:NO animate:animates];
        //Really dirty hack, but I need this delay because there are graphic glitches if I add these constraints while the view animates
    [self performSelector:@selector(addMarginConstraintsToView:) withObject:view afterDelay:delay];
}

- (NSRect) calculateWindowFrameForViewFrame:(NSRect)viewFrame
{
    NSRect oldWindowFrame = self.window.frame;
    NSRect oldContentFrame = [self.window.contentView frame];
    double heightToolbar = CGRectGetHeight(oldWindowFrame) - CGRectGetHeight(oldContentFrame);
    double oldHeight = CGRectGetHeight(oldWindowFrame);
    double newHeight = CGRectGetHeight(viewFrame)+heightToolbar;
    double heightDifference = newHeight - oldHeight;
    double newWidth = CGRectGetWidth(viewFrame);
    NSPoint lowerLeftPoint = NSMakePoint(CGRectGetMinX(oldWindowFrame), CGRectGetMinY(oldWindowFrame));
    return NSMakeRect(lowerLeftPoint.x, lowerLeftPoint.y-heightDifference, newWidth, newHeight);
}

- (void) addMarginConstraintsToView: (NSView*) view
{
    NSLayoutConstraint *constaint = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:view.superview attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
    [self.window.contentView addConstraint:constaint];
    constaint = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:view.superview attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
    [self.window.contentView addConstraint:constaint];
    constaint = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:view.superview attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
    [self.window.contentView addConstraint:constaint];
    constaint = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:view.superview attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
    [self.window.contentView addConstraint:constaint];
}

@end
