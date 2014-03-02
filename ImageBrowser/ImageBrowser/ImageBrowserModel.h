//
//  ImageBrowserModel.h
//  ImageBrowser
//
//  Created by Robert Novak on 2/16/14.
//  Copyright (c) 2014 Robert Novak. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageBrowserModel : NSObject {
    NSString* uuid;
}

- (id) initWithData: (NSString*) path name: (NSString*) name;
- (void) dealloc;

@property NSString* path;
@property NSString* name;

@end
