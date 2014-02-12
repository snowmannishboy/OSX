//
//  NSViewController+MaximizedInSuper.h
//  I4
//
//  Created by Robert Novak on 2/9/14.
//  Copyright (c) 2014 Robert Novak. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NSViewController (MaximizedInSuper)
- (void) maximizeViewInParent: (NSView*) parent;
@end
