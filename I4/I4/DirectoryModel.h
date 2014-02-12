//
//  DirectoryModel.h
//  I4
//
//  Created by Robert Novak on 2/9/14.
//  Copyright (c) 2014 Robert Novak. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DirectoryModel : NSObject

@property NSString* identifier;
@property NSString* display;
@property NSString* path;
@property NSURL*    url;
@property NSData*   securityScopedBookmark;

- (id) init;
- (id) initWithPath: (NSString*) path;
- (id) initWithData: (NSString*) identifier display: (NSString*) display path: (NSString*) path scopedBookmark: (NSData*) bookmark;


@end
