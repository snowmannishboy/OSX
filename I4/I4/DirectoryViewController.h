//
//  DirectoryViewController.h
//  I4
//
//  Created by Robert Novak on 2/9/14.
//  Copyright (c) 2014 Robert Novak. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "DirectoryModel.h"
#import "DirectoryItemViewController.h"

@interface DirectoryViewController : NSViewController

@property (nonatomic, strong) NSMutableArray* data;
@property (nonatomic, strong) NSIndexSet* selected;

@property (nonatomic, strong) IBOutlet NSView* inner;
@property (nonatomic, strong) IBOutlet NSCollectionView* collectionView;
@property (nonatomic, strong) IBOutlet NSArrayController* collectionViewController;


- (void) addItem: (DirectoryModel*) object;
- (DirectoryModel*) removeSelected;

@end
