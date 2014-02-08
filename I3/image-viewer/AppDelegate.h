//
//  AppDelegate.h
//  image-viewer
//
//  Created by Robert Novak on 2/1/14.
//  Copyright (c) 2014 Robert Novak. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "MainController.h"

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (assign) IBOutlet MainController* mainController;

@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;

- (BOOL) applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender;

- (IBAction)saveAction:(id)sender;

@end
