//
//  BrowseViewController.h
//  image-viewer
//
//  Created by Robert Novak on 2/5/14.
//  Copyright (c) 2014 Robert Novak. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <Quartz/Quartz.h>

@interface bvImage : NSObject
- (NSString*) imageUID;
- (NSString*) imageRepresentationType;
- (id)        imageRepresentation;
@property NSString* path;
@end

@protocol BrowserViewProtocol <NSObject>
- (void) imageWasDoubleClicked: (bvImage*) target;
@end

@interface BrowseViewController : NSViewController {
    NSRegularExpression* fileChecker;

}

@property IBOutlet NSView* inner;
@property IBOutlet IKImageBrowserView* browseView;

@property (strong) NSMutableArray* images;
@property (strong) NSIndexSet* selectedIndexes;

- (void) addPath: (NSString*) path;
- (void) clearPath;

- (bvImage*) moveForward;
- (bvImage*) moveBack;

- (void) imageBrowserSelectionDidChange:(IKImageBrowserView *)aBrowser;
- (void) imageBrowser:(IKImageBrowserView *)aBrowser backgroundWasRightClickedWithEvent:(NSEvent *)event;
- (void) imageBrowser:(IKImageBrowserView *)aBrowser cellWasDoubleClickedAtIndex:(NSUInteger)index;
- (void) imageBrowser:(IKImageBrowserView *)aBrowser cellWasRightClickedAtIndex:(NSUInteger)index withEvent:(NSEvent *)event;
- (void) imageBrowser:(IKImageBrowserView *)aBrowser removeItemsAtIndexes:(NSIndexSet *)indexes;

- (id) imageBrowser:(IKImageBrowserView *)aBrowser itemAtIndex:(NSUInteger)index;
- (NSUInteger) numberOfItemsInImageBrowser:(IKImageBrowserView *)aBrowser;

+ (void) setDelegate: (id<BrowserViewProtocol>) delegate;

@end
