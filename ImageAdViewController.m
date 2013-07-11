//
//  ImageAdViewController.m
//  AdtechBannerPOC
//
//  Created by Alin Muntean on 7/10/13.
//  Copyright (c) 2013 RAM. All rights reserved.
//

#import "ImageAdViewController.h"

@interface ImageAdViewController () <ATBannerViewDelegate>

@property (nonatomic, strong) IBOutlet ATBannerView *imageBanner;

- (IBAction)loadButtonPressed:(id)sender;
- (IBAction)exitButtonPressed:(id)sender;

@end



@implementation ImageAdViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	ATAdtechAdConfiguration *configuration = [ATAdtechAdConfiguration configuration];
	configuration.networkID = 23;
	configuration.subNetworkID = 10;
	configuration.alias = @"testmraid";
	configuration.openLandingPagesThroughBrowser = NO;
	
	self.imageBanner.configuration = configuration;
	self.imageBanner.viewController = self;
	self.imageBanner.delegate = self;
	
	[self.imageBanner load];
}

#pragma mark -
#pragma mark Buttons actions

- (IBAction)loadButtonPressed:(id)sender
{
	[self.imageBanner load];
}

- (IBAction)exitButtonPressed:(id)sender
{
	[self dismissViewControllerAnimated:YES completion:nil];
}

@end
