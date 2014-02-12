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


@class DirectoryService;
@class DirectoryViewController;
@class DirectoryModel;

@class BrowseViewController;

@class ImageViewController;
@class ImageModel;


@interface MainWindowController : NSWindowController {
    enum {
        directory,
        browse,
        image
    } state;
    
}

@property (nonatomic, strong) DirectoryViewController* directoryController;
@property (nonatomic, strong) BrowseViewController* browseController;
@property (nonatomic, strong) ImageViewController* imageController;

@property (nonatomic, strong) IBOutlet DirectoryService* service;

@property (nonatomic, strong) IBOutlet NSView* content;

@property (nonatomic, strong) IBOutlet NSButton* add;
@property (nonatomic, strong) IBOutlet NSButton* back;
@property (nonatomic, strong) IBOutlet NSButton* rm;

@property (nonatomic, strong) IBOutlet NSSegmentedControl* nav;

@property (nonatomic, strong) IBOutlet NSSlider* zoom;

- (IBAction) _add:  (id) sender;
- (IBAction) _back: (id) sender;
- (IBAction) _rm:   (id) sender;

- (IBAction) _nav:  (id) sender;
- (IBAction) _zoom: (id) sender;

- (void) dispose;


@end
