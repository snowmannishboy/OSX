//
//  ClickableBox.h
//  I4
//
//  Created by Robert Novak on 2/9/14.
//  Copyright (c) 2014 Robert Novak. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@protocol ClickableBoxDelegate <NSObject>

- (void) __doubleClicked: (id) sender;

@end

@interface ClickableBox : NSBox

@property id representation;

+ (void) setAction: (SEL) selector target: (id) target;
@end
