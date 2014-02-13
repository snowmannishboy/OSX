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
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"active = YES"];
    
    [query setEntity:sth];
    [query setPredicate:predicate];
    
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
    [dir setPath:[target path]];
    [dir setActive:YES];
    
    if (![_context save: &local]) {
        NSLog(@"[%@] Error - %@", [self class], [local localizedDescription]);
        return;
    }
    
}

- (DirectoryModel*) check:(NSString *)path {
    DirectoryModel* __block model = nil;
    
    NSError* local;
    
    NSFetchRequest* request = [[NSFetchRequest alloc] init];
    NSEntityDescription* desc = [NSEntityDescription entityForName:@"Directory" inManagedObjectContext:_context];
    NSPredicate* pred = [NSPredicate predicateWithFormat:@"(path = %@) AND (active = NO)", path];
    
    [request setEntity:desc];
    [request setPredicate:pred];
    
    NSArray* arr = [_context executeFetchRequest:request error:&local];
    
    if (local) {
        NSLog(@"Error, %@", [local localizedDescription]);
        return nil;
    }
    
    [arr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        Directory* dir = obj;
        model = [[DirectoryModel alloc] initWithData:[dir identifier] bookmark:[dir bookmark]];
    
        NSError* inner;
        
        [dir setActive:YES];
        
        if (![_context save: &inner]) {
            NSLog(@"Error Updating, %@", [inner localizedDescription]);
        }
        
        *stop = YES;
    }];
    
    
    return model;
}

- (BOOL) remove:(DirectoryModel *)target {
    if (!target) return NO;
    
    NSError* local;
    NSFetchRequest* request = [[NSFetchRequest alloc] init];
    NSEntityDescription* desc = [NSEntityDescription entityForName:@"Directory" inManagedObjectContext:_context];
    
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"identifier = %@", [target identifier]];
    
    [request setEntity:desc];
    [request setPredicate:predicate];
    
    NSArray* arr = [_context executeFetchRequest:request error: &local];
    
    if (local) {
        NSLog(@"Could not Find data in datastore: %@", [local localizedDescription]);
        return NO;
    }
    
    [arr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        Directory* dir = (Directory*)obj;
        [dir setActive:0];
    }];
    
    if (![_context save:&local]) {
        NSLog(@"Error persisting delete, %@", [local localizedDescription]);
        return NO;
    }
    
    return YES;
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
