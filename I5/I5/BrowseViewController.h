//
//  BrowseViewController.h
//  I5
//
//  Created by Robert Novak on 2/11/14.
//  Copyright (c) 2014 Robert Novak. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <Quartz/Quartz.h>

@class DirectoryModel;
@class ImageModel;

@interface BrowseViewController : NSViewController {
    __strong DirectoryModel         *_directory;
    __strong NSRegularExpression    *_fileCheck;
}

@property (atomic, strong) NSMutableArray* images;
@property (atomic, strong) NSMutableArray* importedImages;

@property (atomic, strong) NSIndexSet* selectedIndexes;

@property (nonatomic, strong) IBOutlet NSView* inner;
@property (nonatomic, strong) IBOutlet IKImageBrowserView* browserView;

- (void) clear;
- (void) open: (DirectoryModel*) directory;

/* Methods for "informal" delegate */
- (void)imageBrowser:(IKImageBrowserView *)aBrowser cellWasDoubleClickedAtIndex:(NSUInteger)index;

- (ImageModel*) next;
- (ImageModel*) previous;


// method for setting an action

+ (void) setAction: (SEL) action target: (id) target;

@end
