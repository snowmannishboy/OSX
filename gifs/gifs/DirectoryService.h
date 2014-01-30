//
//  DirectoryService.h
//  gifs
//
//  Created by Robert Novak on 1/26/14.
//  Copyright (c) 2014 Robert Novak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Directory.h"

@protocol DirectoryServiceDelegateProtocol <NSObject>

-(NSManagedObjectContext*) managedObjectContext;

@end

@interface DirectoryService : NSObject

- (NSMutableArray*) load;

- (void) add: (NSString*) directory;

- (void) remove: (NSString*) directory;

@property IBOutlet id<DirectoryServiceDelegateProtocol> delegate;

+ (void) setContext: (NSManagedObjectContext*) context;

@end
