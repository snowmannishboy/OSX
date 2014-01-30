//
//  DirectoryViewController.m
//  gifs
//
//  Created by Robert Novak on 1/22/14.
//  Copyright (c) 2014 Robert Novak. All rights reserved.
//

#import "DirectoryViewController.h"

@interface DirectoryViewController ()

@end

@implementation DirectoryViewController

@synthesize directories = _directories;
@synthesize selected = _selected;
@synthesize directoryView = _directoryView;
@synthesize directoryController = _directoryController;
@synthesize inner = _inner;
@synthesize outter = _outter;
@synthesize directoryService = _directoryService;

- (id) init {
    self = [super init];
    if (self) {
        NSArray* topLevelObjects = [NSArray arrayWithObjects:_directoryController, _directoryView, _addButton, _inner, nil];
        
        [[NSBundle mainBundle] loadNibNamed:@"DirectoryView" owner:self topLevelObjects:&topLevelObjects];
    }
    return self;
}

- (void) awakeFromNib {
        
    _directories = [[NSMutableArray alloc] init];
    _selected = [[NSMutableArray alloc] init];
    
    NSSize defaultSize = NSMakeSize(150, 160);
    
    [_directoryView setMaxItemSize:defaultSize];
    [_directoryView setMinItemSize:defaultSize];
    
}


- (void) add: (NSView*) superView {
    
    _outter = superView;
    
    [_inner setFrame: [superView bounds]];
    
    [superView addSubview:_inner];
    
    [_inner setAutoresizingMask:NSViewHeightSizable|NSViewWidthSizable];
    
    [_inner setTranslatesAutoresizingMaskIntoConstraints:YES];
    
    [superView addConstraint:[NSLayoutConstraint constraintWithItem:_inner attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:_outter attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0]];
    
    [superView addConstraint: [NSLayoutConstraint constraintWithItem:_inner attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:_outter attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0]];
    

}

- (void) addObject: (id) obj {
    [_directoryController addObject:obj];
}

- (void) processUrls: (NSArray*) data {
    if (data == nil) return;
    
    [data enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSURL* url = (NSURL*) obj;
        NSString* path = [url path];
        [_directoryService add:path];
        NSDictionary* thisObj = [NSDictionary dictionaryWithObjectsAndKeys:path, @"filename", nil];
        [self performSelectorOnMainThread:@selector(addObject:) withObject:thisObj waitUntilDone:YES];
    }];
    
}

- (IBAction)deleteButtonClicked:(id)sender {
    NSArray* selected = [_directoryController selectedObjects];
    if ([selected count] > 0) {
        [selected enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            NSString* filename = [obj valueForKey:@"filename"];
            if (_directoryService != nil) {
                [_directoryService remove:filename];
            }
            [_directoryController remove:obj];
        }];
    }
}

- (IBAction)addButtonClicked:(id)sender {
    
    
    NSOpenPanel* panel = [NSOpenPanel openPanel];
    
    [panel setCanChooseDirectories:YES];
    [panel setCanChooseFiles:NO];
    [panel setAllowsMultipleSelection:YES];
    
    long result = [panel runModal];
    
    
    if (result == NSOKButton) {
        
        [NSThread detachNewThreadSelector:@selector(processUrls:) toTarget:self withObject:[panel URLs]];
        
    }
    
}







@end
