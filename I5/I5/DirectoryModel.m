//
//  DirectoryModel.m
//  I5
//
//  Created by Robert Novak on 2/10/14.
//  Copyright (c) 2014 Robert Novak. All rights reserved.
//

#import "DirectoryModel.h"
#import <uuid/uuid.h>

@implementation DirectoryModel

- (NSString*) generateUUID {
    NSString* identifier = nil;
    
    uuid_t uuid;
    char   unparsed[37];

    uuid_generate_random(uuid);
    
    if (uuid_is_null(uuid)) {
        NSLog(@"[%@] Error Generating UUID", [self class]);
        return nil;
    }
    
    uuid_unparse(uuid, unparsed);
    
    identifier = [NSString stringWithUTF8String:unparsed];
    
    return identifier;
}

- (id) initWithURL:(NSURL *)url {
    if (!url) return nil;
    
    self = [super init];
    if (self) {
        NSError* local;
        _path = [url path];
        _display = [[NSFileManager defaultManager] displayNameAtPath:_path];
        _url = url;
        _bookmark = [url bookmarkDataWithOptions:NSURLBookmarkCreationWithSecurityScope includingResourceValuesForKeys:nil relativeToURL:nil error:&local];
        _identifier = [self generateUUID];
    }
    return self;
}

- (id) initWithData:(NSString *)identifier bookmark:(NSData *)bookmark {
    if (!identifier || !bookmark) {
        NSLog(@"Shit Was Null");
        return nil;
    }
    
    self = [super init];
    if (self) {
        NSError* local;
        BOOL isStale;
        _identifier = identifier;
        
        _url = [NSURL URLByResolvingBookmarkData:bookmark options:NSURLBookmarkResolutionWithSecurityScope relativeToURL:nil bookmarkDataIsStale:&isStale error:&local];
        
        if (local) {
            NSLog(@"%@, Error resolving data, %@", [self class], [local localizedDescription]);
            return  nil;
        }
        
        _path = [_url path];
        _display = [[NSFileManager defaultManager] displayNameAtPath:_path];
        _bookmark = bookmark;
        
    }
    return self;
}

@end
