//
//  DirectoryViewController.m
//  ImageBrowser
//
//  Created by Robert Novak on 2/16/14.
//  Copyright (c) 2014 Robert Novak. All rights reserved.
//

#import "DirectoryViewController.h"
#import "DirectoryModel.h"

@interface DirectoryViewController ()

@end


@implementation DirectoryViewController



- (id) init {
    self = [super init];
    if (self) {
        NSArray* tlo;
        [[NSBundle mainBundle] loadNibNamed:@"DirectoryView" owner:self topLevelObjects:&tlo];
        for (id obj in tlo) if ([obj isKindOfClass:[self class]]) return obj;
    }
    return self;
}


- (void) awakeFromNib {
    _directories = [[NSMutableArray alloc] init];
    _selectionIndexes = [[NSIndexSet alloc] init];
    
    NSSize defaultSize = NSMakeSize(200.0, 220.0);
    
    [_collectionView setMaxItemSize:defaultSize];
    [_collectionView setMinItemSize:defaultSize];
}

- (void) _addDirectoriesObject: (DirectoryModel*) object {
    if (object) {
        [_collectionController addObject:object];
    }
}

- (void) addDirectoriesObject:(DirectoryModel *)object {
    if ([NSThread isMainThread]) {
        [self _addDirectoriesObject:object];
    }
    else {
        [self performSelectorOnMainThread:@selector(_addDirectoriesObject:) withObject:object waitUntilDone:NO];
    }
}

- (void) addDirectories:(NSArray *)objects {
    [_collectionController addObjects:objects];
}

@end
