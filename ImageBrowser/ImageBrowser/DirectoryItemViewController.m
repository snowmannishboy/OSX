//
//  DirectoryItemViewController.m
//  ImageBrowser
//
//  Created by Robert Novak on 2/16/14.
//  Copyright (c) 2014 Robert Novak. All rights reserved.
//

#import "DirectoryItemViewController.h"
#import "ClickableBox.h"
#import "DirectoryModel.h"

@implementation DirectoryItemViewController


- (id) copyWithZone:(NSZone *)zone {
    id result = [super copyWithZone:zone];
    if (result) {
        NSArray* topLevelObjects;
        [[NSBundle mainBundle] loadNibNamed:@"DirectoryItemView" owner:result topLevelObjects:&topLevelObjects];
        for (id obj in topLevelObjects) if ([obj isKindOfClass:[result class]]) return obj;
    }
    return result;
}



- (void) setRepresentedObject:(id)representedObject {
    
    [super setRepresentedObject:representedObject];
    
    if (!representedObject) return;
    
    if ([representedObject isKindOfClass:[DirectoryModel class]]) [_name setStringValue:[representedObject valueForKey:@"display"]];
    
    [_box setRepresented:representedObject];
    
}

@end
