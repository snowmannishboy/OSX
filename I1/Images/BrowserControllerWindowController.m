//
//  BrowserControllerWindowController.m
//  Images
//
//  Created by Robert Novak on 1/16/14.
//  Copyright (c) 2014 Robert Novak. All rights reserved.
//

#import "BrowserControllerWindowController.h"

@interface ImageObject : NSObject {
    NSString* mPath;
}
@end

@implementation ImageObject

- (void) setPath: (NSString*) path {
    if (mPath != path) mPath = path;
}

- (NSString *)  imageRepresentationType

{
    
    return IKImageBrowserPathRepresentationType;
    
}



- (id)  imageRepresentation

{
    
    return mPath;
    
}



- (NSString *) imageUID

{
    return mPath;
    
}

@end



@implementation BrowserControllerWindowController


@synthesize mImageBrowser;
@synthesize mImages;

- (id)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    if (self) {
        
    }
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    [mImageBrowser setCanControlQuickLookPanel:NO];
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}


- (void) awakeFromNib

{
    
    mImages = [[NSMutableArray alloc] init];
    
    mImportedImages = [[NSMutableArray alloc] init];
    
    [mImageBrowser setAnimates:YES];
    
}

- (void) updateDatasource

{
    
    [mImages addObjectsFromArray:mImportedImages];
    
    [mImportedImages removeAllObjects];
    
    [mImageBrowser reloadData];
    
}

- (void) removeAll {
    [mImages removeAllObjects];
    [mImageBrowser reloadData];
}

- (NSUInteger) numberOfItemsInImageBrowser:(IKImageBrowserView *) view

{
    
    return [mImages count];
    
}



- (id) imageBrowser:(IKImageBrowserView *) view itemAtIndex:(NSUInteger) index

{
    
    return [mImages objectAtIndex:index];
    
}

static NSArray *openFiles()

{
    
    NSOpenPanel *panel;
    
    panel = [NSOpenPanel openPanel];
    
    [panel setFloatingPanel:YES];
    
    [panel setCanChooseDirectories:YES];
    
    [panel setCanChooseFiles:YES];
    
    long i = [panel runModal];
    
    if(i == NSOKButton){
        
        return [panel URLs];
        
    }
    
    return nil;
    
}


- (void) addAnImageWithPath:(NSString *) path

{
    
    ImageObject *p;
    
    p = [[ImageObject alloc] init];
    
    [p setPath:path];
    
    [mImportedImages addObject:p];
    
}

- (void) refresh {
    NSLog(@"%@", mImageBrowser);
}


- (void) addImagesWithPath:(NSString *) path recursive:(BOOL) recursive

{
    long i, n;
    
    BOOL dir = NO;
    
    [[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:&dir];
    
    if(dir){
        NSError* err = nil;

        NSArray *content = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error: &err];
        
        
        n = [content count];
        
        for(i=0; i<n; i++){
            
            if(recursive)
                
                [self addImagesWithPath:
                 
                 [path stringByAppendingPathComponent:
                  
                  [content objectAtIndex:i]]
                 
                              recursive:NO];
            
            else
                
                [self addAnImageWithPath:
                 
                 [path stringByAppendingPathComponent:
                  
                  [content objectAtIndex:i]]];
            
        }
        
    }
    
    else
        
        [self addAnImageWithPath:path];
    
}

- (void) addImagesWithPaths:(NSArray *) paths

{
    
    long i, n;
    
    
    
    n = [paths count];
    
    for(i=0; i<n; i++){
        
        NSURL* url = [paths objectAtIndex:i];
        NSString* path = [url path];
        
        [self addImagesWithPath:path recursive:YES];
        
    }
    
    
    
    [self performSelectorOnMainThread:@selector(updateDatasource)
     
                           withObject:nil
     
                        waitUntilDone:YES];
    
    
    
}

- (IBAction) addImageButtonClicked:(id) sender

{
    
    NSArray *path = openFiles();
    
    
    
    if(!path){
        
        NSLog(@"No path selected, return...");
        
        return;
        
    }
    
    [NSThread detachNewThreadSelector:@selector(addImagesWithPaths:) toTarget:self withObject:path];
    
}

- (NSMutableArray*) mImportedImages {
    return mImportedImages;
}

- (void) setMImportedImages:(NSMutableArray *)images {
    mImportedImages = images;
}
@end
