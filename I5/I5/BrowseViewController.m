//
//  BrowseViewController.m
//  I5
//
//  Created by Robert Novak on 2/11/14.
//  Copyright (c) 2014 Robert Novak. All rights reserved.
//

#import "BrowseViewController.h"
#import "DirectoryModel.h"
#import "ImageModel.h"

@interface BrowseViewController ()

@end

static id  _target;
static SEL _action;
static void (*callableAction)(id, SEL, id);

@implementation BrowseViewController

- (id) init {
    self = [super init];
    if (self) {
        NSError* local = nil;
        _fileCheck = [NSRegularExpression regularExpressionWithPattern:@"^.+\\.(png|gif|jpg|jpeg)$" options:NSRegularExpressionCaseInsensitive error:&local];
        NSArray* tl = nil;
        [[NSBundle mainBundle] loadNibNamed:@"BrowseView" owner:self topLevelObjects:&tl];
        for (id obj in tl)
            if ([obj isKindOfClass: [self class]])
                return obj;
    }
    return self;
}

- (void) awakeFromNib {
    [[self view] setHidden:YES];
    _images = [[NSMutableArray alloc] init];
    _importedImages = [[NSMutableArray alloc] init];
    _selectedIndexes = [[NSIndexSet alloc] init];
}

- (void) clear {
    [_images removeAllObjects];
    
    _selectedIndexes = [[NSIndexSet alloc] init];
    
    [_browserView reloadData];
    
    [[_directory url] stopAccessingSecurityScopedResource];
    
    _directory = nil;
}

- (void) loadImportedImages: (id) sender {
    [_images addObjectsFromArray:_importedImages];
    [_importedImages removeAllObjects];
    [_browserView reloadData];
}

- (void) processDirectory: (id) sender {
    NSError* local = nil;
    NSArray* arr = [[NSFileManager defaultManager] contentsOfDirectoryAtURL:[_directory url] includingPropertiesForKeys:nil options:NSDirectoryEnumerationSkipsSubdirectoryDescendants error:&local];
    
    if (!arr || local) {
        NSLog(@"[%@] Error Loading Resources - %@", [self class], [local localizedDescription]);
        return;
    }
    
    [arr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSURL* url = (NSURL*)obj;
        NSString* filename = [url lastPathComponent];
        if ([_fileCheck numberOfMatchesInString:filename options:NSMatchingAnchored range:NSMakeRange(0, [filename length])] > 0l) {
            ImageModel *new = [[ImageModel alloc] initWithURL:url];
            [_importedImages addObject:new];
        }
    }];
    
    [self performSelectorOnMainThread:@selector(loadImportedImages:) withObject:self waitUntilDone:NO];
}


- (void) open:(DirectoryModel *)directory {
    if (directory == nil) return;
    
    _directory = directory;
    [[_directory url] startAccessingSecurityScopedResource];
    
    [self performSelectorInBackground:@selector(processDirectory:) withObject:self];
}

- (NSUInteger) numberOfItemsInImageBrowser:(IKImageBrowserView *)aBrowser {
    return [_images count];
}

- (id) imageBrowser:(IKImageBrowserView *)aBrowser itemAtIndex:(NSUInteger)index {
    return [_images objectAtIndex:index];
}

- (void) imageBrowser:(IKImageBrowserView *)aBrowser cellWasDoubleClickedAtIndex:(NSUInteger)index {
    if (callableAction)
        callableAction(_target, _action, [_images objectAtIndex:index]);
}

+ (void) setAction:(SEL)action target:(id)target {
    if (target && action) {
        _action = action;
        _target = target;
        IMP i = [target methodForSelector:action];
        callableAction = (void*)i;
    }
}

@end
