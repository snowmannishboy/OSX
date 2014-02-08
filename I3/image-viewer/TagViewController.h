//
//  TagViewController.h
//  image-viewer
//
//  Created by Robert Novak on 2/6/14.
//  Copyright (c) 2014 Robert Novak. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "TagItemViewController.h"

@interface TagViewController : NSViewController


@property IBOutlet NSView* inner;
@property IBOutlet NSArrayController* tagController;
@property IBOutlet NSCollectionView* tagCollection;

@property NSMutableArray* tags;
@property NSIndexSet* selectedTags;

- (void) addObject: (id) obj;

@end
