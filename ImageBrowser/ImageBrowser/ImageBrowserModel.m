//
//  ImageBrowserModel.m
//  ImageBrowser
//
//  Created by Robert Novak on 2/16/14.
//  Copyright (c) 2014 Robert Novak. All rights reserved.
//

#import "ImageBrowserModel.h"
#import <Quartz/Quartz.h>
#include <uuid/uuid.h>

@interface ImageBrowserModel ()
- (NSString*) generateUUID;
@end

@implementation ImageBrowserModel


- (id) init {
    self = [super init];
    if (self) {
        uuid = [self generateUUID];
    }
    return self;
}

- (id) initWithData:(NSString *)path name:(NSString *)name {
    
    if (!path) return nil;
    
    self = [super init];
    if (self) {
        uuid = [self generateUUID];
        if (!uuid) uuid = path;
        _path = path;
        _name = name;
    }
    return self;
}

- (id) imageRepresentation {
    return _path;
}

- (NSString*) imageRepresentationType {
    return IKImageBrowserPathRepresentationType;
}

- (NSString*) imageTitle {
    return _name;
}

- (NSString*) imageUID {
    return uuid;
}

- (NSString*) generateUUID {
    uuid_t parsed;
    char*  unparsed;
    NSString* result;
    
    
    uuid_generate(parsed);
    
    if (uuid_is_null(parsed)) return nil;
    
    unparsed = (char*) malloc(37 * sizeof(char));
    
    uuid_unparse(parsed, unparsed);
    
    result = [NSString stringWithUTF8String:unparsed];
    
    free(unparsed);
    
    return result;
}

- (void) dealloc {
    uuid = nil;
    _path = nil;
    _name = nil;
}

@end
