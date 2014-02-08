//
//  NSViewController+MaximizedView.m
//  image-viewer
//
//  Created by Robert Novak on 2/3/14.
//  Copyright (c) 2014 Robert Novak. All rights reserved.
//

#import "NSViewController+MaximizedView.h"

@implementation NSViewController (MaximizedView)
- (void) addToSuper: (NSView*) parent {
    if (parent == nil) return;
    
    NSView* inner = [self view];
    NSView* outer = parent;
    
    [inner setFrame:[outer bounds]];
    
    [inner setAutoresizingMask:NSViewWidthSizable|NSViewHeightSizable];
    [inner setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [outer addSubview:inner];
    
    [outer addConstraint: [NSLayoutConstraint constraintWithItem:outer attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:inner attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0]];
    
    [outer addConstraint: [NSLayoutConstraint constraintWithItem:outer attribute:NSLayoutAttributeWidth relatedBy: NSLayoutRelationEqual toItem: inner attribute: NSLayoutAttributeWidth multiplier:1.0 constant: 0]];
    
    
}
@end
