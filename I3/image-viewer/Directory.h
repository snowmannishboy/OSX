//
//  Directory.h
//  image-viewer
//
//  Created by Robert Novak on 2/8/14.
//  Copyright (c) 2014 Robert Novak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Directory : NSManagedObject

@property (nonatomic, retain) NSString * path;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * identifier;

@end
