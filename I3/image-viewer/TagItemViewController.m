//
//  TagItemViewController.m
//  image-viewer
//
//  Created by Robert Novak on 2/6/14.
//  Copyright (c) 2014 Robert Novak. All rights reserved.
//

#import "TagItemViewController.h"
#include <uuid/uuid.h>

@interface TagItemViewController ()

@end

static id<TagItemProtocol> _delegate;

@implementation TagItemViewController

@synthesize tagId = _tagId;
@synthesize tagName = _tagName;

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
    [[NSBundle mainBundle] loadNibNamed:@"TagItemView" owner:result topLevelObjects:&topLevelObjects];
    return result;
}


- (void) setRepresentedObject:(id)representedObject {
    
    if (representedObject == nil) return;

    [super setRepresentedObject:representedObject];
    
    NSString* name = [representedObject objectForKey:@"name"];
    NSString* tagId = [representedObject objectForKey:@"id"];
    
    if (name && _tagName) {
        [_tagName setStringValue:name];
    }
    
    if (tagId) {
        _tagId = tagId;
    }
}

- (BOOL) selected {
    return [super isSelected];
}

+ (void) setDelegate:(id<TagItemProtocol>)delegate {
    _delegate = delegate;
}

@end
