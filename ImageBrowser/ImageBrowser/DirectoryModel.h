//
//  DirectoryModel.h
//  ImageBrowser
//
//  Created by Robert Novak on 2/16/14.
//  Copyright (c) 2014 Robert Novak. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DirectoryModel : NSObject

@property (nonatomic, strong) NSManagedObjectID* identifier;
@property (nonatomic, strong) NSString* path;
@property (nonatomic, strong) NSURL* url;
@property (nonatomic, strong) NSString* display;
@property (nonatomic, strong) NSData* bookmark;

- (id) initWithURL: (NSURL*) url;
- (id) initWithData: (NSManagedObjectID*) identifier bookmark: (NSData*) bookmark;

@end
