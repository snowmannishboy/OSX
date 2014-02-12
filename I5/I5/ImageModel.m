//
//  ImageModel.m
//  I5
//
//  Created by Robert Novak on 2/11/14.
//  Copyright (c) 2014 Robert Novak. All rights reserved.
//
#import <uuid/uuid.h>
#import "ImageModel.h"

@implementation ImageModel

- (NSString*) generateUUID {
    uuid_t parsed;
    char   unparsed[37];
    
    uuid_generate_random(parsed);
    
    if (uuid_is_null(parsed)) return nil;
    
    uuid_unparse(parsed, unparsed);
    
    return [NSString stringWithUTF8String:unparsed];
}

- (id) initWithURL:(NSURL *)url {
    self = [super init];
    if (self) {
        _imageRepresentationType = IKImageBrowserNSURLRepresentationType;
        _imageRepresentation = url;
        _imageTitle = [url lastPathComponent];
        _imageUID = [self generateUUID];
    }
    return self;
}

@end
