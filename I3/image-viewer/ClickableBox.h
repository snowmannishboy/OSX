//
//  ClickableBox.h
//  image-viewer
//
//  Created by Robert Novak on 2/3/14.
//  Copyright (c) 2014 Robert Novak. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@protocol ClickableBoxDelegate <NSObject>

- (void) boxDoubleClicked:(id) sender;

@end

@interface ClickableBox : NSBox

@property NSString* path;

+ (void) setDelegate:(id<ClickableBoxDelegate>) delegate;

@end
