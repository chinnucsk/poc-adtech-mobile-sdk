//
//  VideoViewController.m
//  AdtechBannerPOC
//
//  Created by Alin Muntean on 7/10/13.
//  Copyright (c) 2013 RAM. All rights reserved.
//

#import "VideoViewController.h"

static const CGFloat kVideoHeight = 350;
static NSString *const kVideoContentPath = @"http://devimages.apple.com/iphone/samples/bipbop/bipbopall.m3u8";

@interface VideoViewController ()
{
	ATMoviePlayerController *_videoController;
}

- (IBAction)exitButtonPressed:(id)sender;

@end



@implementation VideoViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
	self = [super initWithCoder:aDecoder];
	if (self)
	{
		// Initializing the video player
		_videoController = [[ATMoviePlayerController alloc] initWithContentURL:[NSURL URLWithString:kVideoContentPath]];
		_videoController.presentingViewController = self;
		
		ATAdtechVideoAdConfiguration *configuration = [ATAdtechVideoAdConfiguration configuration];
		
		configuration.domain = @"a.adtech.de";
		configuration.networkID = 23;
		configuration.subNetworkID = 10;
		configuration.alias = @"video-top-5";
		[configuration enableAdType:kATVideoAdPreRoll];
		[configuration enableAdType:kATVideoAdPostRoll];
		
		// Creating the overlays
		ATVideoAdOverlay *firstOverlay = [ATVideoAdOverlay overlayWithStartTime:5.0 andDuration:15.0];
		firstOverlay.percentOfMargin = 10;
		firstOverlay.secondsUntilDismissable = 5;
		firstOverlay.placement = kATOverlayPlacementBottom;
		
		
		ATVideoAdOverlay *secondOverlay = [ATVideoAdOverlay overlayWithStartTime:15.0 andDuration:10.0];
		secondOverlay.secondsUntilDismissable = 3;
		firstOverlay.placement = kATOverlayPlacementTop;
		
		[configuration addOverlay:firstOverlay];
		[configuration addOverlay:secondOverlay];
		
		// Prepare video for play
		_videoController.configuration = configuration;
		[_videoController prepareToPlay];
	}
	
	return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	_videoController.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, kVideoHeight);
	_videoController.view.autoresizingMask = UIViewAutoresizingNone;
	
	[self.view addSubview:_videoController.view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
	[_videoController stop];
}

#pragma mark -
#pragma mark Buttons actions

- (IBAction)exitButtonPressed:(id)sender
{
	[self dismissViewControllerAnimated:YES completion:nil];
}

@end
