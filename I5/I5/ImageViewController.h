//
//  ImageViewController.h
//  I5
//
//  Created by Robert Novak on 2/11/14.
//  Copyright (c) 2014 Robert Novak. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class MainWindowController;

@interface ImageViewController : NSViewController

@property (atomic, strong) IBOutlet NSView* inner;
@property (atomic, strong) IBOutlet NSImageView* imageView;
@property (atomic, strong) IBOutlet NSScrollView* scrollView;

- (void) setImage: (NSURL*) url;
- (void) clearImage;

+ (void) setDelegate: (id) delegate;

@end
