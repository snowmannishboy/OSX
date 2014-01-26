//
//  DirectoryService.m
//  gifs
//
//  Created by Robert Novak on 1/26/14.
//  Copyright (c) 2014 Robert Novak. All rights reserved.
//

#import "DirectoryService.h"

@implementation DirectoryService

@synthesize context = _context;

- (NSMutableArray*) load {
    
    NSMutableArray* result = nil;
    NSError* local = nil;
    NSFetchRequest* request = [[NSFetchRequest alloc] init];
    NSEntityDescription* sth = [NSEntityDescription entityForName:@"Directory" inManagedObjectContext:_context];
    
    [request setEntity:sth];
    
    NSArray* data = [_context executeFetchRequest:request error:&local];
    
    if (data != nil) {
        NSUInteger size = [data count];
        result = [[NSMutableArray alloc] initWithCapacity: size];
        [data enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            Directory* object = (Directory*) obj;
            NSDictionary* dict = [NSDictionary dictionaryWithObjectsAndKeys:[object path], @"filename", nil];
            [result addObject:dict];
        }];
    }
    
    return result;
}

- (void) add:(NSString *)directory {
    if (directory == nil) return;
    
    NSError* local = nil;
    Directory* dir = [NSEntityDescription insertNewObjectForEntityForName:@"Directory" inManagedObjectContext:_context];
    
    [dir setPath: directory];
    
    if (![_context save: &local]) {
        NSLog(@"There was an Error saving your shit, %@", [local localizedDescription]);
    }
    
}

- (void) remove:(NSString *)directory {
    NSError* local = nil;
    NSFetchRequest* request = [[NSFetchRequest alloc] init];
    NSEntityDescription* sth = [NSEntityDescription entityForName:@"Directory" inManagedObjectContext:_context];
    
    NSPredicate* query = [NSPredicate predicateWithFormat:@"path = ?", directory];
    
    [request setEntity:sth];
    [request setPredicate:query];
    
    NSArray* data = [_context executeFetchRequest:request error:&local];
    
    if (data != nil) {
        [data enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [_context deleteObject:obj];
        }];
    }
    
    if (![_context save:&local]) {
        NSLog(@"There was an error deleting your shit, %@", [local localizedDescription]);
    }
    
}


@end
