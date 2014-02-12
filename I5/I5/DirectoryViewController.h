//
//  DirectoryViewController.h
//  I5
//
//  Created by Robert Novak on 2/10/14.
//  Copyright (c) 2014 Robert Novak. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface DirectoryViewController : NSViewController

@property (atomic, strong) NSMutableArray   *content;
@property (atomic, strong) NSIndexSet       *selectedIndexes;

@property (nonatomic, strong) IBOutlet NSView               *inner;
@property (nonatomic, strong) IBOutlet NSCollectionView     *collection;
@property (nonatomic, strong) IBOutlet NSArrayController    *controller;

- (void) addItem: (id) obj;

@end
