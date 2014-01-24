//
//  BrowseViewController.m
//  gifs
//
//  Created by Robert Novak on 1/22/14.
//  Copyright (c) 2014 Robert Novak. All rights reserved.
//

#import "BrowseViewController.h"


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

@interface BrowseViewController ()

@end

@implementation BrowseViewController

@synthesize imageBrowser = _imageBrowser;
@synthesize inner = _inner;
@synthesize outer = _outer;
@synthesize images = _images;
@synthesize zoom = _zoom;
@synthesize zoomValue = _zoomValue;

- (id) init {
    self = [super init];
    NSArray* topLevelObjects = [NSArray arrayWithObjects: _imageBrowser, _inner, nil];
    [[NSBundle mainBundle] loadNibNamed:@"BrowseView" owner:self topLevelObjects:&topLevelObjects];
    return self;
    
}

- (void) awakeFromNib {
    _images = [[NSMutableArray alloc] init];
    _importedImages = [[NSMutableArray alloc] init];
    [_inner setHidden:YES];
}

- (IBAction)doubleClick:(NSUInteger) index {
    [_controller selectImage:[_images objectAtIndex:index]];
}



- (void) addPath:(NSString *)path {
    NSError* local = nil;
    NSArray* directoryContents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:&local];
    
    NSRegularExpression* imageChecker = [NSRegularExpression regularExpressionWithPattern:@"^.+\\.(png|jpg|gif|jpeg)$" options:NSRegularExpressionCaseInsensitive error:&local];
    
    [directoryContents enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSString* filename = (NSString*)obj;
        NSMutableString* wholePath = [NSMutableString stringWithFormat:@"%@/%@", path, filename];
        
        NSUInteger valid = [imageChecker numberOfMatchesInString:filename options:0 range:NSMakeRange(0, [filename length])];
                                      
        if (valid > 0) {
        
            ImageObject* new = [[ImageObject alloc] init];
            [new setPath:wholePath];
            [_importedImages addObject:new];
            
        }
        
    }];
    
    [self updateDataSource];
    
}

- (void) removeAll {
    
    [_images removeAllObjects];
    [_imageBrowser reloadData];
    
}


- (IBAction)backButton:(id)sender {
    [self removeAll];
    [_controller backClick:self];
}

- (void) setController:(id)controller {
    _controller = controller;
}

- (NSUInteger) numberOfItemsInImageBrowser:(IKImageBrowserView *) aBrowser {
    return [_images count];
}

- (id) imageBrowser:(IKImageBrowserView *) aBrowser itemAtIndex:(NSUInteger)index {
    return [_images objectAtIndex:index];
}

- (void) updateDataSource {
    [_images addObjectsFromArray:_importedImages];
    [_importedImages removeAllObjects];
    [_imageBrowser reloadData];
}

- (void) add:(NSView *)superView {
    
    _outer = superView;
    
    [_inner setFrame: [_outer bounds]];
    
    [_inner setAutoresizesSubviews:YES];
    [_inner setAutoresizingMask:NSViewWidthSizable|NSViewHeightSizable];
    [_inner setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [_outer addSubview:_inner];
    
    [_outer addConstraint:[NSLayoutConstraint constraintWithItem:_outer attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:_inner attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0]];
    
    [_outer addConstraint: [NSLayoutConstraint constraintWithItem:_outer attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem: _inner attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0]];
    
}

- (void) imageBrowser:(IKImageBrowserView *) aBrowser removeItemsAtIndexes:(NSIndexSet *) indexes {
    [indexes enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
       [_images removeObjectAtIndex:idx];
    }];
}


@end



