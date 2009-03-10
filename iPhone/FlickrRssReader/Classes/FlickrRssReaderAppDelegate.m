//
//  FlickrRssReaderAppDelegate.m
//  FlickrRssReader
//
//  Created by Alex Bleasdale on 2/21/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "FlickrRssReaderAppDelegate.h"
#import "FlickrRssReaderViewController.h"

@implementation FlickrRssReaderAppDelegate

@synthesize window;
@synthesize viewController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    
    // Override point for customization after app launch    
    [window addSubview:viewController.view];
    [window makeKeyAndVisible];
}


- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}


@end
