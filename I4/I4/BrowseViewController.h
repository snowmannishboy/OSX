//
//  BrowseViewController.h
//  I4
//
//  Created by Robert Novak on 2/9/14.
//  Copyright (c) 2014 Robert Novak. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <Quartz/Quartz.h>
#import "BrowserItem.h"

@interface BrowseViewController : NSViewController

@property (nonatomic, strong) NSMutableArray* images;
@property (nonatomic, strong) NSIndexSet* selectionIndexes;

@property (nonatomic, strong) IBOutlet IKImageBrowserView* imageBrowser;
@property (nonatomic, strong) IBOutlet NSView* inner;

- (void) addItem: (NSString*) path;
- (void) clear;
- (NSURL*) selectedImage;

@end
