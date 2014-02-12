//
//  BrowseViewController.m
//  I4
//
//  Created by Robert Novak on 2/9/14.
//  Copyright (c) 2014 Robert Novak. All rights reserved.
//

#import "BrowseViewController.h"

@interface BrowseViewController ()

@end

@implementation BrowseViewController

- (id) init {
    self = [super init];
    if (self) {
        NSArray* topLevelObjects = nil;
        [[NSBundle mainBundle] loadNibNamed:@"BrowseView" owner:self topLevelObjects:&topLevelObjects];
    }
    return self;
}

- (void) awakeFromNib {
    [[self view] setHidden:YES];
    _images = [[NSMutableArray alloc] init];
    _selectionIndexes = [[NSIndexSet alloc] init];
}

- (void) addItem:(NSString *)path {
    if (!path) return;
    
    BrowserItem* item = [[BrowserItem alloc] initWithPath:path];
    [_images addObject:item];
    [_imageBrowser reloadData];
}

- (void) clear {
    [_images removeAllObjects];
    [_imageBrowser reloadData];
}

- (NSURL*) selectedImage {
    NSUInteger current = [_selectionIndexes firstIndex];
    if (current == NSNotFound) return nil;
    BrowserItem* item = [_images objectAtIndex:current];
    return [item path];
}

- (id) imageBrowser:(IKImageBrowserView *)aBrowser itemAtIndex:(NSUInteger)index {
    return [_images objectAtIndex:index];
}

- (NSUInteger) numberOfItemsInImageBrowser:(IKImageBrowserView *)aBrowser {
    return [_images count];
}


@end
