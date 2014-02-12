//
//  MainWindowController.m
//  I4
//
//  Created by Robert Novak on 2/9/14.
//  Copyright (c) 2014 Robert Novak. All rights reserved.
//

#import "MainWindowController.h"
#import "NSViewController+MaximizedInSuper.h"

@interface MainWindowController ()

@end

@implementation MainWindowController

- (id)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    if (self) {
        
        _STATE = __DIRECTORY;
        
        [ClickableBox setAction:@selector(__doubleClicked:) target:self];
        [DirectoryService setAction: @selector(__directoryService_loaded:) target: self];
        
        _directoryController = [[DirectoryViewController alloc] init];
        _browseController = [[BrowseViewController alloc] init];
        _imageController = [[ImageViewController alloc] init];
        
    }
    return self;
}


/* NON-Action actions */


- (void) __directoryService_loaded: (id) sender {
    NSArray* data = [_service load];
    if (!data) return;
    
    [data enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        DirectoryModel* model = (DirectoryModel*)obj;
        [_directoryController addItem:model];
    }];
    
    [_directoryController setSelected:[[NSIndexSet alloc] init]];
}

- (void) __doubleClicked: (id) object {
    if (_STATE == __DIRECTORY) {
        NSError* local;
        ClickableBox* box = (ClickableBox*) object;
        DirectoryModel* model = [box representation];
        
        NSArray* contents = [[NSFileManager defaultManager] contentsOfDirectoryAtURL:[ model url] includingPropertiesForKeys:[NSArray arrayWithObject:NSURLNameKey] options:NSDirectoryEnumerationSkipsHiddenFiles error:&local];
        
        if (!contents || local) {
            NSLog(@"Exception loading contents, %@, %@", [local localizedDescription], [model path]);
            return;
        }
        
        NSRegularExpression* regex = [NSRegularExpression regularExpressionWithPattern:@"^.+\\.(png|gif|jpeg|jpg)$" options:NSRegularExpressionCaseInsensitive error:&local];
        
        [contents enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            NSURL* url = (NSURL*) obj;
            NSString* filename = [url lastPathComponent];
            if ([[regex matchesInString:filename options:0 range:NSMakeRange(0, [filename length])] count ] > 0l) {
                NSString* fullPath = [NSString stringWithFormat:@"%@/%@", [model path], filename];
                [_browseController addItem:fullPath];
            }
        }];

        [self transitionFrom:_directoryController to:_browseController];
        [self enable: _backButton, nil];
        [self disable: _addButton, _delButton, nil];
        
        _STATE = __BROWSE;
    }
}

- (void) imageBrowser:(IKImageBrowserView *)aBrowser cellWasDoubleClickedAtIndex:(NSUInteger)index {
    if (_STATE == __BROWSE) {
        BrowserItem* item = [[_browseController images] objectAtIndex:index];
        [_imageController setImage:[item path]];
        [self transitionFrom:_browseController to:_imageController];
        [self enable: _zoomSlider, nil];
        _STATE = __IMAGE;
    }
}

- (void) awakeFromNib {
    [_imageController maximizeViewInParent:_contentView];
    [_browseController maximizeViewInParent:_contentView];
    [_directoryController maximizeViewInParent:_contentView];
    
    [[_directoryController view] setHidden:NO];
    
    [[_browseController imageBrowser] setDelegate:self];

    [self disable:_backButton, _zoomSlider, nil];

    [_zoomSlider setFloatValue:1.0];
}

/* Actions */


- (IBAction)__del_buttonClicked:(id)sender {
    
}

- (IBAction)__zoom_changed:(id)sender {
    if (_STATE == __IMAGE) {
        [_imageController setMagnification:_zoomLevel];
    }
}


- (IBAction)__add_buttonClicked:(id)sender {
    if (_STATE == __DIRECTORY) {
        NSOpenPanel* openPanel = [NSOpenPanel openPanel];
        [openPanel setCanChooseDirectories:YES];
        [openPanel setCanChooseFiles:NO];
        [openPanel setAllowsMultipleSelection:YES];
        long panelResult = [openPanel runModal];
        if (panelResult == NSOKButton) {
            NSArray* urls = [openPanel URLs];
            if (!urls) return;
            [urls enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                
                NSURL* target = (NSURL*) obj;
                NSString* path = [target path];
                DirectoryModel* newModel = [[DirectoryModel alloc] initWithPath:path];
                
                if (newModel) {
                    [_directoryController addItem:newModel];
                    [_service save:newModel];
                }
            
            }];
        }
    }
}

- (IBAction)__back_buttonClicked:(id)sender {
    if (_STATE == __BROWSE) {
        [_browseController clear];
        [self transitionFrom:_browseController to:_directoryController];
        [self enable:_addButton, _delButton, nil];
        [self disable: _backButton, nil];
        _STATE = __DIRECTORY;
    }
    else if (_STATE == __IMAGE) {
        [self transitionFrom:_imageController to:_browseController];
        [_imageController clearImage];
        [self disable:_zoomSlider, nil];
        [_zoomSlider setFloatValue:1.0];
        _STATE = __BROWSE;
    }
}

/* convenience methods */


- (void) enable:(NSControl *)control, ... {
    if (!control) return;
    
    va_list argList;
    va_start(argList, control);
    
    [control setEnabled:YES];
    
    NSControl* next;
    
    while ((next = va_arg(argList, NSControl*)))
        [next setEnabled:YES];
    
    va_end(argList);
}

- (void) disable:(NSControl*) control, ... {
    if (!control) return;
    
    va_list args;
    va_start(args, control);
    
    [control setEnabled:NO];
    
    NSControl* next;
    
    while ((next = va_arg(args, NSControl*)))
        [next setEnabled:NO];
    
}

- (void) transitionFrom:(NSViewController *)from to:(NSViewController *)to {
    [[from view] setHidden:YES];
    [[to view] setHidden:NO];
}
















@end
