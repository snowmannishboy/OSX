//
//  Classifier.h
//  Images
//
//  Created by Robert Novak on 1/15/14.
//  Copyright (c) 2014 Robert Novak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Scheme, Tag;

@interface Classifier : NSManagedObject

@property (nonatomic, retain) NSString * value;
@property (nonatomic, retain) Scheme *scheme;
@property (nonatomic, retain) NSSet *tags;
@end

@interface Classifier (CoreDataGeneratedAccessors)

- (void)addTagsObject:(Tag *)value;
- (void)removeTagsObject:(Tag *)value;
- (void)addTags:(NSSet *)values;
- (void)removeTags:(NSSet *)values;

@end
