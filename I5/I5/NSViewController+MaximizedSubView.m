//
//  NSViewController+MaximizedSubView.m
//  I5
//
//  Created by Robert Novak on 2/10/14.
//  Copyright (c) 2014 Robert Novak. All rights reserved.
//

#import "NSViewController+MaximizedSubView.h"

@implementation NSViewController (MaximizedSubView)

- (void) add: (NSView*) parent {
    NSView* inner = [self view];
    NSView* outer = parent;
    
    [inner setTranslatesAutoresizingMaskIntoConstraints:NO];
    [inner setAutoresizingMask:NSViewWidthSizable|NSViewHeightSizable];
    
    [inner setFrame:[outer bounds]];
    
    [outer addSubview:inner];
    
    NSDictionary* views = NSDictionaryOfVariableBindings(inner, outer);
    
    [outer addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[inner]|" options:NSLayoutPriorityDefaultLow metrics:nil views:views]];
    [outer addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[inner]|" options:NSLayoutPriorityDefaultLow metrics:nil views:views]];
}

@end
