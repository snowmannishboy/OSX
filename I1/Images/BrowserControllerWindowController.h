//
//  BrowserControllerWindowController.h
//  Images
//
//  Created by Robert Novak on 1/16/14.
//  Copyright (c) 2014 Robert Novak. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <Quartz/Quartz.h>

@interface BrowserControllerWindowController : NSWindowController {
    NSMutableArray* mImages;
    NSMutableArray* mImportedImages;
}

-(void) removeAll;

- (void) addAnImageWithPath:(NSString *) path;

- (void) refresh;

- (NSMutableArray*) mImportedImages;

- (void) updateDatasource;

- (void) setMImportedImages: (NSMutableArray*) images;

-(IBAction) addImageButtonClicked:(id) sender;

@property IBOutlet IKImageBrowserView *mImageBrowser;

@property NSMutableArray* mImages;


@end
