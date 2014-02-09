//
//  DirectoryItemViewController.m
//  image-viewer
//
//  Created by Robert Novak on 2/3/14.
//  Copyright (c) 2014 Robert Novak. All rights reserved.
//

#import "DirectoryItemViewController.h"

@interface DirectoryItemViewController ()

@end

@implementation DirectoryItemViewController

@synthesize box = _box;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (id) copyWithZone:(NSZone *)zone {
    id result = [super copyWithZone:zone];
    NSArray* topLevelObjects = nil;
    [[NSBundle mainBundle] loadNibNamed:@"DirectoryItemView" owner:result topLevelObjects:&topLevelObjects];
    return result;
}

- (void) setRepresentedObject:(id)representedObject {
    if (representedObject == nil) return;
    
    [super setRepresentedObject:representedObject];
    NSDictionary* dict = (NSDictionary*)representedObject;
    NSString* path = (NSString*)[dict objectForKey:@"path"];
    NSString* identifer = (NSString*) [dict objectForKey:@"identifier"];
    NSString* name = (NSString*) [dict objectForKey:@"name"];
    if (_path) {
        [_path setStringValue:name];
        [_box setPath:path];
        [_box setName:name];
        [_box setId:identifer];
    }
}

@end
