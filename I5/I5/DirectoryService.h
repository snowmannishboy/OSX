//
//  DirectoryService.h
//  I5
//
//  Created by Robert Novak on 2/10/14.
//  Copyright (c) 2014 Robert Novak. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AppDelegate;
@class DirectoryModel;

@interface DirectoryService : NSObject

@property (nonatomic) NSManagedObjectContext *context;

@property (nonatomic, strong) IBOutlet AppDelegate *delegate;

- (NSArray*)    load;
- (void)        save: (DirectoryModel*) target;

+ (void) setAction: (SEL) action target: (id) target;

@end
