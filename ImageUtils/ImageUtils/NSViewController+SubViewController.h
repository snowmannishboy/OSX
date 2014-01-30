//
//  NSViewController+SubViewController.h
//  ImageUtils
//
//  Created by Robert Novak on 1/28/14.
//  Copyright (c) 2014 Robert Novak. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NSViewController (SubViewController) {

}

- (void) addToSuper:(NSView*) superView;

@property IBOutlet NSView* inner;

@end
