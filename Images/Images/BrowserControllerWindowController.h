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

-(IBAction) addImageButtonClicked:(id) sender;

@property (weak) IBOutlet IKImageBrowserView *mImageBrowser;



@end
