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
@synthesize imageController = _imageController;
@synthesize tagController = _tagController;
@synthesize zoomSlider = _zoomSlider;
@synthesize zoomLevel = _zoomLevel;
@synthesize mainWindow = _mainWindow;
@synthesize directoryHelper = _directoryHelper;

- (IBAction)zoomLevelDidChange:(id)sender {
    if (_state == mcImage) {
        [[_imageController scrollView] setMagnification:_zoomLevel];

    }
}

- (IBAction)removeButtonClicked:(id)sender {
    if (_state == mcDirectory && [_directoryController isItemSelected]) {
        NSDictionary* current = [_directoryController removeSelected];
        [_directoryHelper delete:[current objectForKey:@"identifier"]];
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

- (void) moveBack {
    bvImage* newImage = [_browseController moveBack];
    [[_imageController scrollView] setMagnification:1.0];
    _zoomLevel = 1.0;
    [_zoomSlider setFloatValue:1.0];
    [_imageController setImage: [newImage path]];
}

- (void) moveForward {
    bvImage* newImage = [_browseController moveForward];
    [[_imageController scrollView] setMagnification:1.0];
    _zoomLevel = 1.0;
    [_zoomSlider setFloatValue:1.0];
    [_imageController setImage:[newImage path]];
}

- (void) keyDown:(NSEvent *)theEvent {
    [super interpretKeyEvents:[NSArray arrayWithObjects:theEvent, nil]];
}

- (void) moveLeft:(id)sender {
    if (_state == mcImage) [self moveBack];
}

- (void) moveRight: (id) sender {
    if (_state == mcImage) [self moveForward];
}

- (void) scrollWheel:(NSEvent *)theEvent {
    if (_state == mcImage) {
        if (theEvent.scrollingDeltaY > 0.1) {
            [self moveBack];
        }
        else if (theEvent.scrollingDeltaY < -0.1) {
            [self moveForward];
        }
    }
}


- (IBAction)navigateClicked:(id)sender {
    if (_state == mcImage) {
        NSSegmentedCell* target = sender;
        if ([target selectedSegment] == 0) {
            [self moveBack];
        }
        else {
            [self moveForward];
        }
    }
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
        [self disable: _addButton, _removeButton, nil];
        
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
        [ImageViewController setDelegate:self];
        
        _state = mcDirectory;
        
        _directoryController = [[DirectoryViewController alloc] init];
        _browseController = [[BrowseViewController alloc] init];
        _imageController = [[ImageViewController alloc] init];
        
        [[self window] becomeFirstResponder];
    
    }
    return self;
}

- (BOOL) acceptsFirstResponder {
    return YES;
}


- (void) awakeFromNib {
    
    [_imageController addToSuper:_view];
    [_browseController addToSuper:_view];
    [_directoryController addToSuper:_view];

    [self disable:_backButton, _nav, _zoomSlider, nil];
    
    [_zoomSlider setFloatValue:1.0];
    
    NSArray* data = [_directoryHelper load];
    [data enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [_directoryController addItem:obj];
    }];
    
}



- (void) windowWillStartLiveResize:(NSNotification *)notification {

    if (_state == mcImage) {
        [[_imageController scrollView] setMagnification:1.0];
        [_zoomSlider setFloatValue:1.0];
        [[_imageController scrollView] setMagnification:1.0];
    }

}

- (void) windowDidEndLiveResize:(NSNotification *)notification {
    if (_state == mcImage) {
        [[_imageController scrollView] setMagnification:_zoomLevel];
        [_zoomSlider setFloatValue:_zoomLevel];
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
                NSString* displayName = [[NSFileManager defaultManager] displayNameAtPath:path];
                NSDictionary* objectToSave = [[NSDictionary alloc] initWithObjectsAndKeys:path, @"path", displayName, @"name", @"", @"identifier", nil];
                [_directoryController addItem:objectToSave];
                [_directoryHelper save: objectToSave];
            }];
        }
    }
    else if (_state == mcTag) {

    }
}

- (IBAction)backButtonClicked:(id)sender {
    if (_state == mcBrowse) {
        [self transition:_browseController to:_directoryController];

        [self enable: _addButton, _removeButton, nil];
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




- (void) windowDidLoad {
    [super windowDidLoad];
}

@end
