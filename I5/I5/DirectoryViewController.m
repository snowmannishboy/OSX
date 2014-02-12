//
//  DirectoryViewController.m
//  I5
//
//  Created by Robert Novak on 2/10/14.
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
        if (topLevelObjects) {
            for (id  obj in topLevelObjects) {
                if ([obj isKindOfClass:[self class]])
                    return obj;
            }
        }
    }
    return self;
}

- (void) awakeFromNib {
    
    _content = [[NSMutableArray alloc] init];
    _selectedIndexes = [[NSIndexSet alloc] init];
    
    NSSize itemSize = NSMakeSize(180, 220);
    
    [_collection setMaxItemSize:itemSize];
    [_collection setMinItemSize:itemSize];
    
}

- (void) addItem:(id)obj {
    [_controller addObject:obj];
}

@end
