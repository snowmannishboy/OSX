//
//  DirectoryViewController.h
//  ImageBrowser
//
//  Created by Robert Novak on 2/16/14.
//  Copyright (c) 2014 Robert Novak. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class DirectoryModel;

@interface DirectoryViewController : NSViewController

@property (strong, nonatomic) NSMutableArray* directories;
@property (strong, nonatomic) NSIndexSet* selectionIndexes;

@property (strong, nonatomic) IBOutlet NSArrayController* collectionController;
@property (strong, nonatomic) IBOutlet NSCollectionView* collectionView;

- (void) addDirectoriesObject:(DirectoryModel *)object;
- (void) addDirectories:(NSArray*) objects;

@end
