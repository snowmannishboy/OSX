//
//  ImageViewController.h
//  gifs
//
//  Created by Robert Novak on 1/23/14.
//  Copyright (c) 2014 Robert Novak. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <Quartz/Quartz.h>
#import "ScrollableImage.h"

@protocol ImageViewProtocol
- (void) esc: (id) sender;
- (NSString*) nextImage;
- (NSString*) previousImage;
@end

@interface ImageViewController : NSViewController<ScrollableImageDelegate> {

}

@property NSView* outer;
@property id<ImageViewProtocol> controller;
@property NSImage* currentImage;

@property IBOutlet NSView* inner;
@property IBOutlet NSImageView* imageView;
@property IBOutlet NSButton* backButton;
@property IBOutlet NSSegmentedControl* nav;

- (IBAction)esc:(id)sender;
- (IBAction)changeImage:(id)sender;

- (void) add: (NSView*) superView;
- (void) setImage: (NSString*) path;
- (void) removeImage;

- (void) nextImage;
- (void) previousImage;


@end
