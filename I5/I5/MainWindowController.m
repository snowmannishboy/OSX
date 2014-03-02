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

- (void) moveBack;
- (void) moveForw;

- (void) logRect: (NSRect) rect;

@end

@implementation MainWindowController


- (id)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    if (self) {
        state = directory;
        __browseZoom = DEFAULT_ZOOM_BROWSE;
        
        _rm_enabled = YES;
        
        _directoryController = [[DirectoryViewController alloc] init];
        _browseController = [[BrowseViewController alloc] init];
        _imageController = [[ImageViewController alloc] init];
        
            // These are all the actions that we need to recieve
        [ClickableBox setAction:@selector(_clickableBox:) target:self];
        [DirectoryService setAction:@selector(_directoryService:) target:self];
        [BrowseViewController setAction:@selector(_imageBrowser:) target:self];
        [ImageViewController setDelegate:self];
    
    }
    return self;
}


- (void) awakeFromNib {
    
    [_imageController add:_content];
    [_browseController add:_content];
    [_directoryController add:_content];

    [self disable:_back, _nav, _zoom, nil];
    
    [_directoryController addObserver:self forKeyPath:@"selectedIndexes" options:NSKeyValueObservingOptionNew context:nil];

}


- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqual:@"selectedIndexes"]) {
        if (state == directory) {
            NSIndexSet* set = [change objectForKey:NSKeyValueChangeNewKey];
            [_rm setEnabled:[set firstIndex] != NSNotFound];
        }
    }
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
                DirectoryModel* model = nil;
                model = [_service check:[obj path]];
                if (model == nil) {
                    model = [[DirectoryModel alloc] initWithURL:obj];
                    [_service save:model];
                }
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
                
        [[[_browseController scrollView] documentView] scrollPoint:__previous.origin];
        
        
    }
}

- (IBAction)_nav:(id)sender {
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

- (IBAction)_rm: (id) sender {
    if (state == directory) {
        NSUInteger index = [[_directoryController selectedIndexes] firstIndex];
        if (index != NSNotFound) {
            DirectoryModel* dir = [[_directoryController content] objectAtIndex:index];
            if (dir != nil) {
                if ([_service remove:dir]) {
                    [[_directoryController controller] removeObject:dir];
                }
            }
        }
    }
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
        
        [_directoryController setSelectedIndexes:[[NSIndexSet alloc] init]];
    }
}

- (void) _imageBrowser:(ImageModel *)target {
    if (state == browse) {
        state = image;
        
        __previous = [[_browseController scrollView] documentVisibleRect];
        
        [self transitionFrom:_browseController to:_imageController];
        [self enable:_nav, nil];
        
        
        [_imageController setImage:[target imageRepresentation]];
        [_zoom setFloatValue:0.25];
    }
}


/** Pseudo Actions **/


- (void) windowDidResize:(NSNotification *)notification {
    if (state == image) {
        
        NSRect imageBounds = [[_imageController imageView] bounds];
        
        NSRect scrollBounds = [[_imageController scrollView] documentVisibleRect];
        
        double x = (imageBounds.size.width - scrollBounds.size.width) / 2;
        
        double y = (imageBounds.size.height - scrollBounds.size.height) / 2;
        
        [[[_imageController scrollView] documentView] scrollPoint:NSMakePoint(x, y)];
        
    }
}

- (void) scrollWheel:(NSEvent *)theEvent {
    if (state == image) {
        if (theEvent.scrollingDeltaY > 0.1) {
            [self moveBack];
        }
        else if (theEvent.scrollingDeltaY < -0.1) {
            [self moveForw];
        }
    }
}

- (void) keyDown:(NSEvent *)theEvent {
    [self interpretKeyEvents:[NSArray arrayWithObject:theEvent]];
}

- (void) moveLeft:(id)sender {
    if (state == image) {
        [self moveBack];
    }
}


- (void) moveRight:(id)sender {
    if (state == image) {
        [self moveForw];
    }
}




/****************** Useful ********************/


- (void) moveBack {
    ImageModel* img = [_browseController previous];
    if (img != nil) {
        [[_imageController scrollView] setMagnification:1.0];
        [_zoom setFloatValue:0.25];
        [_imageController setImage:[img imageRepresentation]];
    }
}

- (void) moveForw {
    ImageModel* img = [_browseController next];
    if (img != nil) {
        [[_imageController scrollView] setMagnification:1.0];
        [_zoom setFloatValue:0.25];
        [_imageController setImage:[img imageRepresentation]];
    }
}


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

- (void) logRect:(NSRect)rect {
    NSLog(@"Height - %f", rect.size.height);
    NSLog(@"Width - %f", rect.size.width);
    NSLog(@"(%f, %f)", rect.origin.x, rect.origin.y);
}

@end


