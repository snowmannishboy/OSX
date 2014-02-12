//
//  BrowserItem.h
//  I4
//
//  Created by Robert Novak on 2/9/14.
//  Copyright (c) 2014 Robert Novak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Quartz/Quartz.h>



@interface BrowserItem : NSObject

@property NSString* identifier;
@property NSURL* path;

- (id) initWithPath: (NSString*) path;

- (NSString*) imageUID;
- (NSString*) imageRepresentationType;
- (id) imageRepresentation;

@end
