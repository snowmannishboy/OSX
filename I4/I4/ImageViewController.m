//
//  ImageViewController.m
//  I4
//
//  Created by Robert Novak on 2/9/14.
//  Copyright (c) 2014 Robert Novak. All rights reserved.
//

#import "ImageViewController.h"

@interface ImageViewController ()

@end

@implementation ImageViewController

- (id) init {
    self = [super init];
    if (self) {
        NSArray* topLevelObjects = nil;
        [[NSBundle mainBundle] loadNibNamed:@"ImageView" owner:self topLevelObjects:&topLevelObjects];
    }
    return self;
}

- (void) awakeFromNib {
    [[self view] setHidden:YES];
}

- (void) setImage:(NSURL *)url {
    NSImage* img = [[NSImage alloc] initWithContentsOfURL:url];
    [_imageView setImage:img];
    [_imageView setImageScaling:NSImageScaleProportionallyDown];
}

- (void) clearImage {
    [_imageView setImage:nil];
}

- (void) setMagnification:(CGFloat)zoomLevel {
    [_scrollView setMagnification:zoomLevel];
}

@end
