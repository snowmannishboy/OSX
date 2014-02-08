//
//  ClickableBox.m
//  Images
//
//  Created by Robert Novak on 1/18/14.
//  Copyright (c) 2014 Robert Novak. All rights reserved.
//

#import "ClickableBox.h"

static id mainController;

@implementation ClickableBox

@synthesize directory = _directory;

- (id)initWithFrame:(NSRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect{
	[super drawRect:dirtyRect];
	
    // Drawing code here.
}


- (void) mouseDown:(NSEvent *)theEvent {
    [super mouseDown:theEvent];
    if (theEvent.clickCount > 1l) {
        if (mainController && [mainController respondsToSelector:@selector(performClick:)]) {
            [mainController performClick:self];
        }
    }
}


+ (void) setMainController:(id)controller {
    mainController = controller;
}


@end
