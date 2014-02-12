//
//  ImageModel.h
//  I5
//
//  Created by Robert Novak on 2/11/14.
//  Copyright (c) 2014 Robert Novak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Quartz/Quartz.h>

@interface ImageModel : NSObject

- (id) initWithURL: (NSURL*) url;

@property (nonatomic, readonly) NSString  *imageUID;
@property (nonatomic, readonly) NSString  *imageRepresentationType;
@property (nonatomic, readonly) NSString  *imageTitle;
@property (nonatomic, readonly) NSURL     *imageRepresentation;

@end
