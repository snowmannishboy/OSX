//
//  ImageViewController.m
//  gifs
//
//  Created by Robert Novak on 1/23/14.
//  Copyright (c) 2014 Robert Novak. All rights reserved.
//

#import "ImageViewController.h"

@interface ImageViewController ()

@end

@implementation ImageViewController

@synthesize inner = _inner;
@synthesize outer = _outer;
@synthesize controller = _controller;
@synthesize currentImage = _currentImage;

- (id) init {
    self = [super init];
    NSArray* topLevelObjects = [NSArray arrayWithObjects:_inner, nil];
    [[NSBundle mainBundle] loadNibNamed:@"ImageView" owner:self topLevelObjects:&topLevelObjects];
    return self;
}

- (void) changeImage:(id)sender {
    
    NSSegmentedControl* control = (NSSegmentedControl*) sender;
    
    NSInteger selected = [control selectedSegment];
    
    NSString* newPath;
    
    newPath = selected == 1 ? [_controller nextImage] : [_controller previousImage];
    
    if (newPath != nil) {
        _currentImage = nil;
        _currentImage = [[NSImage alloc] initWithContentsOfFile:newPath];
        [_imageView setImage:nil];
        [_imageView setImage:_currentImage];
    }
    
}

- (void) awakeFromNib {
    [_inner setHidden:YES];
}

- (void) setImage:(NSString*) path {
    _currentImage = nil;
    _currentImage = [[NSImage alloc] initWithContentsOfFile:path];
    [_imageView setImage:_currentImage];
    [_imageView setAnimates:YES];
}

- (void) removeImage {
    _currentImage = nil;
    [_imageView setImage:nil];
    
}

- (void) add:(NSView *)superView {
    
    _outer = superView;
    
    [_inner setFrame: [_outer bounds]];
    
    [_inner setAutoresizesSubviews:YES];
    [_inner setAutoresizingMask:NSViewWidthSizable|NSViewHeightSizable];
    [_inner setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [_outer addSubview:_inner];
    
    [_outer addConstraint:[NSLayoutConstraint constraintWithItem:_outer attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:_inner attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0]];
    
    [_outer addConstraint: [NSLayoutConstraint constraintWithItem:_outer attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem: _inner attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0]];
    
}

- (void) esc: (id) sender {
    [self removeImage];
    [_controller esc:sender];
}

@end
