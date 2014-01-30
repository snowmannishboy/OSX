//
//  DirectoryViewController.h
//  gifs
//
//  Created by Robert Novak on 1/22/14.
//  Copyright (c) 2014 Robert Novak. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "DirectoryService.h"

@interface DirectoryViewController : NSViewController {

    NSMutableArray* _directories;
    NSMutableArray* _selected;
    
}


- (void) add: (NSView*) superView;

- (IBAction)deleteButtonClicked:(id)sender;

- (void) addObject:(id) obj;

@property IBOutlet NSView* outter;
@property IBOutlet NSView* inner;
@property IBOutlet NSCollectionView* directoryView;
@property IBOutlet NSArrayController* directoryController;
@property IBOutlet NSButton* addButton;

@property id directories;
@property id selected;
@property DirectoryService* directoryService;

@end
