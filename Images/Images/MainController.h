//
//  MainController.h
//  Images
//
//  Created by Robert Novak on 1/17/14.
//  Copyright (c) 2014 Robert Novak. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <Quartz/Quartz.h>
#include "BrowserControllerWindowController.h"

static @interface MainController : NSWindowController {
 
    enum _viewstate {
        directory,
        browse,
        view
    };
    
    enum _viewstate view;

    NSMutableArray* directories;
    NSMutableArray* selected;
    
    NSButton* _button;
    NSCollectionView* _directory_view;
    
    
}

- (void)performClick:(id)sender;

- (IBAction)add_directory_clicked:(id)sender;

@property IBOutlet NSButton* button;

@property IBOutlet NSCollectionView *directory_view;

@property IBOutlet NSScrollView* scroll_view;

@property IBOutlet IKImageBrowserView* browse_view;

@property IBOutlet BrowserControllerWindowController* imagesController;

@property IBOutlet NSArrayController* arrayController;

@property IBOutlet NSImageView* image_view;

@end
