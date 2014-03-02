//
//  NSViewController+MaximizedSubViewController.m
//  Image Browser
//
//  Created by Robert Novak on 2/25/14.
//  Copyright (c) 2014 Robert Novak. All rights reserved.
//

#import "NSViewController+MaximizedSubViewController.h"

@implementation NSViewController (MaximizedSubViewController)

- (void) addToSuper:(NSView *)parent {
    @autoreleasepool {
        NSView* inner = [self view];
        NSView* outer = parent;
        
        [inner setTranslatesAutoresizingMaskIntoConstraints:NO];
        [inner setAutoresizingMask:NSViewHeightSizable|NSViewWidthSizable];
        
        [inner setFrame: [outer bounds]];
        
        [outer addSubview:inner];
        
        NSDictionary* dict = NSDictionaryOfVariableBindings(inner, outer);
        
        [outer addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[inner]|" options:NSLayoutFormatAlignAllCenterX metrics:nil views:dict]];
        
        [outer addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[inner]|" options:NSLayoutFormatAlignAllCenterY metrics:nil views:dict]];
    }
}

@end
