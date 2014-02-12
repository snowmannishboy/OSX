//
//  ImageViewController.h
//  I4
//
//  Created by Robert Novak on 2/9/14.
//  Copyright (c) 2014 Robert Novak. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ImageViewController : NSViewController

@property (atomic, strong) IBOutlet NSImageView* imageView;
@property (nonatomic, strong) IBOutlet NSScrollView* scrollView;

- (void) setImage: (NSURL*) url;
- (void) clearImage;
- (void) setMagnification: (CGFloat) zoomLevel;

@end
