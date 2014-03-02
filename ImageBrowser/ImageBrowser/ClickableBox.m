//
//  ClickableBox.m
//  ImageBrowser
//
//  Created by Robert Novak on 2/16/14.
//  Copyright (c) 2014 Robert Novak. All rights reserved.
//

#import "ClickableBox.h"

static id _target;
static SEL _action;
static void (*callable)(id, SEL, id);

@implementation ClickableBox

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
	[super drawRect:dirtyRect];
	
    // Drawing code here.
}


- (void) mouseDown:(NSEvent *)theEvent {
    [super mouseDown:theEvent];
    if (theEvent.clickCount > 1l && callable)
        callable(_target, _action, self);
}

+ (void) setAction:(SEL)action target:(id)target {
    if (action && target) {
        _target = target;
        _action = action;
        IMP i = [target methodForSelector:action];
        callable = (void*) i;
    }
}

@end
