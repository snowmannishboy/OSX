//
//  DirectoryService.m
//  I5
//
//  Created by Robert Novak on 2/10/14.
//  Copyright (c) 2014 Robert Novak. All rights reserved.
//

#import "DirectoryService.h"
#import "DirectoryModel.h"
#import "AppDelegate.h"
#import "NSObject+ActionableObject.h"
#import "Directory.h"

static id   _target;
static SEL  _action;
static void (*callableAction)(id, SEL, id);

@implementation DirectoryService

- (id) init { self = [super init]; return self; }

- (void) awakeFromNib {
    _context = [_delegate managedObjectContext];
    callableAction(_target, _action, self);
}

- (NSArray*) load {
    
    NSError* local = nil;
    
    NSFetchRequest* query = [[NSFetchRequest alloc] init];
    NSEntityDescription* sth = [NSEntityDescription entityForName:@"Directory" inManagedObjectContext:_context];
    
    [query setEntity:sth];
    
    NSArray* data = [_context executeFetchRequest:query error:&local];
    
    if (!data || local) {
        NSLog(@"[%@] Error loading data - %@", [self class], [local localizedDescription]);
    }
    
    NSMutableArray* result = [[NSMutableArray alloc] initWithCapacity:[data count]];
    
    [data enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        Directory* dir = (Directory*)obj;
        DirectoryModel* model = [[DirectoryModel alloc] initWithData:[dir identifier] bookmark:[dir bookmark]];
        [result addObject:model];
    }];
    
    
    return result;
}

- (void) save:(DirectoryModel *)target {
    
    if (!target) return;
    
    NSError* local;
    Directory* dir = [NSEntityDescription insertNewObjectForEntityForName:@"Directory" inManagedObjectContext:_context];
    
    [dir setIdentifier:[target identifier]];
    [dir setBookmark:[target bookmark]];
    
    if (![_context save: &local]) {
        NSLog(@"[%@] Error - %@", [self class], [local localizedDescription]);
        return;
    }
    
}

+ (void) setAction:(SEL)action target:(id)target {
    if (action && target) {
        _action = action;
        _target = target;
        IMP i = [target methodForSelector:_action];
        callableAction = (void*) i;
    }
}

@end
