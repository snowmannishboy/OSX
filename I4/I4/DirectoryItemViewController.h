//
//  DirectoryItemViewController.h
//  I4
//
//  Created by Robert Novak on 2/9/14.
//  Copyright (c) 2014 Robert Novak. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ClickableBox.h"

@interface DirectoryItemViewController : NSCollectionViewItem

@property (nonatomic, assign) IBOutlet ClickableBox* box;
@property (nonatomic, strong) IBOutlet NSTextField* name;

- (void) setRepresentedObject:(id)representedObject;

@end
