//
//  MainWindowController.m
//  I5
//
//  Created by Robert Novak on 2/10/14.
//  Copyright (c) 2014 Robert Novak. All rights reserved.
//

#import "MainWindowController.h"
#import "DirectoryService.h"
#import "DirectoryModel.h"
#import "DirectoryViewController.h"
#import "BrowseViewController.h"
#import "ImageViewController.h"
#import "ImageModel.h"
#import "ClickableBox.h"

@interface MainWindowController ()

// *private* methods
- (void) _directoryService: (id) sender;
- (void) _clickableBox: (id) sender;
- (void) _imageBrowser: (ImageModel*) target;

// convenience methods
- (void) enable: (NSControl*) control, ...;
- (void) disable: (NSControl*) control, ...;
- (void) transitionFrom: (NSViewController*) from to: (NSViewController*) to;

@end

@implementation MainWindowController


- (id)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    if (self) {
        state = directory;
        __browseZoom = DEFAULT_ZOOM_BROWSE;
        
        _directoryController = [[DirectoryViewController alloc] init];
        _browseController = [[BrowseViewController alloc] init];
        _imageController = [[ImageViewController alloc] init];
        
            // These are all the actions that we need to recieve
        [ClickableBox setAction:@selector(_clickableBox:) target:self];
        [DirectoryService setAction:@selector(_directoryService:) target:self];
        [BrowseViewController setAction:@selector(_imageBrowser:) target:self];
        
    
    }
    return self;
}


- (void) awakeFromNib {
    
    [_imageController add:_content];
    [_browseController add:_content];
    [_directoryController add:_content];

    [self disable:_back, _nav, _zoom, nil];

}


/***************** Actions *******************/


- (IBAction)_add:(id)sender {
    if (state == directory) {
        NSOpenPanel* open = [NSOpenPanel openPanel];
        [open setCanChooseDirectories:YES];
        [open setCanChooseFiles:NO];
        [open setAllowsMultipleSelection:YES];
        
        long _result = [open runModal];
        
        if (_result == NSOKButton) {
            NSArray* urls = [open URLs];
            [urls enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                DirectoryModel* model = [[DirectoryModel alloc] initWithURL:obj];
                [_service save:model];
                [_directoryController addItem:model];
            }];
        }
    }
}

- (IBAction)_back:(id)sender {
    if (state == browse) {
        [_browseController clear];
        [self enable:_add, _rm, nil];
        [self disable: _zoom, _back, nil];
        [self transitionFrom:_browseController to:_directoryController];
        state = directory;
    }
    else if (state == image) {
        [_imageController clearImage];
        [self disable:_nav, nil];
        [self transitionFrom:_imageController to:_browseController];
        [_zoom setFloatValue:__browseZoom * 2.5];
        state = browse;
    }
}

- (IBAction)_nav:(id)sender {
    
}

- (IBAction)_rm: (id) sender {
    
}

- (IBAction)_zoom:(id)sender {
    if (state == browse) {
        __browseZoom = [_zoom floatValue] / 2.5;
        [[_browseController browserView] setZoomValue:([_zoom floatValue] / 2.5)];
    }
    else if (state == image) {
        [[_imageController scrollView] setMagnification:([_zoom floatValue] + 0.75)];
    }
}


- (void) _clickableBox: (id) sender {
    if (state == directory) {
        ClickableBox* target = sender;
        DirectoryModel* model = [target representedObject];
        [self transitionFrom:_directoryController to:_browseController];
        [_browseController open:model];
        [self disable:_add, _rm, nil];
        [self enable: _zoom, _back, nil];
        [_zoom setFloatValue:__browseZoom * 2.5];
        state = browse;
    }
}


- (void) _directoryService:(id) sender {
    if (state == directory) {
        NSArray* directories = [_service load];
        
        [directories enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [_directoryController addItem:obj];
        }];
    }
}

- (void) _imageBrowser:(ImageModel *)target {
    if (state == browse) {
        state = image;
        [self transitionFrom:_browseController to:_imageController];
        [self enable:_nav, nil];
        
        [_imageController setImage:[target imageRepresentation]];
        [_zoom setFloatValue:0.25];
    }
}


/** Event Notifications **/

- (void) windowWillStartLiveResize:(NSNotification *)notification {
    if (state == image) {
        previous = [[_imageController scrollView] documentVisibleRect];
    }
}


- (void) windowDidResize:(NSNotification *)notification {
    if (state == image) {
        
        NSRect imageBounds = [[_imageController imageView] bounds];
        
        NSRect scrollBounds = [[_imageController scrollView] documentVisibleRect];
        
        double x = (imageBounds.size.width - scrollBounds.size.width) / 2;
        
        double y = (imageBounds.size.height - scrollBounds.size.height) / 2;
        
        //NSRect new = NSMakeRect(x, y, scrollBounds.size.width, scrollBounds.size.height);
        
        [[[_imageController scrollView] documentView] scrollPoint:NSMakePoint(x, y)];
        
    }
}




/****************** Useful ********************/


- (void) enable:(NSControl *)control, ... {
    if (!control) return;
    
    va_list arguments;
    va_start(arguments, control);
    
    [control setEnabled:YES];
    
    NSControl* next = nil;
    
    while ((next = va_arg(arguments, NSControl*)))
        [next setEnabled:YES];
    
    va_end(arguments);
    
}

- (void) disable:(NSControl *)control, ... {
    if (!control) return;
    
    va_list args;
    va_start(args, control);

    [control setEnabled:NO];
    
    NSControl* next = nil;
    
    while ((next = va_arg(args, NSControl*)))
        [next setEnabled:NO];
    
    va_end(args);
    
}

- (void) transitionFrom:(NSViewController *)from to:(NSViewController *)to {
    [[from view] setHidden:YES];
    [[to view] setHidden:NO];
    [[self zoom] setFloatValue:1.0];
    [[_browseController browserView] setZoomValue:__browseZoom];
    [[_imageController scrollView] setMagnification:1.0];
}


/* TODO: Finish method once all controllers are implemented */

- (void) dispose {
    if (state != directory) {
        [_browseController clear];
    }
}



@end
