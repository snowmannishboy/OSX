//
//  DirectoryItemViewController.h
//  image-viewer
//
//  Created by Robert Novak on 2/3/14.
//  Copyright (c) 2014 Robert Novak. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ClickableBox.h"

@interface DirectoryItemViewController : NSCollectionViewItem

@property IBOutlet NSView* inner;
@property IBOutlet NSTextField* path;
@property IBOutlet ClickableBox* box;

@end
