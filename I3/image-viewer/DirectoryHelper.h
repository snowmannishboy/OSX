//
//  DirectoryHelper.h
//  image-viewer
//
//  Created by Robert Novak on 2/8/14.
//  Copyright (c) 2014 Robert Novak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <uuid/uuid.h>
#import "AppDelegate.h"
#import "Directory.h"


@interface DirectoryHelper : NSControl

@property IBOutlet AppDelegate* delegate;
@property IBOutlet id controller;


@property NSManagedObjectContext*   context;

- (NSArray*) load;
- (void) save: (NSDictionary*) obj;
- (void) delete: (NSString*) identifier;


@end
