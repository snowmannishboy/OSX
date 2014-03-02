//
//  DirectoryModel.m
//  ImageBrowser
//
//  Created by Robert Novak on 2/16/14.
//  Copyright (c) 2014 Robert Novak. All rights reserved.
//

#import "DirectoryModel.h"

@implementation DirectoryModel

- (id) initWithURL:(NSURL *)url {
    
    if (!url) return nil;
    
    self = [super init];
    if (self) {
        NSError* local;
        _path = [url path];
        _display = [[NSFileManager defaultManager] displayNameAtPath:_path];
        _bookmark = [url bookmarkDataWithOptions:NSURLBookmarkCreationWithSecurityScope includingResourceValuesForKeys:nil relativeToURL:nil error:&local];
        
        if (local) {
            NSLog(@"[%@] Error Bookmarking Data - %@", [self class], [local localizedDescription]);
            return nil;
        }
        
        _url = [NSURL URLByResolvingBookmarkData:_bookmark options:NSURLBookmarkResolutionWithSecurityScope relativeToURL:nil bookmarkDataIsStale:nil error:&local];
        
    }
    return self;
}

- (id) initWithData:(NSManagedObjectID *)identifier bookmark:(NSData *)bookmark {
    self = [super init];
    if (!identifier || !bookmark) {
        NSLog(@"[%@] Value was nil", [self class]);
        self = nil;
        return nil;
    }
    if (self) {
        BOOL isStale;
        NSError* error;
        _url = [NSURL URLByResolvingBookmarkData:bookmark options:NSURLBookmarkResolutionWithSecurityScope relativeToURL:nil bookmarkDataIsStale:&isStale error:&error];
        _bookmark = bookmark;
        _path = [_url path];
        _display = [[NSFileManager defaultManager] displayNameAtPath:_path];
        _identifier = identifier;
    }
    return self;
}

@end
