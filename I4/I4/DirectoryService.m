//
//  DirectoryService.m
//  I4
//
//  Created by Robert Novak on 2/9/14.
//  Copyright (c) 2014 Robert Novak. All rights reserved.
//

#import "DirectoryService.h"
#import "DirectoryModel.h"

static SEL _action;
static id _target;


@implementation DirectoryService

+ (void) setAction:(SEL)action target:(id)target {
    _action = action;
    _target = target;
}

- (id) init {
    self = [super init];
    return self;
}

- (void) awakeFromNib {
    _context = [_delegate managedObjectContext];
    if (!_action && !_target) return;
    
    IMP implementation = [_target methodForSelector:_action];
    void (*method) (id, SEL, id) = (void*) implementation;
    method(_target, _action, self);
    
}

- (NSArray*) load {
    if (!_context) return nil;
    
    NSError* local = nil;
    NSFetchRequest* request = [[NSFetchRequest alloc] init];
    NSEntityDescription* sth = [NSEntityDescription entityForName:@"Directory" inManagedObjectContext:_context];
    
    [request setEntity:sth];
    
    NSArray* loadedData = [_context executeFetchRequest:request error:&local];
    
    if (!loadedData) {
        NSLog(@"Error loading data: %@", [local localizedDescription]);
        return nil;
    }
    
    NSMutableArray* result = [[NSMutableArray alloc] initWithCapacity:[loadedData count]];
    
    [loadedData enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        Directory* directory = (Directory*) obj;
        DirectoryModel* newObject = [[DirectoryModel alloc] initWithData:[directory identifier] display:[directory name] path:[directory path] scopedBookmark:[directory bookmark]];
        [result addObject:newObject];
    }];
    
    [result sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        NSString* name1 = [(DirectoryModel*)obj1 display];
        NSString* name2 = [(DirectoryModel*)obj2 display];
        return [name1 compare:name2];
    }];
    
    
    return result;
}

- (void) save: (DirectoryModel*) obj {
    
    NSError* local;
    Directory* insert = [NSEntityDescription insertNewObjectForEntityForName:@"Directory" inManagedObjectContext:_context];
    
    [insert setIdentifier:[obj identifier]];
    [insert setPath:[obj path]];
    [insert setName:[obj display]];
    [insert setBookmark:[obj securityScopedBookmark]];

    if (![_context save:&local]) {
        NSLog(@"Exception saving error: %@", [local localizedDescription]);
    }
    
}

@end
