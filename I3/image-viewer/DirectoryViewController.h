//
//  DirectoryViewController.h
//  image-viewer
//
//  Created by Robert Novak on 2/1/14.
//  Copyright (c) 2014 Robert Novak. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "DirectoryItemViewController.h"

@interface DirectoryViewController : NSViewController

@property NSMutableArray* directories;
@property NSIndexSet* selected;

@property IBOutlet NSArrayController* directoryController;
@property IBOutlet NSCollectionView* collectionView;


- (void) addItem: (id) path;
- (NSDictionary*) removeSelected;
- (BOOL) isItemSelected;

@end
