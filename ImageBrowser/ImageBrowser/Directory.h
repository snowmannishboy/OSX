//
//  Directory.h
//  ImageBrowser
//
//  Created by Robert Novak on 2/16/14.
//  Copyright (c) 2014 Robert Novak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Directory : NSManagedObject

@property (nonatomic, retain) NSData * bookmark;

@end
