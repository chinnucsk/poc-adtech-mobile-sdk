//
//  ViewController.m
//  AdtechBannerPOC
//
//  Created by Alin Muntean on 7/4/13.
//  Copyright (c) 2013 RAM. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <ATBannerViewDelegate, ATInterstitialViewDelegate>
{
	ATInterstitialView *adtechInterstitialBanner;
}

@property (nonatomic, strong) IBOutlet ATBannerView *adtechORMMABanner;
@property (nonatomic, strong) IBOutlet ATBannerView *adtechMRAIDBanner;

- (IBAction)loadORMMAButtonPressed:(id)sender;
- (IBAction)loadMRAIDButtonPressed:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	// Interstitial
	ATAdtechAdConfiguration *interstitialConfiguration = [ATAdtechAdConfiguration configuration];
    interstitialConfiguration.alias = @"testmraid";
    interstitialConfiguration.networkID = 23;
    interstitialConfiguration.subNetworkID = 10;
	interstitialConfiguration.allowLocationServices = YES;
	
	adtechInterstitialBanner = [[ATInterstitialView alloc] init];
	adtechInterstitialBanner.configuration = interstitialConfiguration;
	adtechInterstitialBanner.delegate = self;
	adtechInterstitialBanner.viewController = self;
	
	[adtechInterstitialBanner load];
	
	// ORMMA
	ATAdtechAdConfiguration *ORMMAConfiguration = [ATAdtechAdConfiguration configuration];
	ORMMAConfiguration.alias = @"test";
	ORMMAConfiguration.domain = @"beta-a.adtech.de";
	ORMMAConfiguration.schema = @"http";
	ORMMAConfiguration.port = 0;
	ORMMAConfiguration.networkID = 23;
	ORMMAConfiguration.subNetworkID = 10;
	ORMMAConfiguration.allowLocationServices = YES;
	
	self.adtechORMMABanner.configuration = ORMMAConfiguration;
	self.adtechORMMABanner.viewController = self;
	self.adtechORMMABanner.delegate = self;
	
	[self.adtechORMMABanner load];
	
	// MRAID
	ATAdtechAdConfiguration *MRAIDConfiguration = [ATAdtechAdConfiguration configuration];
	MRAIDConfiguration.alias = @"testmraid";
	MRAIDConfiguration.domain = @"beta-a.adtech.de";
	MRAIDConfiguration.schema = @"http";
	MRAIDConfiguration.port = 0;
	MRAIDConfiguration.networkID = 23;
	MRAIDConfiguration.subNetworkID = 10;
	MRAIDConfiguration.allowLocationServices = YES;
	
	self.adtechMRAIDBanner.configuration = MRAIDConfiguration;
	self.adtechMRAIDBanner.viewController = self;
	self.adtechMRAIDBanner.delegate = self;
	
	[self.adtechMRAIDBanner load];
}

- (IBAction)loadORMMAButtonPressed:(id)sender
{
	[self.adtechORMMABanner load];
}

- (IBAction)loadMRAIDButtonPressed:(id)sender
{
	[self.adtechMRAIDBanner load];
}

#pragma mark - ATInterstitialViewDelegate

- (void)didSuccessfullyFetchInterstitialAd:(ATInterstitialView*)view
{
    [view present];
}

- (void)didHideInterstitialAd:(ATInterstitialView *)view
{
    adtechInterstitialBanner = nil;
}

@end
