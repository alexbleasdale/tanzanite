//
//  main.m
//  FlickrRssReader
//
//  Created by Alex Bleasdale on 2/21/09.
//  Copyright OLSON 2009. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <Foundation/NSXMLParser.h>



@class UIImageView;

@interface FlickrRssController : UIViewController {
	NSMutableArray * tags;
	NSMutableArray * photo_hrefs;
	NSMutableArray * titles;
	NSMutableDictionary * item;
	NSMutableString * currentTitle, * currentDate;
	NSString * currentElement;
	int arrayIdx;
	UIImageView *contentView;
	NSString * path;
	NSTimer * currentTimer;
	
	int randomTag;
	int randomTag2;
}
@end

// OLD feeds
//path = @"http://api.flickr.com/services/feeds/photos_public.gne?format=rss_100";
//path = @"http://www.flourish.org/news/flickr-daily-interesting.xml";

@implementation FlickrRssController
- (id)init
{
	if (self = [super init])
	{ 
		tags = [[NSMutableArray alloc] initWithObjects:  @"graffiti", @"minneapolis", @"buildings", @"cities", @"cathedral", @"countries", @"london", @"paris", @"venice", @"bridges", @"mountains", @"skyscrapers", @"afternoon", @"skyline", @"architecture", @"hdr", @"buildings", @"cities", @"cars", @"weather", @"sunrise", @"sunset", @"plants", @"flowers", @"nature", nil];
		NSLog(@"The tag array has %d items", [tags count]);
		
		// ***** pick a tag at random - TODO - REFACTOR to one method when I know how..
		randomTag = arc4random() % [tags count];
		NSLog(@"chosen tag [1] as %d for the next 5 pics", randomTag);
		randomTag2 = arc4random() % [tags count];
		NSLog(@"chosen tag [2] as %d for the next 5 pics", randomTag2);
		path = [NSString stringWithFormat:@"%@%@%@%@%@", @"http://www.degraeve.com/flickr-rss/rss.php?tags=", [tags objectAtIndex:randomTag], @"+", [tags objectAtIndex:randomTag2], @"&tagmode=all&sort=interestingness-desc&num=5"];
		
		// set default index value
		arrayIdx = 0;
		photo_hrefs = [[NSMutableArray alloc] initWithArray:photo_hrefs];
		titles = [[NSMutableArray alloc] initWithArray:titles];
		self.title = @"Loading RSS Feed from Flickr..";

		NSLog(@"getting feed from %@", path);
		[self parseXMLFileAtURL:path];

		self.title = [[titles objectAtIndex: 0] objectForKey: @"title"];
		currentTimer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(theActionMethod) userInfo:nil repeats:YES];
	}
	return self;
}




-(void)theActionMethod
{	
	if (contentView && (arrayIdx < [photo_hrefs count] - 1)){
		//NSLog(@"in our action method - current frame is.. %d", arrayIdx);
		arrayIdx++;
		//[contentView setImage:[UIImage imageWithData: [NSData dataWithContentsOfURL: [NSURL URLWithString:[photo_hrefs objectAtIndex:arrayIdx]]]]];
		self.title = [[titles objectAtIndex: arrayIdx] objectForKey: @"title"];
	} else {
		NSLog(@"that's the end of the feed - refreshing RSS and updating arrays");
		[photo_hrefs removeAllObjects];
		[titles removeAllObjects];
		
		
		// ****** pick a tag at random - TODO - REFACTOR to one method when I know how..
		randomTag = arc4random() % [tags count];
		NSLog(@"chosen tag [1] as %d for the next 5 pics", randomTag);
		randomTag2 = arc4random() % [tags count];
		NSLog(@"chosen tag [2] as %d for the next 5 pics", randomTag2);
		path = [NSString stringWithFormat:@"%@%@%@%@%@", @"http://www.degraeve.com/flickr-rss/rss.php?tags=", [tags objectAtIndex:randomTag], @"+", [tags objectAtIndex:randomTag2], @"&tagmode=all&sort=interestingness-desc&num=5"];
		NSLog(@"getting feed from %@", path);
		
		[self parseXMLFileAtURL:path];
		//[contentView setImage:[UIImage imageWithData: [NSData dataWithContentsOfURL: [NSURL URLWithString:[photo_hrefs objectAtIndex:arrayIdx]]]]];
		self.title = [[titles objectAtIndex: arrayIdx] objectForKey: @"title"];
		arrayIdx = 0;
	}
	
	[contentView setImage:[UIImage imageWithData: [NSData dataWithContentsOfURL: [NSURL URLWithString:[photo_hrefs objectAtIndex:arrayIdx]]]]];
	[contentView setAlpha:0.0];
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:4.0];
	[contentView setAlpha:100.0];
	[UIView commitAnimations];
}







// RSS PArser CODE here

- (void)parserDidStartDocument:(NSXMLParser *)parser{	
	//NSLog(@"found file and started parsing");
}

- (void)parseXMLFileAtURL:(NSString *)URL 
{	
	
	NSURL *xmlURL = [NSURL URLWithString:URL];

    //you must then convert the path to a proper NSURL or it won't work
    //NSURL *xmlURL = [NSURL fileURLWithPath:URL];
	
    // here, for some reason you have to use NSClassFromString when trying to alloc NSXMLParser, otherwise you will get an object not found error
    // this may be necessary only for the toolchain
    //NSXMLParser *parser = [[ NSClassFromString(@"NSXMLParser") alloc] initWithContentsOfURL:xmlURL];
	NSXMLParser *parser = [[NSXMLParser alloc] initWithContentsOfURL:xmlURL];
    // Set self as the delegate of the parser so that it will receive the parser delegate methods callbacks.
    [parser setDelegate:self];
	
    // Depending on the XML document you're parsing, you may want to enable these features of NSXMLParser.
    [parser setShouldProcessNamespaces:NO];
    [parser setShouldReportNamespacePrefixes:NO];
    [parser setShouldResolveExternalEntities:NO];
	
    [parser parse];
	
    [parser release];
}


