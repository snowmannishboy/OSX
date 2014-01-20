//
//  ClickableBox.h
//  Images
//
//  Created by Robert Novak on 1/18/14.
//  Copyright (c) 2014 Robert Novak. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface ClickableBox : NSBox {

    NSString* _directory;

    id _delegate;
    
}


@property NSString* directory;

@property IBOutlet id delegate;

+ (void) setMainController: (id) controller;

@end
