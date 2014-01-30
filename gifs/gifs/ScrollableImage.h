//
//  ScrollableImage.h
//  gifs
//
//  Created by Robert Novak on 1/29/14.
//  Copyright (c) 2014 Robert Novak. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@protocol ScrollableImageDelegate <NSObject>
- (NSString*) nextImage;
- (NSString*) previousImage;
@end

@interface ScrollableImage : NSImageView

- (void) scrollLineUp:(id)sender;
- (void) scrollLineDown:(id)sender;

- (void) scrollWheel:(NSEvent *)theEvent;

+ (void) setController: (id<ScrollableImageDelegate>) controller;

@end
