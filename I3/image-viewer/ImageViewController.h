//
//  ImageViewController.h
//  image-viewer
//
//  Created by Robert Novak on 2/5/14.
//  Copyright (c) 2014 Robert Novak. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ImageViewController : NSViewController

@property IBOutlet NSImageView* inner;
@property IBOutlet NSScrollView* scrollView;

- (void) setImage: (NSString*) img;
- (void) clearImage;

@end
