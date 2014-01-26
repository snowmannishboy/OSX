//
//  Image.h
//  gifs
//
//  Created by Robert Novak on 1/23/14.
//  Copyright (c) 2014 Robert Novak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Directory, Tag;

@interface Image : NSManagedObject

@property (nonatomic, retain) NSString * filename;
@property (nonatomic, retain) NSSet *tags;
@property (nonatomic, retain) Directory *directory;
@end

@interface Image (CoreDataGeneratedAccessors)

- (void)addTagsObject:(Tag *)value;
- (void)removeTagsObject:(Tag *)value;
- (void)addTags:(NSSet *)values;
- (void)removeTags:(NSSet *)values;

@end
