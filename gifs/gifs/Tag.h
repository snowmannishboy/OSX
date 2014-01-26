//
//  Tag.h
//  gifs
//
//  Created by Robert Novak on 1/23/14.
//  Copyright (c) 2014 Robert Novak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Image;

@interface Tag : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *images;
@end

@interface Tag (CoreDataGeneratedAccessors)

- (void)addImagesObject:(Image *)value;
- (void)removeImagesObject:(Image *)value;
- (void)addImages:(NSSet *)values;
- (void)removeImages:(NSSet *)values;

@end
