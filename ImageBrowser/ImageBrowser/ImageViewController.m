//
//  ImageViewController.m
//  ImageBrowser
//
//  Created by Robert Novak on 2/16/14.
//  Copyright (c) 2014 Robert Novak. All rights reserved.
//

#import "ImageViewController.h"



@interface ImageViewController ()

@end

@implementation ImageViewController



- (id) init {
    self = [super init];
    if (self) {
        NSArray* tlo;
        [[NSBundle mainBundle] loadNibNamed:@"ImageView" owner:self topLevelObjects:&tlo];
        for (id obj in tlo) if ([obj isKindOfClass:[self class]]) return obj;
    }
    return self;
}
 
 
- (void) awakeFromNib {
    [_imageView setAlphaValue:0.0];
}

- (void) setImage:(NSString*) path {
    [_imageView setImage:nil];
    NSImage* img = [[NSImage alloc] initWithContentsOfFile:path];
    [_imageView setImage:img];
    [[NSAnimationContext currentContext] setDuration:0.6];
    [[_imageView animator] setAlphaValue:1.0];
}

- (void) clearImage {
    [_imageView setImage:nil];
    [_imageView drawRect:[_imageView bounds]];
    [[self view] drawRect:[[self view] bounds]];
    [[_imageView animator] setAlphaValue:0.0];
}

- (void) setMagnification:(CGFloat)magnification {
    [[_scrollView animator] setMagnification:magnification];
}

- (void) scrollToCenter {
    NSRect imageBounds = [_imageView bounds];
    
    NSRect scrollBounds = [_scrollView documentVisibleRect];
    
    double x = (imageBounds.size.width - scrollBounds.size.width) / 2;
    
    double y = (imageBounds.size.height - scrollBounds.size.height) / 2;
    
    [[_scrollView documentView] scrollPoint:NSMakePoint(x, y)];
}


@end


static id _target;
static SEL _action;
static void (*callable)(id, SEL, id);


@implementation DelegatedScrollView

- (void) scrollWheel:(NSEvent *)theEvent {
    if (_target && _action && callable) {
        callable(_target, _action, theEvent);
    }
}

+ (void) setAction:(SEL)action target:(id)target {
    if (action && target && ([target respondsToSelector:action])) {
        IMP i = [target methodForSelector:action];
        callable = (void*) i;
        _target = target;
        _action = action;
    }
}

@end






