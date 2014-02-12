//
//  Directory.h
//  I5
//
//  Created by Robert Novak on 2/10/14.
//  Copyright (c) 2014 Robert Novak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface Directory : NSManagedObject

@property (nonatomic, retain) NSString * identifier;
@property (nonatomic, retain) NSData * bookmark;

@end
