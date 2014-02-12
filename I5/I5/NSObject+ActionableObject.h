//
//  NSObject+ActionableObject.h
//  I5
//
//  Created by Robert Novak on 2/10/14.
//  Copyright (c) 2014 Robert Novak. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (ActionableObject)
- (void) setAction: (SEL) action target: (id) target;
- (void) sendAction;
@end
