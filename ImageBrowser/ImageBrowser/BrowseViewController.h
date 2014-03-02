//
//  BrowseViewController.h
//  ImageBrowser
//
//  Created by Robert Novak on 2/16/14.
//  Copyright (c) 2014 Robert Novak. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class IKImageBrowserView;
@class DirectoryModel;
@class ImageBrowserModel;


@interface BrowseViewController : NSViewController {
    
}

@property (readonly, strong, nonatomic) DirectoryModel* cwd;

@property (strong, nonatomic) NSMutableArray* images;
@property (strong, nonatomic) NSMutableArray* imported;
@property (strong, nonatomic) NSIndexSet* selectionIndexes;

@property (strong, nonatomic) NSRegularExpression* fileCheck;

@property (strong, nonatomic) IBOutlet NSScrollView* scrollView;
@property (strong, nonatomic) IBOutlet IKImageBrowserView* browseView;

+ (void) setAction: (SEL) action target: (id) target;

- (void) openDirectory:(DirectoryModel*) directory;
- (void) clearDirectory;

- (ImageBrowserModel*) next;
- (ImageBrowserModel*) previous;

@end
