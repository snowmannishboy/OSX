//
//  DirectoryItemViewController.m
//  I5
//
//  Created by Robert Novak on 2/10/14.
//  Copyright (c) 2014 Robert Novak. All rights reserved.
//

#import "DirectoryItemViewController.h"
#import "ClickableBox.h"

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
        NSArray* topLevelObjects = nil;
        [[NSBundle mainBundle] loadNibNamed:@"DirectoryItemView" owner:result topLevelObjects:&topLevelObjects];
        
        for (id obj in topLevelObjects)
            if ([obj isKindOfClass:[self class]])
                return obj;
        
    }
    return result;
}

- (void)setRepresentedObject:(id)representedObject {
    if (!representedObject) return;
    
    [_name setStringValue:[representedObject valueForKey:@"display"]];
    
    [_box setRepresentedObject:representedObject];
}

@end
