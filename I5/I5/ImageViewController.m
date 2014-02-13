//
//  ImageViewController.m
//  I5
//
//  Created by Robert Novak on 2/11/14.
//  Copyright (c) 2014 Robert Novak. All rights reserved.
//

#import "ImageViewController.h"

@interface ImageViewController ()

@end

static id _delegate;

@implementation ImageViewController

- (id) init {
    self = [super init];
    if (self) {
        NSArray* tl = nil;
        [[NSBundle mainBundle] loadNibNamed:@"ImageView" owner:self topLevelObjects:&tl];
        for (id obj in tl ) if ([obj isKindOfClass:[self class]]) return obj;
    }
    return self;
}

- (void) awakeFromNib {
    [[self view] setHidden:YES];
}

- (void) setImage:(NSURL *)url {
    [_imageView setImage:nil];
    NSImage* img = [[NSImage alloc] initWithContentsOfURL:url];
    [_imageView setImage: img];
}

- (void) clearImage {
    [_imageView setImage:nil];
}

+ (void) setDelegate:(id)delegate {
    _delegate = delegate;
}


@end


@interface DelegatingScrollView : NSScrollView
- (void) scrollWheel:(NSEvent *)theEvent;
@end

@implementation DelegatingScrollView

- (void) scrollWheel:(NSEvent *)theEvent {
    if (_delegate && [_delegate respondsToSelector:@selector(scrollWheel:)])
        [_delegate scrollWheel:theEvent];
    [super scrollWheel:theEvent];
}

@end

