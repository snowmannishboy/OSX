//
//  MainController.m
//  Images
//
//  Created by Robert Novak on 1/17/14.
//  Copyright (c) 2014 Robert Novak. All rights reserved.
//

#import "MainController.h"
#include "ClickableBox.h"

@interface MainController ()

@end

@implementation MainController

@synthesize browse_view;
@synthesize image_view;
@synthesize directory_view = _directory_view;
@synthesize button = _button;
@synthesize arrayController;
@synthesize imagesController;
@synthesize scroll_view;


- (void) performClick:(id)sender {
    NSLog(@"%@", imagesController);
    [_directory_view setHidden: YES];
    view = browse;
    [browse_view setHidden:NO];
    [_button setTitle:@"Go Back"];
    [scroll_view setHidden:YES];
    ClickableBox* box_clicked = (ClickableBox*) sender;
    
    NSError* currentError = nil;
    
    NSArray* paths = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:[box_clicked directory] error:&currentError];
    
    [paths enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSString* path = (NSString*) obj;
        NSMutableString* actual_path = [[NSMutableString alloc] init];
        [actual_path appendString:[box_clicked directory]];
        [actual_path appendString:@"/"];
        [actual_path appendString:path];
        [imagesController addAnImageWithPath:actual_path];
    }];
    [browse_view setAnimates:YES];
    [imagesController updateDatasource];
    
    
}

- (id)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    if (self) {
        [ClickableBox setMainController:self];
    }
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}

- (IBAction)add_directory_clicked:(id)sender {
    if (view == directory) {
        NSOpenPanel* panel = [NSOpenPanel openPanel];
        
        [panel setFloatingPanel:YES];
        [panel setCanChooseFiles:NO];
        [panel setCanChooseDirectories:YES];
        
        long result = [panel runModal];
        
        if (result == NSOKButton) {
            NSArray* urls = [panel URLs];
            [urls enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                NSURL* url = (NSURL*) obj;
                NSString* path = [url path];
                @try {
                    NSDictionary* newObject = [NSDictionary dictionaryWithObjectsAndKeys:path, @"filename", nil];
                    [arrayController addObject:newObject];
                }
                @catch(NSException* exception) {
                    NSLog(@"Caught Exception: %@", exception);
                }
            }];
        }
    }
    else if (view == browse) {
        [browse_view setHidden: YES];
        [scroll_view setHidden:NO];
        view = directory;
        [_directory_view setHidden:NO];
        [_button setTitle:@"Add Directories"];
        [imagesController removeAll];
        [imagesController updateDatasource];
    }
    
}

- (void) awakeFromNib {
    directories = [[NSMutableArray alloc] init];
    selected = [[NSMutableArray alloc] init];
    NSSize size = NSMakeSize(150.0, 150.0);
    [_directory_view setMinItemSize:size];
    [_directory_view setMaxItemSize:size];

}

- (NSMutableArray*) selected {
    return selected;
}

- (void) setSelected: (NSMutableArray*) newSelected {
    if (newSelected != selected) {selected = newSelected; }
}


- (NSMutableArray*) directories {
    return directories;
}

- (void) setDirectories: (NSMutableArray*) directories_in {
    if (directories_in != directories) { directories = directories_in; }
}


@end
