//
//  BrowseViewController.m
//  ImageBrowser
//
//  Created by Robert Novak on 2/16/14.
//  Copyright (c) 2014 Robert Novak. All rights reserved.
//

#import "BrowseViewController.h"
#import "DirectoryModel.h"
#import "ImageBrowserModel.h"
#import <Quartz/Quartz.h>

@interface BrowseViewController ()
- (void) _openDirectory: (DirectoryModel*) model;
- (void) _importImages;
@end

static id _target;
static SEL _action;
static void (*callableAction)(id, SEL, id);

@implementation BrowseViewController



- (id) init {
    self = [super init];
    if (self) {
        NSError* local;
        _fileCheck = [NSRegularExpression regularExpressionWithPattern:@"^.+\\.(gif|png|jpg|jpeg|tiff)$" options:NSRegularExpressionCaseInsensitive error:&local];
        NSArray* tlo;
        [[NSBundle mainBundle] loadNibNamed:@"BrowseView" owner:self topLevelObjects:&tlo];
        for (id obj in tlo) if ([obj isKindOfClass:[self class]]) return obj;
    }
    return self;
}


- (void) awakeFromNib {
    _images = [[NSMutableArray alloc] init];
    _imported = [[NSMutableArray alloc] init];
    _selectionIndexes = [[NSIndexSet alloc] init];
    [_browseView bind:@"selectionIndexes" toObject:self withKeyPath:@"selectionIndexes" options:nil];
    
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

- (void) _importImages {
    [_images addObjectsFromArray:_imported];
    _imported = nil;
    _imported = [[NSMutableArray alloc] init];
    [_browseView reloadData];
}

- (void) _openDirectory: (DirectoryModel*) model {
    
    
    if (![model url]) return;

    _cwd = model;
    
    [[_cwd url] startAccessingSecurityScopedResource];

    NSError* local;
    NSArray* arr = [[NSFileManager defaultManager] contentsOfDirectoryAtURL:[model url] includingPropertiesForKeys:[NSArray arrayWithObjects: NSURLPathKey, NSURLNameKey, nil] options:NSDirectoryEnumerationSkipsHiddenFiles error:&local];
    
    if (local) {
        NSLog(@"[%@] Error Loading Contents: %@", [self class], [local localizedDescription]);
        return;
    }
    
    [arr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSURL* url = obj;
        NSString* path = [url path];
        NSString* filename = [path lastPathComponent];
        
        if ([_fileCheck numberOfMatchesInString:filename options:NSMatchingAnchored range:NSMakeRange(0, [filename length])]) {
            ImageBrowserModel* model = [[ImageBrowserModel alloc] init];
            [model setPath:path];
            [model setName:filename];
            [_imported addObject:model];
        }
    }];
    
    [self performSelectorOnMainThread:@selector(_importImages) withObject:nil waitUntilDone:NO];
}

- (void) clearDirectory {
    if (_cwd) {
        [[_cwd url] stopAccessingSecurityScopedResource];
    }
    [_images removeAllObjects];
    [_browseView reloadData];
    _images = nil;
    _images = [[NSMutableArray alloc] init];
}

- (ImageBrowserModel*) next {
    ImageBrowserModel* result = nil;
    NSUInteger current = [_selectionIndexes firstIndex];
    if (current != NSNotFound) {
        current = (current < ([_images count] - 1)) ? (current + 1) : 0;
        result = [_images objectAtIndex:current];
        _selectionIndexes = [[NSIndexSet alloc] initWithIndex:current];
    }
    return result;
}

- (ImageBrowserModel*) previous {
    ImageBrowserModel* result = nil;
    NSUInteger current = [_selectionIndexes firstIndex];
    if (current != NSNotFound) {
        current = (current > 0) ? (current - 1) : ([_images count] - 1);
        result = [_images objectAtIndex:current];
        _selectionIndexes = [[NSIndexSet alloc] initWithIndex:current];
    }
    return result;
}



- (void) openDirectory:(DirectoryModel *)directory {
    [self performSelectorOnMainThread:@selector(_openDirectory:) withObject:directory waitUntilDone:NO];
}

+ (void) setAction:(SEL)action target:(id)target {
    if (action && target) {
        _target = target;
        _action = action;
        IMP i = [target methodForSelector:action];
        callableAction = (void*) i;
    }
}

@end
