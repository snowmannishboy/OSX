//
//  ColoredView.m
//  image-viewer
//
//  Created by Robert Novak on 2/4/14.
//  Copyright (c) 2014 Robert Novak. All rights reserved.
//

#import "ColoredView.h"

@implementation ColoredView

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        backgroundColor = [NSColor controlBackgroundColor];
        endColor = [NSColor whiteColor];
    }
    return self;
}

- (id) initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    backgroundColor = [aDecoder decodeObjectForKey:@"backgroundColor"];
    endColor = [aDecoder decodeObjectForKey:@"endColor"];
    return self;
}

- (void) encodeWithCoder:(NSCoder *)aCoder {
    [super encodeWithCoder:aCoder];
    [aCoder encodeObject:backgroundColor forKey:@"backgroundColor"];
    [aCoder encodeObject:endColor forKey:@"endColor"];
}

- (void)drawRect:(NSRect)dirtyRect
{

	[super drawRect:dirtyRect];
    [self lockFocus];
    NSGradient* gradient = [[NSGradient alloc] initWithStartingColor:backgroundColor endingColor:endColor];

    [gradient drawInRect:[self bounds] angle:90.0];
    [self unlockFocus];
}

- (void) setBackgroundColor: (NSColor*) aColor {
    if (aColor != backgroundColor) {
        backgroundColor = nil;
        backgroundColor = aColor;
        [self setNeedsDisplay:YES];
    }
}

- (void) setEndColor: (NSColor*) aColor {
    if (aColor != endColor) {
        endColor = nil;
        endColor = aColor;
        [self setNeedsDisplay:YES];
    }
}

- (NSColor*) backgroundColor {
    return backgroundColor;
}

- (NSColor*) endColor {
    return endColor;
}



@end
