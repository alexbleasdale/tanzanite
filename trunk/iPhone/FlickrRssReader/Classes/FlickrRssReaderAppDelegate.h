//
//  FlickrRssReaderAppDelegate.h
//  FlickrRssReader
//
//  Created by Alex Bleasdale on 2/21/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FlickrRssReaderViewController;

@interface FlickrRssReaderAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    FlickrRssReaderViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet FlickrRssReaderViewController *viewController;

@end

