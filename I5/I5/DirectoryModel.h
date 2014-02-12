//
//  DirectoryModel.h
//  I5
//
//  Created by Robert Novak on 2/10/14.
//  Copyright (c) 2014 Robert Novak. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DirectoryModel : NSObject

@property NSString  *identifier;
@property NSURL     *url;
@property NSString  *path;
@property NSString  *display;
@property NSData    *bookmark;


- (id) initWithURL  : (NSURL*) url;
- (id) initWithData : (NSString*) identifier bookmark: (NSData*) bookmark;


@end
