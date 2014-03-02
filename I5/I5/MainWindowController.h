//
//  MainWindowController.h
//  I5
//
//  Created by Robert Novak on 2/10/14.
//  Copyright (c) 2014 Robert Novak. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "NSObject+ActionableObject.h"
#import "NSViewController+MaximizedSubView.h"


const static double DEFAULT_ZOOM_IMAGES = 1.00;
const static double DEFAULT_ZOOM_BROWSE = 0.45;

@class DirectoryService;
@class DirectoryViewController;
@class DirectoryModel;

@class BrowseViewController;

@class ImageViewController;
@class ImageModel;


@interface MainWindowController : NSWindowController<NSWindowDelegate> {
    enum {
        directory,
        browse,
        image
    } state;
    
    double __browseZoom;
    NSRect __previous;
}

@property (strong) DirectoryViewController* directoryController;
@property (strong) BrowseViewController* browseController;
@property (strong) ImageViewController* imageController;

@property (nonatomic, strong) IBOutlet DirectoryService* service;

@property (strong) IBOutlet NSView* content;

@property (strong) IBOutlet NSButton* add;
@property (strong) IBOutlet NSButton* back;
@property (strong) IBOutlet NSButton* rm;

@property (strong) IBOutlet NSSegmentedControl* nav;

@property (strong) IBOutlet NSSlider* zoom;

@property BOOL rm_enabled;

- (IBAction) _add:  (id) sender;
- (IBAction) _back: (id) sender;
- (IBAction) _rm:   (id) sender;

- (IBAction) _nav:  (id) sender;
- (IBAction) _zoom: (id) sender;

- (void) dispose;
- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context;


@end
