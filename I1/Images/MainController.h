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
    
    NSManagedObjectContext* _context;
    
}


- (void)performClick:(id)sender;

- (void) addObjects;

- (IBAction)add_directory_clicked:(id)sender;

- (IBAction) delete_button_clicked: (id) sender;

@property IBOutlet NSButton* button;

@property IBOutlet NSButton* deleteButton;

@property IBOutlet NSCollectionView *directory_view;

@property IBOutlet NSScrollView* scroll_view;

@property IBOutlet IKImageBrowserView* browse_view;

@property IBOutlet BrowserControllerWindowController* imagesController;

@property IBOutlet NSArrayController* arrayController;

@property IBOutlet NSImageView* image_view;

+ (void) setManagedObjectContext: (NSManagedObjectContext*) context;

@end
