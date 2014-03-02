//
//  MainController.m
//  ImageBrowser
//
//  Created by Robert Novak on 2/16/14.
//  Copyright (c) 2014 Robert Novak. All rights reserved.
//

#import <Quartz/Quartz.h>
#import "MainController.h"
#import "DirectoryViewController.h"
#import "DirectoryModel.h"
#import "DirectoryService.h"
#import "ClickableBox.h"
#import "BrowseViewController.h"
#import "ImageBrowserModel.h"
#import "ImageViewController.h"


@interface MainController ()

- (void) openFiles;
- (void) processURLs: (NSArray*) urls;
- (void) initialLoad;

- (void) _clickableBox: (id) sender;
- (void) _imageBrowser: (id) sender;
- (void) _scrollWheel: (NSEvent*) theEvent;

- (void) enable: (NSControl*) control, ...;
- (void) disable: (NSControl*) control, ...;
- (void) transitionFrom: (NSViewController*) from to: (NSViewController*) to;
@end

@implementation MainController

/* Initialization */

- (id)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    if (self) {
        state = directory;
        
        [ClickableBox setAction:@selector(_clickableBox:) target:self];
        [BrowseViewController setAction:@selector(_imageBrowser:) target:self];
        [DelegatedScrollView setAction:@selector(_scrollWheel:) target:self];
        
        _directoryController = [[DirectoryViewController alloc] init];
        _browseController = [[BrowseViewController alloc] init];
        _imageController = [[ImageViewController alloc] init];
        
    }
    return self;
}

- (void) _scrollWheel:(NSEvent *)theEvent {
    if (state == image) {
        if (theEvent.scrollingDeltaY > 0.15) {
            [self moveBack];
        }
        else if (theEvent.scrollingDeltaY < -0.15) {
            [self moveForw];
        }
    }
}

- (void) awakeFromNib {
    
    [_directoryController maximizeInParent:_contentView];
    [_directoryController addObserver:self forKeyPath:@"selectionIndexes" options:NSKeyValueObservingOptionNew context:nil];
    [_zoom setFloatValue:1.0];
    
    __previous_zoom = 1.0;
    
    [self disable:_navigate, _zoom, _back, nil];
}


/* IB Actions */

- (IBAction)_back:(id)sender {
    if (state == browse) {
        [_browseController clearDirectory];
        state = directory;
        [self transitionFrom:_browseController to:_directoryController];
        
        __previous_zoom = _zoomLevel;
        [_zoom setFloatValue:1.0];
        
        [self enable:_add, _remove, nil];
        [self disable:_zoom, _back, nil];
    }
    else if (state == image) {
        
        [_imageController setMagnification:1.0];
        [_imageController clearImage];
        
        [[_browseController browseView] setZoomValue:(__previous_zoom / BROWSE_ZOOM_FACTOR)];
        
        _zoomLevel = __previous_zoom;
        [_zoom setFloatValue:_zoomLevel];
        
        [self transitionFrom:_imageController to:_browseController];
        
        [self disable:_navigate, nil];
        state = browse;
    }
}


- (IBAction)_add:(id)sender {
    if (state == directory) {
        [self openFiles];
    }
}

- (IBAction)_remove:(id) sender {
    if (state == directory) {
        NSIndexSet* set = [_directoryController selectionIndexes];
        
        if ([set firstIndex] != NSNotFound) {
            DirectoryModel* model = [[_directoryController directories] objectAtIndex:[set firstIndex]];
            if ([_directoryService delete:model]) {
                [[_directoryController collectionController] removeObject:model];
            }
        }
    }
}


- (IBAction)_navigate: (id) sender {
    if (state == image) {
        NSSegmentedControl* control = sender;
        if ([control selectedSegment] == 0) {
            [self moveBack];
        }
        else {
            [self moveForw];
        }
    }
}


- (IBAction)_zoom: (id) sender {
    if (state == browse) {
        [[_browseController browseView] setZoomValue:(_zoomLevel / BROWSE_ZOOM_FACTOR)];
    }
    else if (state == image) {
        [_imageController setMagnification:(_zoomLevel + IMAGE_ZOOM_OFFSET)];
    }
}

