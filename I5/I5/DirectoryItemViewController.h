//
//  DirectoryItemViewController.h
//  I5
//
//  Created by Robert Novak on 2/10/14.
//  Copyright (c) 2014 Robert Novak. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class ClickableBox;

@interface DirectoryItemViewController : NSCollectionViewItem

@property (atomic, strong) IBOutlet NSTextField* name;
@property (atomic, strong) IBOutlet ClickableBox* box;

- (id) copyWithZone:(NSZone *)zone;
- (void) setRepresentedObject:(id)representedObject;

@end
