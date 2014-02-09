//
//  DirectoryHelper.m
//  image-viewer
//
//  Created by Robert Novak on 2/8/14.
//  Copyright (c) 2014 Robert Novak. All rights reserved.
//

#import "DirectoryHelper.h"

@implementation DirectoryHelper

@synthesize context = _context;
@synthesize delegate = _delegate;
@synthesize controller = _controller;

-(id) init {
    self = [super init];
    if (self) {
    }
    return self;
}


- (NSArray*) load {
    if (!_context) { if (_delegate) { _context = [_delegate managedObjectContext]; if (!_context) return nil; } }
    NSError* localError;
    NSFetchRequest* request = [[NSFetchRequest alloc] init];
    NSEntityDescription* description = [NSEntityDescription entityForName:@"Directory" inManagedObjectContext:_context];
    
    [request setEntity:description];
    
    NSArray* savedData = [_context executeFetchRequest:request error:&localError];
    
    if (savedData) {
        NSMutableArray* result = [[NSMutableArray alloc] initWithCapacity:[savedData count]];
        [savedData enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            Directory* target = (Directory*) obj;
            if ([target identifier]) {
                NSMutableDictionary* data = [[NSMutableDictionary alloc] initWithCapacity:3];
                [data setObject:[target identifier] forKey:@"identifier"];
                [data setObject:[target path] forKey: @"path"];
                [data setObject:[target name] forKey: @"name"];
                [result insertObject:data atIndex:idx];
            }
        }];
        if (result) {
            [result sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
                NSString* n1 = (NSString*) [obj1 objectForKey:@"name"];
                NSString* n2 = (NSString*) [obj2 objectForKey:@"name"];
                return [n1 compare: n2 options: NSCaseInsensitiveSearch];
            }];
        }
        if (result) return result;
    }
    return nil;
}

- (void) save:(NSDictionary *)obj {
    if (!_context || !obj) return;
    
    uuid_t identifier;
    uuid_generate_random(identifier);
    char data[38];
    uuid_unparse(identifier, data);
    NSString* ident = [NSString stringWithUTF8String:data];
    
    Directory* newObject = [NSEntityDescription insertNewObjectForEntityForName:@"Directory" inManagedObjectContext:_context];
    
    [newObject setIdentifier:ident];
    [newObject setPath:(NSString*)[obj valueForKey:@"path"]];
    [newObject setName:(NSString*)[obj valueForKey:@"name"]];
    
    NSError* local;
    
    if (![_context save:&local]) {
        NSLog(@"Error Saving Local Value");
    }
    
}


- (void) delete:(NSString *)identifier {
    if (!identifier) return;
    
    NSFetchRequest* request = [[NSFetchRequest alloc] init];
    NSEntityDescription* desc = [NSEntityDescription entityForName:@"Directory" inManagedObjectContext:_context];
    
    [request setEntity:desc];
    
    NSPredicate* query = [NSPredicate predicateWithFormat:@"identifier = %@", identifier];
    
    [request setPredicate:query];
    
    NSError* local;
    NSArray* matchingObjects = [_context executeFetchRequest:request error:&local];
    
    if (!matchingObjects || local) {
        NSLog(@"Error Finding Relavent Data: %@", [local localizedDescription]);
        return;
    }
    
    [matchingObjects enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSError* extremelyLocal;
        [_context deleteObject:obj];
        if (![_context save:&extremelyLocal]) {
            NSLog(@"Exception committing file removal, %@", [extremelyLocal localizedDescription]);
        }
        *stop = YES;
    }];
    
}


- (void) awakeFromNib {
    _context = [_delegate managedObjectContext];
}

@end
