//
//  ClickableBox.h
//  gifs
//
//  Created by Robert Novak on 1/22/14.
//  Copyright (c) 2014 Robert Novak. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "MainController.h"

@interface ClickableBox : NSBox {
    
}


@property NSString* directory;

+ (void) setController: (id) controller;

@end
