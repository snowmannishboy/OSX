//
//  DirectoryItemViewController.m
//  gifs
//
//  Created by Robert Novak on 1/22/14.
//  Copyright (c) 2014 Robert Novak. All rights reserved.
//

#import "DirectoryItemViewController.h"

@interface DirectoryItemViewController ()

@end

@implementation DirectoryItemViewController

@synthesize filename = _filename;
@synthesize box = _box;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
    }
    return self;
}

- (id) copyWithZone:(NSZone *)zone {
    id result = [super copyWithZone:zone];
    
    NSArray* tlo = [NSArray arrayWithObjects:_filename, _box, nil];
    
    [[NSBundle mainBundle] loadNibNamed:@"DirectoryItemView" owner:result topLevelObjects:&tlo];
    
    return result;
}


- (void) setRepresentedObject:(id)representedObject {
    
    if (representedObject == nil) return;
    
    NSDictionary* objectValues = (NSDictionary*)representedObject;
    
    NSString* newFilename = (NSString*)[objectValues objectForKey:@"filename"];
    
    if (newFilename) {
        [_filename setStringValue:newFilename];
        if (_box) [_box setDirectory:newFilename];
    }

}

@end
