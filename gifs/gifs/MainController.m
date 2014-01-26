//
//  MainController.m
//  gifs
//
//  Created by Robert Novak on 1/21/14.
//  Copyright (c) 2014 Robert Novak. All rights reserved.
//

#import "MainController.h"
#import "ClickableBox.h"

@interface MainController ()

@end

@implementation MainController

@synthesize directoryViewController = _directoryViewController;

- (id) init {
    self = [super init];
    
    return self;
}

- (void) selectImage:(id)sender {
    [[_browseViewcontroller inner] setHidden:YES];
    [[_imageViewController inner] setHidden:NO];
    [_imageViewController setImage:[sender imageUID]];
}

- (void) backClick:(id)sender {
    [[_browseViewcontroller inner] setHidden:YES];
    [[_directoryViewController inner] setHidden:NO];

}

- (void) esc:(id)sender {
    [[_imageViewController inner] setHidden:YES];
    [[_browseViewcontroller inner] setHidden:NO];
}

- (void) awakeFromNib {
    //NSRect frame = [[NSScreen mainScreen] frame];
    //[_mainWindow setFrame: frame display:YES animate:YES];
    
    _directoryViewController = [[DirectoryViewController alloc] init];
    _browseViewcontroller = [[BrowseViewController alloc] init];
    _imageViewController = [[ImageViewController alloc] init];

    [_browseViewcontroller add:_contentView];
    [_browseViewcontroller setController:self];
    
    [_directoryViewController add: _contentView];
    
    [_imageViewController setController:self];
    [_imageViewController add:_contentView];
    
    [ClickableBox setController:self];
    
}

- (void) performClick:(id)sender {
    ClickableBox* box = (ClickableBox*)sender;
    
    [[_directoryViewController inner] setHidden:YES];
    [[_browseViewcontroller inner] setHidden:NO];
    
    [_browseViewcontroller addPath:[box directory]];
}

- (NSString*) nextImage {
    
    return [_browseViewcontroller next];
}

- (NSString*) previousImage {
    return [_browseViewcontroller previous];
}



@end
