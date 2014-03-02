//
//  NSViewController+MaximizedSubview.h
//  ImageBrowser
//
//  Created by Robert Novak on 2/16/14.
//  Copyright (c) 2014 Robert Novak. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NSViewController (MaximizedSubview)
- (void) maximizeInParent: (NSView*) parent;
@end
