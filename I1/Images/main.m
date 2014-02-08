//
//  main.m
//  Images
//
//  Created by Robert Novak on 1/15/14.
//  Copyright (c) 2014 Robert Novak. All rights reserved.
//

#import <Cocoa/Cocoa.h>

int main(int argc, const char * argv[])
{
    int result = 0;
    @try {
        result =NSApplicationMain(argc, argv);
    }
    @catch(NSException* e) {
        NSLog(@"Caught Exception %@", e);
        result = 0;
    }
    return result;
}
