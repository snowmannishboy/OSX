//
//  DirectoryItemViewController.h
//  gifs
//
//  Created by Robert Novak on 1/22/14.
//  Copyright (c) 2014 Robert Novak. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ClickableBox.h"

@interface DirectoryItemViewController : NSCollectionViewItem {
    
}


@property IBOutlet NSTextField* filename;
@property IBOutlet ClickableBox* box;

- (void) setRepresentedObject:(id)representedObject;


@end
