//
//  TagViewController.m
//  image-viewer
//
//  Created by Robert Novak on 2/6/14.
//  Copyright (c) 2014 Robert Novak. All rights reserved.
//

#import "TagViewController.h"

@interface TagViewController ()

@end

@implementation TagViewController

    // IBOutlets
@synthesize inner = _inner;
@synthesize tagController = _tagController;
@synthesize tagCollection = _tagCollection;

    // Regular Properties
@synthesize tags = _tags;
@synthesize selectedTags = _selectedTags;

- (id) init {
    self = [super init];
    if (self) {
        NSArray* topLevelObjects = nil;
        [[NSBundle mainBundle] loadNibNamed:@"TagView" owner:self topLevelObjects:&topLevelObjects];
    }
    return self;
}

- (void) awakeFromNib {
    [[self view] setHidden:YES];
    _tags = [[NSMutableArray alloc] init];
    _selectedTags = [[NSIndexSet alloc] init];
    
    NSSize representationSize = NSMakeSize(130, 160);
    
    [_tagCollection setMinItemSize:representationSize];
    [_tagCollection setMaxItemSize:representationSize];
}

- (void) addObject: (id) object {
    [_tagController addObject:object];
}

@end
