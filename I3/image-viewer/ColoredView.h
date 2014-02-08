//
//  ColoredView.h
//  image-viewer
//
//  Created by Robert Novak on 2/4/14.
//  Copyright (c) 2014 Robert Novak. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ColoredView : NSView {
    NSColor* backgroundColor;
    NSColor* endColor;
}



- (id) initWithCoder:(NSCoder *)aDecoder;
- (void) setBackgroundColor:(NSColor*) color;
- (void) setEndColor: (NSColor*) color;
- (NSColor*) backgroundColor;
- (NSColor*) endColor;

@end
