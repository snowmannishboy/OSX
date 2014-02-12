//
//  DirectoryModel.m
//  I4
//
//  Created by Robert Novak on 2/9/14.
//  Copyright (c) 2014 Robert Novak. All rights reserved.
//

#import "DirectoryModel.h"
#import <uuid/uuid.h>


@implementation DirectoryModel

- (id) init {
    self = [super init];
    if (self) {
        uuid_t newId;
        char    c_str[37];
        NSString* identifier;
        
        uuid_generate(newId);
        
        if (uuid_is_null(newId)) {
            NSLog(@"Error Generating New Id");
        }
        
        uuid_unparse(newId, c_str);
        identifier = [NSString stringWithUTF8String:c_str];
        
        _identifier = identifier;
    }
    return self;
}

- (id) initWithData: (NSString*) identifier display: (NSString*) display path: (NSString*) path scopedBookmark: (NSData*) bookmark {
    self = [super init];
    NSError* local;
    BOOL bookmarkDataIsStale;
    _identifier = identifier;
    _display = display;
    _path = path;
    _url = [NSURL URLByResolvingBookmarkData:bookmark options:NSURLBookmarkResolutionWithSecurityScope relativeToURL:nil bookmarkDataIsStale:&bookmarkDataIsStale error:&local];
    if (!_url) {
        NSLog(@"%@", [local localizedDescription]);
    }
    return self;
}

- (id) initWithPath:(NSString *)path {
    self = [super init];
    if (self) {
        NSError* local;
        NSURL* fileUrl = [NSURL fileURLWithPath:path];
        if (!fileUrl) {
            NSLog(@"Error");
            return nil;
        }
        
        _display = [[NSFileManager defaultManager] displayNameAtPath:path];
        _path = path;
        _url = fileUrl;
        _securityScopedBookmark =  [fileUrl bookmarkDataWithOptions: NSURLBookmarkCreationWithSecurityScope includingResourceValuesForKeys:nil relativeToURL:nil error:&local];
        
        if (!_securityScopedBookmark || local) {
            NSLog(@"Error bookmarking it: %@", [local localizedDescription]);
        }
        
    }
    return self;
}


@end
