//
//  Directory.h
//  I4
//
//  Created by Robert Novak on 2/9/14.
//  Copyright (c) 2014 Robert Novak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Directory : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSData * bookmark;
@property (nonatomic, retain) NSString * identifier;
@property (nonatomic, retain) NSString * path;

@end
