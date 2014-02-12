//
//  BrowserItem.m
//  I4
//
//  Created by Robert Novak on 2/9/14.
//  Copyright (c) 2014 Robert Novak. All rights reserved.
//

#import "BrowserItem.h"
#import <uuid/uuid.h>

@implementation BrowserItem

- (id) init {
    self = [super init];
    if (self) {
        char c_str[37];
        uuid_t id;
        uuid_generate(id);
        
        if (uuid_is_null(id)) return self;
        
        uuid_unparse(id, c_str);
        
        _identifier = [NSString stringWithUTF8String:c_str];
        
    }
    return self;
}

- (id) initWithPath:(NSString *)path {
    self = [super init];
    if (self) {
        uuid_t uuid;
        char   unparsed[37];
        
        uuid_generate_random(uuid);
        
        if (uuid_is_null(uuid)) return self;
        
        uuid_unparse(uuid, unparsed);
        
        _identifier = [NSString stringWithUTF8String:unparsed];
        
        _path = [NSURL fileURLWithPath:path];
        
    }
    return self;
}

- (NSString*) imageUID {
    return _identifier;
}

- (NSString*) imageRepresentationType {
    return IKImageBrowserNSURLRepresentationType;
}

- (id) imageRepresentation {
    return _path;
}

@end
