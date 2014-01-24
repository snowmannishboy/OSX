//
//  BrowseViewController.h
//  gifs
//
//  Created by Robert Novak on 1/22/14.
//  Copyright (c) 2014 Robert Novak. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <Quartz/Quartz.h>

@protocol BrowseViewControllerProtocol
- (void) backClick: (id) sender;
- (void) selectImage: (id) sender;
@end

@interface ImageObject : NSObject {
    NSString* mPath;
}
- (NSString *)  imageRepresentationType;
- (id)  imageRepresentation;
- (NSString *) imageUID;

@end

@interface BrowseViewController : NSViewController {
    id _controller;
    NSMutableArray* _images;
    NSMutableArray* _importedImages;
    IKImageBrowserView* _imageBrowser;
    
}
@property float zoomValue;
@property IBOutlet id browseViewDelegate;
@property IBOutlet NSView* outer;
@property IBOutlet NSView* inner;
@property IBOutlet IKImageBrowserView* imageBrowser;
@property IBOutlet NSSlider* zoom;

@property NSMutableArray* images;

- (IBAction)backButton:(id)sender;

- (IBAction)doubleClick:(NSUInteger) index;

- (void) updateDataSource;

- (void) setController: (id) controller;

- (void) addPath: (NSString*) path;

- (void) removeAll;

- (void) imageBrowser:(IKImageBrowserView *) aBrowser removeItemsAtIndexes:(NSIndexSet *) indexes; 

- (NSUInteger) numberOfItemsInImageBrowser:(IKImageBrowserView *) aBrowser;

- (id) imageBrowser:(IKImageBrowserView *) aBrowser itemAtIndex:(NSUInteger)index;

- (void) add: (NSView*) superView;

@end
