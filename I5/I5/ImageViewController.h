//
//  ImageViewController.h
//  I5
//
//  Created by Robert Novak on 2/11/14.
//  Copyright (c) 2014 Robert Novak. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ImageViewController : NSViewController


@property (nonatomic, strong) IBOutlet NSView* inner;
@property (nonatomic, strong) IBOutlet NSImageView* imageView;
@property (nonatomic, strong) IBOutlet NSScrollView* scrollView;

- (void) setImage: (NSURL*) url;
- (void) clearImage;

@end
