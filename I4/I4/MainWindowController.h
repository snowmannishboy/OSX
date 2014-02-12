//
//  MainWindowController.h
//  I4
//
//  Created by Robert Novak on 2/9/14.
//  Copyright (c) 2014 Robert Novak. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <Quartz/Quartz.h>
#import "DirectoryViewController.h"
#import "BrowseViewController.h"
#import "DirectoryService.h"
#import "ImageViewController.h"



@interface MainWindowController : NSWindowController {
    enum __STATE {
        __DIRECTORY,
        __BROWSE,
        __IMAGE
    } _STATE;
    
}

- (void) enable: (NSControl*) control, ... ;
- (void) disable: (NSControl*) control, ... ;
- (void) transitionFrom: (NSViewController*) from to: (NSViewController*) to;

- (void) imageBrowser:(IKImageBrowserView *)aBrowser cellWasDoubleClickedAtIndex:(NSUInteger)index;

- (IBAction)__back_buttonClicked:(id)sender;
- (IBAction)__add_buttonClicked: (id) sender;
- (IBAction)__del_buttonClicked: (id) sender;
- (IBAction)__zoom_changed: (id) sender;


@property (nonatomic, strong) IBOutlet NSView* contentView;
@property (nonatomic, strong) IBOutlet NSButton* backButton;
@property (nonatomic, strong) IBOutlet NSButton* addButton;
@property (nonatomic, strong) IBOutlet NSButton* delButton;

@property (nonatomic, strong) IBOutlet NSSlider* zoomSlider;

@property (nonatomic, strong) IBOutlet DirectoryService* service;

@property (nonatomic, strong) DirectoryViewController* directoryController;
@property (nonatomic, strong) BrowseViewController* browseController;
@property (nonatomic, strong) ImageViewController* imageController;

@property (nonatomic) double zoomLevel;

@end
