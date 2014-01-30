//
//  ScrollableImage.m
//  gifs
//
//  Created by Robert Novak on 1/29/14.
//  Copyright (c) 2014 Robert Novak. All rights reserved.
//

#import "ScrollableImage.h"

static id<ScrollableImageDelegate> _controller;

@implementation ScrollableImage

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
    if (theEvent.clickCount >1l)
        [_controller esc:self];
}

- (void) scrollLineDown:(id)sender {
    [_controller nextImage];
}

- (void) scrollLineUp:(id)sender {
    [_controller previousImage];
}

+ (void) setController:(id<ScrollableImageDelegate>)controller {
    _controller = controller;
}

- (void) scrollWheel:(NSEvent *)theEvent {
    
    if (theEvent.deltaY > 0.0) {
        [_controller previousImage];
    }
    else {
        [_controller nextImage];
    }

}
@end
