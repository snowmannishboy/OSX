//
//  ImageViewController.m
//  image-viewer
//
//  Created by Robert Novak on 2/5/14.
//  Copyright (c) 2014 Robert Novak. All rights reserved.
//

#import "ImageViewController.h"

@interface ImageViewController ()

@end

static id _delegate;

@implementation ImageViewController

@synthesize inner = _inner;
@synthesize scrollView = _scrollView;

- (id) init {
    self = [super init];
    if (self) {
        NSArray* topLevelObjects = nil;
        [[NSBundle mainBundle] loadNibNamed:@"ImageView" owner:self topLevelObjects:&topLevelObjects];
    }
    return self;
}

- (void) setImage:(NSString *)img {
    [_inner setImage:nil];
    NSImage* newImage = [[NSImage alloc] initWithContentsOfFile:img];
    if (newImage != nil) [_inner setImage:newImage];
    [_inner setAnimates:YES];
    [_inner setImageScaling:NSImageScaleProportionallyDown];
    [_scrollView setMagnification:1.0];
}


- (void) awakeFromNib {
    [[self view] setHidden:YES];
}

- (void) clearImage {
    [_inner setImage:nil];
}

- (void) toggleExpand {
    if ([_inner imageScaling] == NSImageScaleProportionallyDown) [_inner setImageScaling:NSImageScaleProportionallyUpOrDown];
    else [_inner setImageScaling:NSImageScaleProportionallyDown];
}

+ (void) setDelegate:(id)delegate {
    _delegate = delegate;
}

@end



@interface DelegatingScrollView : NSScrollView
- (BOOL) acceptsFirstResponder;
@end


@implementation DelegatingScrollView
- (id) init { self = [super init]; return self; }
- (BOOL) acceptsFirstResponder { return NO; }
- (void) scrollWheel:(NSEvent *)theEvent { }
@end

@interface DelegatingImageView : NSImageView
- (BOOL) acceptsFirstResponder;
- (void) scrollWheel:(NSEvent *)theEvent;
@end

@implementation DelegatingImageView

- (BOOL) acceptsFirstResponder { return NO; }
- (void) scrollWheel:(NSEvent *)theEvent {[_delegate scrollWheel:theEvent];}
@end
















