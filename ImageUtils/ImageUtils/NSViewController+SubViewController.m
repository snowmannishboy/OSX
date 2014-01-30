//
//  NSViewController+SubViewController.m
//  ImageUtils
//
//  Created by Robert Novak on 1/28/14.
//  Copyright (c) 2014 Robert Novak. All rights reserved.
//

#import "NSViewController+SubViewController.h"

@implementation NSViewController (SubViewController)

@dynamic inner;

- (void) addToSuper:(NSView *)superView {
    
    if (superView == nil) return;
    
    NSView* sub = [self inner];
    
    [superView addSubview:sub];
    
}


@end
