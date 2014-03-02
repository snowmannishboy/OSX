//
//  DirectoryItemViewController.h
//  ImageBrowser
//
//  Created by Robert Novak on 2/16/14.
//  Copyright (c) 2014 Robert Novak. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class ClickableBox;

@interface DirectoryItemViewController : NSCollectionViewItem

@property (nonatomic, strong) IBOutlet NSTextField* name;
@property (nonatomic, strong) IBOutlet ClickableBox* box;

@end
