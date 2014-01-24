//
//  BrowseViewDelegate.m
//  gifs
//
//  Created by Robert Novak on 1/23/14.
//  Copyright (c) 2014 Robert Novak. All rights reserved.
//

#import "BrowseViewDelegate.h"

@implementation BrowseViewDelegate

- (void)setMainController:(id)controller {
}

- (void) imageBrowser:(IKImageBrowserView *) aBrowser backgroundWasRightClickedWithEvent:(NSEvent *) event {
    
}

- (void) imageBrowser:(IKImageBrowserView *) aBrowser cellWasDoubleClickedAtIndex:(NSUInteger) index {
    [_controller doubleClick:index];
}

- (void) imageBrowser:(IKImageBrowserView *) aBrowser cellWasRightClickedAtIndex:(NSUInteger) index withEvent:(NSEvent *) event {
    
}

- (void) imageBrowserSelectionDidChange:(IKImageBrowserView *) aBrowser {
    
}

@end
