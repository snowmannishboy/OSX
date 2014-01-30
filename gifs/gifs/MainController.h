//
//  MainController.h
//  gifs
//
//  Created by Robert Novak on 1/21/14.
//  Copyright (c) 2014 Robert Novak. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "DirectoryViewController.h"
#import "BrowseViewController.h"
#import "ImageViewController.h"


#define ADD_BUTTON_INDEX 0
#define TRASH_BUTTON_INDEX 2

#define BACK_BUTTON_INDEX 0

@interface MainController : NSWindowController<BrowseViewControllerProtocol, ImageViewProtocol>


@property IBOutlet NSWindow* mainWindow;
@property IBOutlet NSView* contentView;
@property IBOutlet DirectoryService* directoryService;

@property DirectoryViewController* directoryViewController;
@property BrowseViewController* browseViewcontroller;
@property ImageViewController* imageViewController;


- (void) performClick: (id) sender;

- (void) backClick:(id)sender;

- (void) esc: (id) sender;

- (void) selectImage:(id)sender;

- (NSString*) nextImage;

- (NSString*) previousImage;


@end
