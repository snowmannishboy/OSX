//
//  DirectoryViewController.m
//  I4
//
//  Created by Robert Novak on 2/9/14.
//  Copyright (c) 2014 Robert Novak. All rights reserved.
//

#import "DirectoryViewController.h"

@interface DirectoryViewController ()

@end

@implementation DirectoryViewController

- (id) init {
    self = [super init];
    if (self) {
        NSArray* topLevelObjects = nil;
        [[NSBundle mainBundle] loadNibNamed:@"DirectoryView" owner:self topLevelObjects:&topLevelObjects];
    }
    return self;
}

- (void) awakeFromNib {
    
    [[self view] setHidden:YES];
    
    _data = [[NSMutableArray alloc] init];
    _selected = [[NSIndexSet alloc] init];
    
    NSSize itemSize = NSMakeSize(180, 200);
    
    [_collectionView setMaxItemSize:itemSize];
    [_collectionView setMinItemSize:itemSize];
    
}

- (void) addItem:(DirectoryModel *)object {
    
    if (!object) return;
    [[object url] startAccessingSecurityScopedResource];
    [_collectionViewController addObject:object];
    
}

- (DirectoryModel*) removeSelected {
    NSUInteger currentIndex = [_selected firstIndex];
    if (currentIndex != NSNotFound) {
        DirectoryModel* result = [_data objectAtIndex:currentIndex];
        
        [[result url] stopAccessingSecurityScopedResource];
        
        [_collectionViewController removeObject:result];
        
        return result;
    }
    return nil;
}



@end
