//
//  NSViewController+MaximizedSubview.m
//  ImageBrowser
//
//  Created by Robert Novak on 2/16/14.
//  Copyright (c) 2014 Robert Novak. All rights reserved.
//

#import "NSViewController+MaximizedSubview.h"

@implementation NSViewController (MaximizedSubview)

- (void) maximizeInParent:(NSView *)parent {
    NSView* inner = [self view];
    NSView* outer = parent;
    
    [inner setFrame:[outer bounds]];

    [inner setTranslatesAutoresizingMaskIntoConstraints:NO];
    [inner setAutoresizingMask:NSViewHeightSizable|NSViewWidthSizable];
    
    [outer addSubview:inner];
    
    [outer addConstraint:[NSLayoutConstraint constraintWithItem:inner attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:outer attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0.0]];
    
    [outer addConstraint:[NSLayoutConstraint constraintWithItem:inner attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:outer attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0.0]];
    
}

@end
