//
//  Scheme.h
//  Images
//
//  Created by Robert Novak on 1/15/14.
//  Copyright (c) 2014 Robert Novak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Classifier;

@interface Scheme : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *classifiers;
@end

@interface Scheme (CoreDataGeneratedAccessors)

- (void)addClassifiersObject:(Classifier *)value;
- (void)removeClassifiersObject:(Classifier *)value;
- (void)addClassifiers:(NSSet *)values;
- (void)removeClassifiers:(NSSet *)values;

@end
