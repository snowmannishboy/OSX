//
//  DirectoryItem.m
//  Images
//
//  Created by Robert Novak on 1/17/14.
//  Copyright (c) 2014 Robert Novak. All rights reserved.
//

#import "DirectoryItem.h"

@interface DirectoryItem ()

@end

@implementation DirectoryItem

@synthesize box = _box;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

-(id)copyWithZone:(NSZone *)zone
{
    id result = [super copyWithZone:zone];
    NSArray* tlo = [[NSArray alloc] initWithObjects: _filename, _box, nil];
    
    [[NSBundle mainBundle] loadNibNamed:@"DirectoryItem" owner:result topLevelObjects:&tlo];
    
    
    return result;
}

- (void) setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];
    if (representedObject == nil)
        return;
    
    NSDictionary* dict = (NSDictionary*) representedObject;
    NSString* newFilename = (NSString*)[dict valueForKey:@"filename"];
    
    if (_filename != nil) {
        [_filename setStringValue:newFilename];
        if (_box != nil) {
            NSLog(@"set box, %@", newFilename);
            [_box setDirectory:newFilename];
        }
    }
    
}








@end
