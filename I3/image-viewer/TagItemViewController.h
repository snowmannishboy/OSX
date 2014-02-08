//
//  TagItemViewController.h
//  image-viewer
//
//  Created by Robert Novak on 2/6/14.
//  Copyright (c) 2014 Robert Novak. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@protocol TagItemProtocol <NSObject>
- (void) tagItemClicked: (id) sender;
@end

@interface TagItemViewController : NSCollectionViewItem

@property (strong) NSString* tagId;
@property IBOutlet NSTextField* tagName;
@property IBOutlet NSBox* box;

- (BOOL) selected;

+ (void) setDelegate: (id<TagItemProtocol>) delegate;

@end
