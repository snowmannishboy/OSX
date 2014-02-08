//
//  MainController.m
//  Images
//
//  Created by Robert Novak on 1/17/14.
//  Copyright (c) 2014 Robert Novak. All rights reserved.
//

#import "MainController.h"
#include "DirectoryItem.h"
#include "Directory.h"

@interface MainController ()

@end

static NSManagedObjectContext* managedObjectContext;

@implementation MainController

@synthesize browse_view;
@synthesize image_view;
@synthesize directory_view = _directory_view;
@synthesize button = _button;
@synthesize arrayController;
@synthesize imagesController;
@synthesize scroll_view;
@synthesize deleteButton;

- (void) performClick:(id)sender {
    NSLog(@"%@", imagesController);
    [_directory_view setHidden: YES];
    [deleteButton setHidden:YES];
    view = browse;
    [browse_view setHidden:NO];
    [_button setTitle:@"Go Back"];
    [scroll_view setHidden:YES];
    ClickableBox* box_clicked = (ClickableBox*) sender;
    
    NSError* currentError = nil;
    
    NSArray* paths = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:[box_clicked directory] error:&currentError];
    
    [paths enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSString* path = (NSString*) obj;
        NSMutableString* actual_path = [[NSMutableString alloc] init];
        [actual_path appendString:[box_clicked directory]];
        [actual_path appendString:@"/"];
        [actual_path appendString:path];
        [imagesController addAnImageWithPath:actual_path];
    }];
    [browse_view setAnimates:YES];
    [imagesController updateDatasource];
    
    
}

- (id)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    if (self) {
        [ClickableBox setMainController:self];
    }
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}

- (void) openFiles {
    
}


- (IBAction)add_directory_clicked:(id)sender {
    if (view == directory) {
        NSOpenPanel* panel = [NSOpenPanel openPanel];
        
        [panel setFloatingPanel:YES];
        [panel setCanChooseFiles:NO];
        [panel setCanChooseDirectories:YES];
        
        long result = [panel runModal];
        
        if (result == NSOKButton) {
            NSArray* urls = [panel URLs];
            [urls enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                NSURL* url = (NSURL*) obj;
                NSString* path = [url path];
                @try {
                    Directory* direct = [NSEntityDescription insertNewObjectForEntityForName:@"Directory" inManagedObjectContext:managedObjectContext];
                    NSError* localErr = nil;
                    [direct setValue: path];
                    NSDictionary* newObject = [NSDictionary dictionaryWithObjectsAndKeys:path, @"filename", nil];
                    [arrayController addObject:newObject];
                    
                    [managedObjectContext save: &localErr];
                    
                }
                @catch(NSException* exception) {
                    NSLog(@"Caught Exception: %@", exception);
                }
            }];
        }
    }
    else if (view == browse) {
        [deleteButton setHidden:NO];
        [browse_view setHidden: YES];
        [scroll_view setHidden:NO];
        view = directory;
        [_directory_view setHidden:NO];
        [_button setTitle:@"Add Directories"];
        [imagesController removeAll];
        [imagesController updateDatasource];
    }
    
}

- (void) awakeFromNib {
    directories = [[NSMutableArray alloc] init];
    selected = [[NSMutableArray alloc] init];
    
    NSSize size = NSMakeSize(150.0, 150.0);
    [_directory_view setMinItemSize:size];
    [_directory_view setMaxItemSize:size];
    

    
}

- (void) addObjects {
    NSFetchRequest* request = [[NSFetchRequest alloc] init];
    NSEntityDescription* sth = [NSEntityDescription entityForName:@"Directory" inManagedObjectContext:managedObjectContext];
    
    NSError* localError = nil;
    
    [request setEntity:sth];
    
    NSArray* local_directories = [managedObjectContext executeFetchRequest:request error:&localError];
    
    [local_directories enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        Directory* dir = (Directory*) obj;
        NSDictionary * newObj = [NSDictionary dictionaryWithObjectsAndKeys:[dir value], @"filename", nil];
        [arrayController addObject:newObj];
    }];
}

- (NSMutableArray*) selected {
    return selected;
}

- (void) setSelected: (NSMutableArray*) newSelected {
    if (newSelected != selected) {selected = newSelected; }
}


- (NSMutableArray*) directories {
    return directories;
}

- (IBAction)delete_button_clicked:(id)sender {
    NSArray* highlighted = [arrayController selectedObjects];
    if ([highlighted count] > 0l) {
        [highlighted enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            NSError* local = nil;
            NSFetchRequest* request = [[NSFetchRequest alloc] init];
            NSEntityDescription*sth = [NSEntityDescription entityForName:@"Directory" inManagedObjectContext:managedObjectContext];
            
            NSString* directory = [obj valueForKey:@"filename"];

            NSPredicate* query = [NSPredicate predicateWithFormat:@"value = %@", directory];
            [request setEntity:sth];
            [request setPredicate:query];
            
            NSArray* values = [managedObjectContext executeFetchRequest:request error:&local];
            
            if ([values count] > 0l) {
                [managedObjectContext deleteObject:values[0]];
                [managedObjectContext save: &local];
                
            }
            else {
                NSLog(@"Error in Query");
            }
            
            NSLog(@"%@", directory);
        }];
        
    }
    
    [arrayController removeObjects:highlighted];
}

- (void) setDirectories: (NSMutableArray*) directories_in {
    if (directories_in != directories) { directories = directories_in; }
}

+ (void) setManagedObjectContext:(NSManagedObjectContext *)context {
    managedObjectContext = context;
}

@end
