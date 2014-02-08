//
//  DirectoryViewController.m
//  image-viewer
//
//  Created by Robert Novak on 2/1/14.
//  Copyright (c) 2014 Robert Novak. All rights reserved.
//

#import "DirectoryViewController.h"

@interface DirectoryViewController ()

@end

@implementation DirectoryViewController

@synthesize directories = _directories;
@synthesize selected = _selected;
@synthesize directoryController = _directoryController;
@synthesize collectionView = _collectionView;

- (id) init {
    self = [super init];
    if (self) {
        NSArray* topLevelObjects = [NSArray arrayWithObjects: nil];
        [[NSBundle mainBundle] loadNibNamed:@"DirectoryView" owner:self topLevelObjects:&topLevelObjects];
    }
    return self;
}

- (void) awakeFromNib {
    _directories = [[NSMutableArray alloc] init];
    _selected = [[NSIndexSet alloc] init];
    
    NSSize max = NSMakeSize(181, 234);
    
    [_collectionView setMinItemSize:max];
    [_collectionView setMaxItemSize:max];
    
}

- (void) addItem:(NSString *)path {
    NSDictionary* newItem = [NSDictionary dictionaryWithObjectsAndKeys:path, @"path", nil];
    [_directoryController addObject:newItem];
}

@end
