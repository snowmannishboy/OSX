//
//  DirectoryService.h
//  I4
//
//  Created by Robert Novak on 2/9/14.
//  Copyright (c) 2014 Robert Novak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Directory.h"

@interface NSObject (loadDelegate)
- (void) __directoryService_loaded: (id) sender;
@end

@class DirectoryModel;

@interface DirectoryService : NSObject

@property IBOutlet id delegate;

@property NSManagedObjectContext* context;

+ (void) setAction: (SEL) action target: (id) target;
- (NSArray*) load;
- (void) save: (DirectoryModel*) obj;


@end
