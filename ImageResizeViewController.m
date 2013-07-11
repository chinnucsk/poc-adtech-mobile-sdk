//
//  ImageResizeViewController.m
//  AdtechBannerPOC
//
//  Created by Alin Muntean on 7/10/13.
//  Copyright (c) 2013 RAM. All rights reserved.
//

#import "ImageResizeViewController.h"

@interface ImageResizeViewController () <ATBannerViewDelegate>

@property (nonatomic, strong) IBOutlet UIButton *loadButton;
@property (nonatomic, strong) IBOutlet ATBannerView *resizableImageBanner;

- (IBAction)loadButtonPressed:(id)sender;
- (IBAction)exitButtonPressed:(id)sender;

@end



@implementation ImageResizeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	ATAdtechAdConfiguration *configuration = [ATAdtechAdConfiguration configuration];
	configuration.networkID = 23;
	configuration.subNetworkID = 10;
	configuration.alias = @"imageresize";
	configuration.enableImageBannerResize = YES;
	
	self.resizableImageBanner.configuration = configuration;
	self.resizableImageBanner.viewController = self;
	self.resizableImageBanner.delegate = self;
	
	[self.resizableImageBanner load];
}

#pragma mark -
#pragma mark Buttons actions

- (IBAction)loadButtonPressed:(id)sender
{
	[self.resizableImageBanner load];
}

- (IBAction)exitButtonPressed:(id)sender
{
	[self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -
#pragma mark ATBannerViewDelegate

- (void)willResizeAd:(ATBannerView *)view toSize:(CGSize)size
{	
	// Resize the banner
	self.resizableImageBanner.frame = CGRectMake(MAX(0, (self.view.frame.size.width - size.width) / 2.f),
									   self.view.frame.size.height - size.height,
									   size.width,
									   size.height);
	
	// Move the button acording to banner
	self.loadButton.frame = CGRectMake(self.loadButton.frame.origin.x,
									   self.resizableImageBanner.frame.origin.y - self.loadButton.frame.size.height,
									   self.loadButton.frame.size.width,
									   self.loadButton.frame.size.height);
}

@end

