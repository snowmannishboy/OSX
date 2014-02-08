//
//  ClickableBox.m
//  image-viewer
//
//  Created by Robert Novak on 2/3/14.
//  Copyright (c) 2014 Robert Novak. All rights reserved.
//

#import "ClickableBox.h"

static id<ClickableBoxDelegate> _delegate;

@implementation ClickableBox

@synthesize path = _path;

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

+ (void) setDelegate:(id<ClickableBoxDelegate>)delegate {
    _delegate = delegate;
}

- (void) mouseDown:(NSEvent *)theEvent {
    [super mouseDown:theEvent];
    if (theEvent.clickCount > 1l) {
        [_delegate boxDoubleClicked:self];
    }
}

@end
