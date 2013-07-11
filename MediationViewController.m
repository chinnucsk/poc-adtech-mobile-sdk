//
//  MediationViewController.m
//  AdtechBannerPOC
//
//  Created by Alin Muntean on 7/10/13.
//  Copyright (c) 2013 RAM. All rights reserved.
//

#import "MediationViewController.h"

@interface MediationViewController () <ATBannerViewDelegate>

@property (nonatomic, strong) IBOutlet ATBannerView *mediationBanner;

- (IBAction)loadButtonPressed:(id)sender;
- (IBAction)exitButtonPressed:(id)sender;

@end



@implementation MediationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	ATAdtechAdConfiguration *configuration = [ATAdtechAdConfiguration configuration];
	configuration.networkID = 23;
	configuration.subNetworkID = 4;
	configuration.alias = @"sdkmedm2pri-bottom-5";
	
	self.mediationBanner.configuration = configuration;
	self.mediationBanner.viewController = self;
	self.mediationBanner.delegate = self;
	
	[self.mediationBanner load];
}

#pragma mark -
#pragma mark Buttons actions

- (IBAction)loadButtonPressed:(id)sender
{
	[self.mediationBanner load];
}

- (IBAction)exitButtonPressed:(id)sender
{
	[self dismissViewControllerAnimated:YES completion:nil];
}

@end