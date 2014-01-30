//
//  MainWindowController.m
//  ImageUtils
//
//  Created by Robert Novak on 1/26/14.
//  Copyright (c) 2014 Robert Novak. All rights reserved.
//

#import "MainWindowController.h"

@interface MainWindowController ()

@end

@implementation MainWindowController


- (id)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    if (self) {
        // Initialization code here.
    }
    return self;
}

- (void) awakeFromNib {
    NSLog(@"awake");
    
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}

@end
