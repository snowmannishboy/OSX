//
//  ClickableBox.m
//  I4
//
//  Created by Robert Novak on 2/9/14.
//  Copyright (c) 2014 Robert Novak. All rights reserved.
//

#import "ClickableBox.h"

static SEL _action;
static id  _target;

@implementation ClickableBox

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
	[super drawRect:dirtyRect];
	
}

- (void) mouseDown:(NSEvent *)theEvent {
    [super mouseDown:theEvent];
    if (theEvent.clickCount > 1l) {
        IMP imp = [_target methodForSelector:_action];
        void (*func)(id, SEL, id) = (void*) imp;
        func(_target, _action, self);
    }
}

+ (void) setAction:(SEL)selector target:(id)target {
    _target = target;
    _action = selector;
}

@end
