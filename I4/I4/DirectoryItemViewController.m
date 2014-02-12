//
//  DirectoryItemViewController.m
//  I4
//
//  Created by Robert Novak on 2/9/14.
//  Copyright (c) 2014 Robert Novak. All rights reserved.
//

#import "DirectoryItemViewController.h"

@interface DirectoryItemViewController ()

@end

@implementation DirectoryItemViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (id) copyWithZone:(NSZone *)zone {
    id result = [super copyWithZone:zone];
    if (result) {
        NSArray* topLevelObjects;
        [[NSBundle mainBundle] loadNibNamed:@"DirectoryItemView" owner:result topLevelObjects:&topLevelObjects];
    }
    return result;
}

- (void) setRepresentedObject:(id)representedObject {
    if (representedObject == nil) return;
    [super setRepresentedObject:representedObject];
    [_box setRepresentation:representedObject];
    [_name setStringValue:[representedObject valueForKey:@"display"]];
}


@end