//- (void)parserDidStartDocument:(NSXMLParser *)parser {
//	NSLog(@"found file and started parsing");
//}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
	NSString * errorString = [NSString stringWithFormat:@"Unable to download story feed from web site (Error code %i )", [parseError code]];
	NSLog(@"error parsing XML: %@", errorString);
	
	UIAlertView * errorAlert = [[UIAlertView alloc] initWithTitle:@"Error loading content" message:errorString delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[errorAlert show];
}


- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
	//currentElement = [elementName copy];
	//NSLog(@"found this element: %@", elementName);
	
	currentElement = [elementName copy];

	if ([elementName isEqualToString:@"item"]) {
		// clear out our story item caches...
		item = [[NSMutableDictionary alloc] init];
		currentTitle = [[NSMutableString alloc] init];
		currentDate = [[NSMutableString alloc] init];
	}		
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{     
	if ([elementName isEqualToString:@"item"]){
		[item setObject:currentTitle forKey:@"title"];
		[item setObject:currentDate forKey:@"date"];
		
		[titles addObject:[item copy]];
		//NSLog(@"adding story: %@", currentTitle);
	}
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
	//NSLog(@"infoundChars: %@", string);
	if ([currentElement isEqualToString:@"title"]) {
		[currentTitle appendString:string];
	
	} else if ([currentElement isEqualToString:@"description"]) {
		if ([string hasSuffix:@".jpg"]){
			//NSLog(@"adding %@", string);
			[photo_hrefs addObject:string];
		}
		
	// This code block is for the old public flickr feed	
	/*	if ([string hasSuffix:@"m.jpg"]){		
			NSMutableString *tempString;                         
			tempString = [string mutableCopy];

			NSString *tempExt = [[NSString alloc] init];
			tempExt = @"d.jpg"; 
			// trim the string
			tempString = [string substringWithRange: NSMakeRange(0, [string length] - 5)];
			tempString = [NSString stringWithFormat:@"%@%@", tempString, tempExt];
			
			// this is supposed to work :(
			//tempString = [tempString replaceOccurrencesOfString:@"_m.jpg" withString:@"_d.jpg" options:0 range:NSMakeRange(0, [tempString length] - 1)];
		
			//NSLog(@"adding %@", tempString);
			[photo_hrefs addObject:tempString];
		}*/
	} else if ([currentElement isEqualToString:@"pubDate"]) {
		[currentDate appendString:string];
	}	
}


- (void)parserDidEndDocument:(NSXMLParser *)parser {
	NSLog(@"RSS pics array has %d items", [photo_hrefs count]);
	NSLog(@"RSS titles array has %d items", [titles count]);
}

// ***********************   END RSS Parser







- (void)loadView
{
	// Load an application image and set it as the primary view
	contentView = [[UIImageView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
	//[contentView setImage:[UIImage imageNamed:@"helloworld.png"]];
	
	/* this loads an image from the interwebs:
	NSLog(@"inLoadview array has %d items", [photo_hrefs count]);
	NSLog(@"inLoadview array has %@", [photo_hrefs objectAtIndex:0]);
	NSLog(@"inLoadviewtitles array has %@", [titles objectAtIndex:0]);*/
	
	// testing some simple animation
	// *** todo REFACTOR
	[contentView setAlpha:0.0];
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:4.0];
	[contentView setAlpha:100.0];
	[UIView commitAnimations];
	
	
//	[UIView beginAnimations:nil context:NULL];
//	[UIView setAnimationDuration:0.5];
//	someView.alpha = 1.0;
//	[UIView commitAnimations];
	[contentView setImage:[UIImage imageWithData: [NSData dataWithContentsOfURL: [NSURL URLWithString:[photo_hrefs objectAtIndex:0]]]]];
	
	
	
	//[contentView setImage:[UIImage imageWithData: [NSData dataWithContentsOfURL: [NSURL URLWithString: @"http://farm4.static.flickr.com/3579/3298367200_8d669f8db8_d.jpg"]]]];
	
	// Provide support for auto-rotation and resizing - WOO HOO! WORKS! :) :) :)
	contentView.autoresizesSubviews = YES;
	contentView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
	contentView.contentMode = UIViewContentModeScaleAspectFit;
	//UIImage *thumbnail = [originalImage _imageScaledToSize:CGSizeMake(40.0, 40.0) interpolationQuality:1];
	
	
	
	// Assign the view to the view controller
	self.view = contentView;
    [contentView release]; 
}

// Allow the view to respond to iPhone Orientation changes
-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

// Add any memory warning issues by releasing non-essential data
- (void)didReceiveMemoryWarning {
	// releases the view if it is not attached to a super view
    [super didReceiveMemoryWarning]; 
}

-(void) dealloc
{
	[super dealloc];
}
@end








@interface SampleAppDelegate : NSObject <UIApplicationDelegate> 
@end

@implementation SampleAppDelegate

// On launch, create a basic window
- (void)applicationDidFinishLaunching:(UIApplication *)application {	
	UIWindow *window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[[FlickrRssController alloc] init]];
	[window addSubview:nav.view];
	[window makeKeyAndVisible];
}

- (void)applicationWillTerminate:(UIApplication *)application  {
	// handle any final state matters here
}

- (void)dealloc {
	[super dealloc];
}

@end

int main(int argc, char *argv[])
{
	NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
	int retVal = UIApplicationMain(argc, argv, nil, @"SampleAppDelegate");
	[pool release];
	return retVal;
}

