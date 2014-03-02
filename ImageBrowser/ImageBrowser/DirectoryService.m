//
//  DirectoryService.m
//  ImageBrowser
//
//  Created by Robert Novak on 2/16/14.
//  Copyright (c) 2014 Robert Novak. All rights reserved.
//

#import "DirectoryService.h"
#import "Directory.h"
#import "DirectoryModel.h"


@implementation DirectoryService

- (void) save:(DirectoryModel *)model {
    
    if (!model) return;
    
    NSError* local;
    
    Directory* dir = [NSEntityDescription insertNewObjectForEntityForName:@"Directory" inManagedObjectContext:_context];
    [dir setBookmark:[model bookmark]];
    
    if (![_context save:&local]) {
        NSLog(@"[%@] Error saving: %@", [self class], [local localizedDescription]);
    }
    
    [model setIdentifier:[dir objectID]];

}

- (NSArray*) load {
    NSMutableArray* unsorted;
    NSArray* result;
    
    NSError* local;
    NSFetchRequest* request = [[NSFetchRequest alloc] init];
    NSEntityDescription* description = [NSEntityDescription entityForName:@"Directory" inManagedObjectContext:_context];
    
    [request setEntity:description];
    
    NSArray* data = [_context executeFetchRequest:request error:&local];
    
    if (local) {
        NSLog(@"[%@] Exception Loading Data: %@", [self class], [local localizedDescription]);
        return nil;
    }
    
    unsorted = [[NSMutableArray alloc] initWithCapacity:[data count]];
    
    [data enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        Directory* d = obj;
        DirectoryModel* model = [[DirectoryModel alloc] initWithData:[d objectID] bookmark:[d bookmark]];
        [unsorted addObject:model];
    }];
    
    
    result = [unsorted sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        NSString* name1 = [((DirectoryModel*)obj1) display];
        NSString* name2 = [((DirectoryModel*)obj2) display];
        return [name2 compare:name1];
    }];
    
    return result;
}


- (BOOL) delete: (DirectoryModel*) model {
    if (!model) return NO;
    
    BOOL result = YES;
    
    if ([model identifier]) {
        NSError* local;
        NSManagedObject* dir =[_context objectWithID:[model identifier]];
        [_context deleteObject:dir];
        if (![_context save: &local]) {
            NSLog(@"[%@] Error Saving Delete - %@", [self class], [local localizedDescription]);
            result = NO;
        }
        
    }
    return result;
}

@end







