//
//  DirectoryItem.h
//  Images
//
//  Created by Robert Novak on 1/17/14.
//  Copyright (c) 2014 Robert Novak. All rights reserved.
//
#ifndef __DIRECTORY_ITEM__
#define __DIRECTORY_ITEM__
#import <Cocoa/Cocoa.h>
#include "ClickableBox.h"

@interface DirectoryItem : NSCollectionViewItem {
    
    __weak NSTextField *_filename;
    
    __weak ClickableBox* _box;
    
}

- (id) copyWithZone:(NSZone *)zone;

- (void) setRepresentedObject:(id)representedObject;

@property (weak) IBOutlet NSTextField *filename;

@property (weak) IBOutlet ClickableBox* box;

@end


#endif
