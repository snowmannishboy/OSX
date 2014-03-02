//
//  DirectoryService.h
//  ImageBrowser
//
//  Created by Robert Novak on 2/16/14.
//  Copyright (c) 2014 Robert Novak. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DirectoryModel;

@interface DirectoryService : NSObject

@property (strong, nonatomic) NSManagedObjectContext* context;

- (NSArray*) load;

- (void) save: (DirectoryModel*) model;

- (BOOL) delete: (DirectoryModel*) model;

@end
