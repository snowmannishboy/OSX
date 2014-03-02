//
//  MainController.h
//  ImageBrowser
//
//  Created by Robert Novak on 2/16/14.
//  Copyright (c) 2014 Robert Novak. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "NSViewController+MaximizedSubview.h"

@class DirectoryViewController;
@class DirectoryService;
@class BrowseViewController;
@class ImageViewController;

static const double BROWSE_ZOOM_FACTOR = 2.5;
static const double IMAGE_ZOOM_OFFSET = 0.75;

static const double DEFAULT_ZOOM_BROWSE = 0.40;
static const double DEFAULT_ZOOM_IMAGE = 0.25;

@interface MainController : NSWindowController<NSWindowDelegate> {
    enum STATE {
        browse,
        directory,
        image
    } state;
    
    NSRect __previous;
    
    double __previous_zoom;
}

@property (strong, nonatomic) IBOutlet NSView* contentView;

@property (strong, nonatomic) IBOutlet NSButton* back;
@property (strong, nonatomic) IBOutlet NSButton* add;
@property (strong, nonatomic) IBOutlet NSButton* remove;

@property (strong, nonatomic) IBOutlet NSSegmentedControl* navigate;

@property (strong, nonatomic) IBOutlet NSSlider* zoom;


@property (strong, nonatomic) DirectoryViewController* directoryController;
@property (strong, nonatomic) BrowseViewController* browseController;
@property (strong, nonatomic) ImageViewController* imageController;

@property (strong, nonatomic) DirectoryService* directoryService;

@property double zoomLevel;

- (IBAction)_back:(id)sender;
- (IBAction)_add:(id)sender;
- (IBAction)_remove:(id) sender;

- (IBAction)_navigate: (id) sender;

- (IBAction)_zoom: (id) sender;

- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context;

- (void) windowDidResize:(NSNotification *)notification;


@end
