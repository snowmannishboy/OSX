//
//  ClickableBox.m
//  gifs
//
//  Created by Robert Novak on 1/22/14.
//  Copyright (c) 2014 Robert Novak. All rights reserved.
//

#import "ClickableBox.h"

static id _controller;


@implementation ClickableBox

@synthesize directory = _directory;

- (id)initWithFrame:(NSRect)frame   {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect  {
	[super drawRect:dirtyRect];
	
    // Drawing code here.
}

- (void) mouseDown:(NSEvent *)theEvent {
    [super mouseDown:theEvent];
    if (theEvent.clickCount > 1l) {
        if (_controller && [_controller respondsToSelector:@selector(performClick:)])
            [_controller performClick: self];
    }
}

+ (void) setController: (id) controller {
    _controller = controller;
}

@end
