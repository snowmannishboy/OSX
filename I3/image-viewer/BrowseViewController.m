//
//  BrowseViewController.m
//  image-viewer
//
//  Created by Robert Novak on 2/5/14.
//  Copyright (c) 2014 Robert Novak. All rights reserved.
//

#import "BrowseViewController.h"

@interface BrowseViewController ()

@end

static id<BrowserViewProtocol> _delegate;

@implementation BrowseViewController

@synthesize inner = _inner;
@synthesize browseView = _browseView;
@synthesize images = bvImages;
@synthesize selectedIndexes = indexes;

- (id) init {
    self = [super init];
    NSError* localError = nil;
    NSArray* topLevelObjects = nil;
    [[NSBundle mainBundle] loadNibNamed:@"BrowseView" owner:self topLevelObjects:&topLevelObjects];
    fileChecker = [NSRegularExpression regularExpressionWithPattern:@"^.+\\.(jpg|gif|png|jpeg)$" options:NSRegularExpressionCaseInsensitive error:&localError];
    
    [_browseView bind:@"selectionIndexes" toObject:self withKeyPath:@"selectedIndexes" options:nil];
    return self;
}

- (bvImage*) moveForward {
    bvImage* result = nil;
    NSUInteger total = [bvImages count];
    NSUInteger currentIndex = [indexes firstIndex];
    
    currentIndex = (currentIndex < (total - 1)) ? (currentIndex + 1) : 0;
    
    indexes = [[NSIndexSet alloc] initWithIndex:currentIndex];
    
    result = (bvImage*) [bvImages objectAtIndex:currentIndex];
    
    return result;
}

- (bvImage*) moveBack {
    bvImage* result = nil;
    NSUInteger total = [bvImages count];
    NSUInteger current = [indexes firstIndex];
    
    current = (current > 0) ? (current - 1) : (total - 1);
    
    result = (bvImage*) [bvImages objectAtIndex:current];
    
    indexes = [[NSIndexSet alloc] initWithIndex:current];
    
    return result;
}

- (void) awakeFromNib {
    [super awakeFromNib];
    [[self view] setHidden:YES];
    bvImages = [[NSMutableArray alloc] init];
    indexes = [[NSIndexSet alloc] init];
    
}

- (id) imageBrowser:(IKImageBrowserView *)aBrowser itemAtIndex:(NSUInteger)index {
    return [bvImages objectAtIndex:index];
}

- (NSUInteger) numberOfItemsInImageBrowser:(IKImageBrowserView *)aBrowser {
    return [bvImages count];
}

- (void) addPath:(NSString *)path {
    NSError* localError = nil;
    NSArray* contents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:&localError];
    [contents enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSString* filename = (NSString*) obj;
        if ([[fileChecker matchesInString:filename options:0 range:NSMakeRange(0, [filename length])] count] > 0l) {
            NSString* totalPath = [NSString stringWithFormat:@"%@/%@", path, filename];
            bvImage* newImage = [[bvImage alloc] init];
            [newImage setPath:totalPath];
            [bvImages addObject:newImage];
        }
    }];
    [_browseView reloadData];
}

- (void) clearPath {
    [bvImages removeAllObjects];
    [_browseView reloadData];
}


- (void) imageBrowser:(IKImageBrowserView *)aBrowser cellWasDoubleClickedAtIndex:(NSUInteger)index {
    [_delegate imageWasDoubleClicked:[bvImages objectAtIndex:index]];
}

- (void) imageBrowser:(IKImageBrowserView *)aBrowser cellWasRightClickedAtIndex:(NSUInteger)index withEvent:(NSEvent *)event {
    
}

- (void) imageBrowser:(IKImageBrowserView *)aBrowser backgroundWasRightClickedWithEvent:(NSEvent *)event {
    
}

- (void) imageBrowser:(IKImageBrowserView *)aBrowser removeItemsAtIndexes:(NSIndexSet *)indexes {
    
}

- (void) imageBrowserSelectionDidChange:(IKImageBrowserView *)aBrowser {
    
}

+ (void) setDelegate:(id<BrowserViewProtocol>)delegate {
    _delegate = delegate;
}

@end



@implementation bvImage

@synthesize path = _path;

- (id) init { self = [super init]; return self; }

- (NSString*) imageUID { return _path; }
- (NSString*) imageRepresentationType { return IKImageBrowserPathRepresentationType; }
- (id)        imageRepresentation { return _path; }
@end

