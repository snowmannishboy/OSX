//
//  MainController.h
//  image-viewer
//
//  Created by Robert Novak on 2/3/14.
//  Copyright (c) 2014 Robert Novak. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "NSViewController+MaximizedView.h"
#import "DirectoryViewController.h"
#import "TagViewController.h"
#import "BrowseViewController.h"
#import "ImageViewController.h"


@interface MainController : NSWindowController<ClickableBoxDelegate, BrowserViewProtocol, TagItemProtocol, NSWindowDelegate> {
    
    enum _view_state {
        mcDirectory,
        mcTag,
        mcBrowse,
        mcImage
    };
    
    enum _view_state _state;
}

@property IBOutlet NSView* view;
@property IBOutlet NSButton* backButton;
@property IBOutlet NSButton* addButton;
@property IBOutlet NSButton* removeButton;
@property IBOutlet NSSegmentedControl* nav;
@property IBOutlet NSButton* viewMenu;
@property IBOutlet NSSlider* zoomSlider;

@property IBOutlet NSView* bottomBar;

@property DirectoryViewController* directoryController;
@property BrowseViewController* browseController;
@property ImageViewController* imageController;
@property TagViewController* tagController;
@property double zoomLevel;


- (IBAction) addButtonClicked: (id) sender;
- (IBAction) backButtonClicked: (id) sender;
- (IBAction) navigateClicked: (id) sender;
- (IBAction) tagMenuItemClicked:(id)sender;
- (IBAction) directoryMenuItemClicked: (id) sender;
- (IBAction) zoomLevelDidChange: (id) sender;
- (void) boxDoubleClicked:(id) sender;

@end
