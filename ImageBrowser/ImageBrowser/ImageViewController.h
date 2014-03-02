//
//  ImageViewController.h
//  ImageBrowser
//
//  Created by Robert Novak on 2/16/14.
//  Copyright (c) 2014 Robert Novak. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ImageViewController : NSViewController


@property (strong, atomic) IBOutlet NSImageView* imageView;
@property (strong, nonatomic) IBOutlet NSScrollView* scrollView;

- (void) clearImage;
- (void) setImage:(NSString*) path;
- (void) setMagnification: (CGFloat) magnification;
- (void) scrollToCenter;

@end

@interface DelegatedScrollView : NSScrollView
+ (void) setAction: (SEL) action target: (id) target;
@end