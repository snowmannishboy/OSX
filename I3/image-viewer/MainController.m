//
//  MainController.m
//  image-viewer
//
//  Created by Robert Novak on 2/3/14.
//  Copyright (c) 2014 Robert Novak. All rights reserved.
//

#import "MainController.h"

@interface MainController ()

@end

@implementation MainController

@synthesize view = _view;
@synthesize addButton = _addButton;
@synthesize removeButton = _removeButton;
@synthesize backButton = _backButton;
@synthesize directoryController = _directoryController;
@synthesize bottomBar = _bottomBar;
@synthesize viewMenu = _viewMenu;
@synthesize imageController = _imageController;
@synthesize tagController = _tagController;
@synthesize zoomSlider = _zoomSlider;
@synthesize zoomLevel = _zoomLevel;

- (IBAction)zoomLevelDidChange:(id)sender {
    if (_state == mcImage) {
        [[_imageController scrollView] setMagnification:_zoomLevel];

    }
}



- (void) tagItemClicked:(id)sender {
    
}

- (void) enable: (NSControl*) buttons, ... {
    va_list args;
    va_start (args, buttons);
    
    [buttons setEnabled:YES];
    
    NSControl* value = nil;
    
    while ((value = va_arg(args, NSControl*)))
        [value setEnabled:YES];
    
    va_end(args);
}


- (IBAction)navigateClicked:(id)sender {

}

- (IBAction) tagMenuItemClicked:(id)sender {
    if (_state == mcDirectory) {
        [self transition: _directoryController to: _tagController];
        _state = mcTag;
    }
}

- (IBAction)directoryMenuItemClicked:(id)sender {
    if (_state == mcTag) {
        [self transition: _tagController to:_directoryController];
        _state = mcDirectory;
    }
}

- (void) disable: (NSControl*) buttons, ... {
    va_list args;
    va_start(args, buttons);
    NSControl* value = nil;
    [buttons setEnabled:NO];
    while((value = va_arg(args, NSControl*)))
        [value setEnabled:NO];
    
    va_end(args);
}


- (void) transition:(NSViewController*) from to: (NSViewController*) to {

    [[from view] setHidden:YES];
    [[to view] setHidden:NO];
    
}

- (void) boxDoubleClicked:(id)sender {
    if (_state == mcDirectory) {
        ClickableBox* target = (ClickableBox*) sender;
        
        [self transition:_directoryController to:_browseController];
        
        [_browseController addPath:[target path]];
        
        [self enable:_backButton, nil];
        [self disable: _addButton, _removeButton, _viewMenu, nil];
        
        _state = mcBrowse;
    }
}

- (void) imageWasDoubleClicked:(bvImage *)target {
    if (_state == mcBrowse) {
        [_imageController setImage:[target path]];
        [self transition:_browseController to:_imageController];
        [self enable:_nav, _zoomSlider, nil];
        _state = mcImage;
    }
}



- (id)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    if (self) {
        [ClickableBox setDelegate:self];
        [BrowseViewController setDelegate:self];
        
        _state = mcDirectory;
        
        _directoryController = [[DirectoryViewController alloc] init];
        _browseController = [[BrowseViewController alloc] init];
        _imageController = [[ImageViewController alloc] init];
        _tagController = [[TagViewController alloc] init];
        
    }
    return self;
}


- (void) awakeFromNib {
    
    [_tagController addToSuper:_view];
    [_imageController addToSuper:_view];
    [_browseController addToSuper:_view];
    [_directoryController addToSuper:_view];

    [self disable:_backButton, _nav, _zoomSlider, nil];
    
    [_zoomSlider setFloatValue:1.0];
    

}

- (void) windowWillStartLiveResize:(NSNotification *)notification {

    if (_state == mcImage) {
        [[_imageController scrollView] setMagnification:1.0];
        //[_zoomSlider setFloatValue:1.0];
        //[[_imageController scrollView] setMagnification:1.0];
    }

}

- (void) windowDidEndLiveResize:(NSNotification *)notification {
    if (_state == mcImage) {
        [[_imageController scrollView] setMagnification:_zoomLevel];
    }
}



- (IBAction) addButtonClicked:(id)sender {

    if (_state == mcDirectory) {
    
        NSOpenPanel* open = [NSOpenPanel openPanel];
        [open setCanChooseDirectories:YES];
        [open setCanChooseFiles:NO];
        [open setAllowsMultipleSelection:NO];
        
        long result = [open runModal];
        
        if (result == NSOKButton) {
            NSArray* urls = [open URLs];
            [urls enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                NSURL* url = (NSURL*) obj;
              NSString* path = [url path];
                [_directoryController addItem:path];
            }];
        }
    }
    else if (_state == mcTag) {
        NSDictionary* newObj = [NSDictionary dictionaryWithObjectsAndKeys:@"New Tag", @"name", nil];
        [_tagController addObject:newObj];
    }
}

- (IBAction)backButtonClicked:(id)sender {
    if (_state == mcBrowse) {
        [self transition:_browseController to:_directoryController];

        [self enable: _addButton, _removeButton, _viewMenu, nil];
        [self disable: _backButton, nil];
        
        _state = mcDirectory;
        [_browseController clearPath];

    }
    else if (_state == mcImage) {
        
        [self transition:_imageController to:_browseController];
        [self disable:_nav, _zoomSlider, nil];
        
        _state = mcBrowse;
        [_imageController clearImage];
        [_zoomSlider setFloatValue:1.0];
    }
}

@end
