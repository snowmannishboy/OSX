//
//  AppDelegate.h
//  gifs
//
//  Created by Robert Novak on 1/21/14.
//  Copyright (c) 2014 Robert Novak. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "MainController.h"

@interface AppDelegate : NSObject <NSApplicationDelegate> {
    
}

@property (assign) IBOutlet NSWindow *window;

@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property IBOutlet MainController* mainController;

- (IBAction)saveAction:(id)sender;

- (BOOL) applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender;

@end
