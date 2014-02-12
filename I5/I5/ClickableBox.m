//
//  ClickableBox.m
//  I5
//
//  Created by Robert Novak on 2/10/14.
//  Copyright (c) 2014 Robert Novak. All rights reserved.
//

#import "ClickableBox.h"

static id _target;
static SEL _action;
static void (*actionCall)(id, SEL, id);

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

}

- (void) mouseDown:(NSEvent *)theEvent {
    [super mouseDown:theEvent];
    if (theEvent.clickCount > 1l) {
        if (actionCall && _target && _action) {
            actionCall(_target, _action, self);
        }
    }
}

+ (void) setAction:(SEL)action target:(id)target {
    if (action && target) {
        _target = target;
        _action = action;
        IMP implemented = [target methodForSelector:action];
        actionCall = (void*) implemented;
    }
}


@end