/* PSEUDO Actions */

- (void) _imageBrowser:(id)sender {
    if (state == browse) {
        
        ImageBrowserModel* model = sender;
        
        [_imageController setMagnification:1.0];
        [_zoom setFloatValue: DEFAULT_ZOOM_IMAGE];
        
        [_imageController setImage:[model path]];
        
        [self transitionFrom:_browseController to:_imageController];
        
        [self enable:_navigate, nil];
        
        __previous_zoom = _zoomLevel;
        
        _zoomLevel = DEFAULT_ZOOM_IMAGE;
        
        state = image;
    }
}

- (void) _clickableBox:(id)sender {
    if (state == directory) {
        ClickableBox* box = sender;
        DirectoryModel* model = [box represented];
            
        [self transitionFrom:_directoryController to:_browseController];
        [_browseController openDirectory:model];
        
        [[_browseController browseView] setZoomValue:(__previous_zoom / BROWSE_ZOOM_FACTOR) ];
        
        [self disable:_remove, _add, nil];
        [self enable:_zoom, _back, nil];
        
        _zoomLevel = __previous_zoom;
        [_zoom setFloatValue:_zoomLevel];
        
        state = browse;
    }
}


- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    if ([keyPath isEqualToString:@"context"]) {
        if ([_directoryService context])
            [self initialLoad];
    }
    else if (state == directory && [keyPath isEqualToString:@"selectionIndexes"]) {
        NSIndexSet* set = [change valueForKey:NSKeyValueChangeNewKey];
        if ([set count]) {
            [self enable:_remove, nil];
        }
        else [self disable:_remove, nil];
    }
    
}

- (void) windowDidResize:(NSNotification *)notification {
    if (state == image) {
        
        [_imageController scrollToCenter];
        
    }
}


/* */

- (void) transitionFrom:(NSViewController *)from to:(NSViewController *)to {
    
    [[from view] removeFromSuperview];
    
    [to maximizeInParent:_contentView];

}

- (void) enable:(NSControl *)control, ... {
    if (!control) return;
    
    va_list args;
    va_start(args, control);
    
    [control setEnabled:YES];
    
    NSControl* next = nil;
    
    while ((next = va_arg(args, NSControl*))) [next setEnabled:YES];
    
    va_end(args);
    
}

- (void) disable:(NSControl *)control, ... {
    if (!control) return;
    
    va_list args;
    va_start(args, control);
    
    [control setEnabled:NO];
    
    NSControl* next = nil;
    
    while ((next = va_arg(args, NSControl*))) [next setEnabled:NO];
    
    va_end(args);
    
}


- (void) processURLs:(NSArray *)urls {
    
    if (!urls) return;
    
    [urls enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSURL* url = obj;
        DirectoryModel* model = [[DirectoryModel alloc] initWithURL:url];
        [_directoryService save:model];
        [_directoryController addDirectoriesObject:model];
    }];
    
    
}

- (void) openFiles {
    NSOpenPanel* panel = [NSOpenPanel openPanel];
    [panel setAllowsMultipleSelection:YES];
    [panel setCanChooseDirectories:YES];
    [panel setCanChooseFiles:NO];
    
    long result = [panel runModal];
    
    if (result == NSOKButton) {
        NSArray* urls = [panel URLs];
        [self performSelectorInBackground:@selector(processURLs:) withObject:urls];
    }
    
}
- (void) moveBack {
    ImageBrowserModel* img = [_browseController previous];
    
    if (img != nil) {
        [[_imageController scrollView] setMagnification:1.0];
        [_zoom setFloatValue:0.25];
        [_imageController setImage:[img imageRepresentation]];
    }
}

- (void) moveForw {
    ImageBrowserModel* img = [_browseController next];
    if (img != nil) {
        [[_imageController scrollView] setMagnification:1.0];
        [_zoom setFloatValue:0.25];
        [_imageController setImage:[img imageRepresentation]];
    }
}

- (void) initialLoad {
    [_directoryController addDirectories:[_directoryService load]];
}


@end
