//
//  NSObject+ActionableObject.m
//  I5
//
//  Created by Robert Novak on 2/10/14.
//  Copyright (c) 2014 Robert Novak. All rights reserved.
//

#import "NSObject+ActionableObject.h"

static NSMutableDictionary* actions;
static NSMutableDictionary* targets;

@implementation NSObject (ActionableObject)

- (void) setAction: (SEL) action target: (id) target {
    if (actions == nil) {
        actions = [[NSMutableDictionary alloc] initWithCapacity:100];
    }
    if (targets == nil) {
        targets = [[NSMutableDictionary alloc] initWithCapacity:100];
    }
    NSString* key = NSStringFromClass([self class]);
    
    [actions setValue:NSStringFromSelector(action) forKey:key];
    [targets setValue:target forKey:key];
}

- (void) sendAction {
    NSString* key = NSStringFromClass([self class]);
    
    SEL selector = NSSelectorFromString([actions objectForKey:key]);
    id target = [targets objectForKey:key];
    
    if (selector && target) {
        IMP implementation = [target methodForSelector:selector];
        void (*function)(id, SEL, id) = (void*) implementation;
        function(target, selector, self);
    }
    
}
@end
