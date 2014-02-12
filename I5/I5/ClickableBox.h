//
//  ClickableBox.h
//  I5
//
//  Created by Robert Novak on 2/10/14.
//  Copyright (c) 2014 Robert Novak. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ClickableBox : NSBox

@property (atomic, strong) id representedObject;

+ (void) setAction: (SEL) action target: (id) target;

@end
