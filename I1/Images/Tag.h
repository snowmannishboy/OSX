//
//  Tag.h
//  Images
//
//  Created by Robert Novak on 1/15/14.
//  Copyright (c) 2014 Robert Novak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Classifier, Image;

@interface Tag : NSManagedObject

@property (nonatomic, retain) Classifier *classifier;
@property (nonatomic, retain) Image *image;

@end
