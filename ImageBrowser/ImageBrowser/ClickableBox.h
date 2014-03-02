//
//  ClickableBox.h
//  ImageBrowser
//
//  Created by Robert Novak on 2/16/14.
//  Copyright (c) 2014 Robert Novak. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ClickableBox : NSBox

@property (strong, nonatomic) id represented;

+ (void) setAction:(SEL) action target: (id) target;

@end
