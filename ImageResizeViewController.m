//
//  ImageResizeViewController.m
//  AdtechBannerPOC
//
//  Created by Alin Muntean on 7/10/13.
//  Copyright (c) 2013 RAM. All rights reserved.
//

#import "ImageResizeViewController.h"

@interface ImageResizeViewController () <ATBannerViewDelegate>

@property (nonatomic, strong) IBOutlet ATBannerView *resizableImageBanner;

- (IBAction)loadButtonPressed:(id)sender;

@end



@implementation ImageResizeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	ATAdtechAdConfiguration *configuration = [ATAdtechAdConfiguration configuration];
	configuration.networkID = 23;
	configuration.subNetworkID = 10;
	configuration.alias = @"imageresize";
	
	self.resizableImageBanner.configuration = configuration;
	self.resizableImageBanner.viewController = self;
	self.resizableImageBanner.delegate = self;
	
	[self.resizableImageBanner load];
}

- (IBAction)loadButtonPressed:(id)sender
{
	[self.resizableImageBanner load];
}

#pragma mark - ATBannerViewDelegate

- (void)didFetchNextAd:(ATBannerView *)view
{
	NSLog(@"Fetch");
}

- (void)willResizeAd:(ATBannerView *)view toSize:(CGSize)size
{
	NSLog(@"Resize");
}

@end

