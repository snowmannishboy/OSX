//
//  NSViewController+MaximizedInSuper.m
//  I4
//
//  Created by Robert Novak on 2/9/14.
//  Copyright (c) 2014 Robert Novak. All rights reserved.
//

#import "NSViewController+MaximizedInSuper.h"

@implementation NSViewController (MaximizedInSuper)

- (void) maximizeViewInParent: (NSView*) parent {
    NSView* inner = [self view];
    NSView* outer = parent;
    
    [inner setTranslatesAutoresizingMaskIntoConstraints:NO];
    [inner setAutoresizingMask:NSViewWidthSizable|NSViewHeightSizable];
    
    [inner setFrame: [outer bounds]];
    
    [outer addSubview:inner];
    /*
    [outer addConstraint:[NSLayoutConstraint constraintWithItem:inner attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:outer attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0]];
    
    [outer addConstraint:[NSLayoutConstraint constraintWithItem:inner attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:outer attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0]];
    */
    
    NSDictionary* dictionary = NSDictionaryOfVariableBindings(inner, outer);

    [outer addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[inner]|" options:NSLayoutPriorityDefaultLow metrics:nil views:dictionary]];
    [outer addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[inner]|" options:NSLayoutPriorityDefaultLow metrics:nil views:dictionary]];
    
}

@end
