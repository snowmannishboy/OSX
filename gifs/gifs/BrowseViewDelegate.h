//
//  BrowseViewDelegate.h
//  gifs
//
//  Created by Robert Novak on 1/23/14.
//  Copyright (c) 2014 Robert Novak. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <Quartz/Quartz.h>
#import "MainController.h"

@interface BrowseViewDelegate : NSControl {
    
}


@property IBOutlet BrowseViewController* controller;
@property IBOutlet IKImageBrowserView* browser;


- (void) imageBrowser:(IKImageBrowserView *) aBrowser backgroundWasRightClickedWithEvent:(NSEvent *) event;

- (void) imageBrowser:(IKImageBrowserView *) aBrowser cellWasDoubleClickedAtIndex:(NSUInteger) index;

- (void) imageBrowser:(IKImageBrowserView *) aBrowser cellWasRightClickedAtIndex:(NSUInteger) index withEvent:(NSEvent *) event;

- (void) imageBrowserSelectionDidChange:(IKImageBrowserView *) aBrowser;

@end
