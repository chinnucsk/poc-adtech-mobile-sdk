//
//  ViewController.m
//  AdtechBannerPOC
//
//  Created by Alin Muntean on 7/4/13.
//  Copyright (c) 2013 RAM. All rights reserved.
//

#import "BannerViewController.h"

@interface BannerViewController () <ATBannerViewDelegate, ATInterstitialViewDelegate>
{
	ATInterstitialView *_interstitialBanner;
	CGFloat _kAdMobBannerHeight;
	CGFloat _kMRAIDBannerHeight;
}

@property (nonatomic, strong) IBOutlet ATBannerView *AdMobBanner;
@property (nonatomic, strong) IBOutlet ATBannerView *MRAIDBanner;

@property (nonatomic, strong) IBOutlet UIView *contentSizeView;
@property (nonatomic, strong) IBOutlet UILabel *contentSizeLabel;

- (IBAction)loadAdMobButtonPressed:(id)sender;
- (IBAction)loadMRAIDButtonPressed:(id)sender;

@end



@implementation BannerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	// Interstitial
	_interstitialBanner = [[ATInterstitialView alloc] init];
	_interstitialBanner.configuration = [self configurationWithDomain:nil network:23 subNetwork:4 andAlias:@"interstitial-top-5"];
	_interstitialBanner.delegate = self;
	_interstitialBanner.viewController = self;
	
	[_interstitialBanner load];
	
	// AdMob	
	self.AdMobBanner.configuration = [self configurationWithDomain:@"a.adtech.de" network:23 subNetwork:4 andAlias:@"sdkmedm2pri-bottom-5"];
	self.AdMobBanner.viewController = self;
	self.AdMobBanner.delegate = self;
	
	[self.AdMobBanner load];
	
	// MRAID
	self.MRAIDBanner.configuration = [self configurationWithDomain:@"a.adtech.de" network:23 subNetwork:10 andAlias:@"testmraid"];
	self.MRAIDBanner.configuration.openLandingPagesThroughBrowser = NO;
	self.MRAIDBanner.viewController = self;
	self.MRAIDBanner.delegate = self;
	
	[self.MRAIDBanner load];
	
	// Show middle View size and set default values for static members
	self.contentSizeView.frame = CGRectMake(self.contentSizeView.frame.origin.x,
											self.AdMobBanner.frame.size.height,
											self.contentSizeView.frame.size.width,
											self.view.frame.size.height - self.AdMobBanner.frame.size.height - self.MRAIDBanner.frame.size.height
											);
	[self updateContentViewSizeLabel];
	
	_kAdMobBannerHeight = self.AdMobBanner.frame.size.height;
	_kMRAIDBannerHeight = self.MRAIDBanner.frame.size.height;
}

- (void)viewDidUnload
{
	self.MRAIDBanner = nil;
	self.AdMobBanner = nil;
	self.contentSizeLabel = nil;
	self.contentSizeView = nil;
	
	[super viewDidUnload];
}

- (void)viewDidAppear:(BOOL)animated
{
	self.MRAIDBanner.visible = YES;
	self.AdMobBanner.visible = YES;
	
	[super viewDidAppear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
	
	self.MRAIDBanner.visible = NO;
	self.AdMobBanner.visible = NO;
}

- (IBAction)loadAdMobButtonPressed:(id)sender
{
	[self.AdMobBanner load];
}

- (IBAction)loadMRAIDButtonPressed:(id)sender
{
	[self.MRAIDBanner load];
}

- (void)updateContentViewSizeLabel
{
	self.contentSizeLabel.text = NSStringFromCGRect(self.contentSizeView.frame);
}

- (ATAdtechAdConfiguration *)configurationWithDomain:(NSString *)domain network:(NSUInteger)network subNetwork:(NSUInteger)subNetwork andAlias:(NSString *)alias
{
	ATAdtechAdConfiguration *configuration = [ATAdtechAdConfiguration configuration];
	if (domain)
	{
		configuration.domain = domain;
	}
	if (network)
	{
		configuration.networkID = network;
	}
	if (subNetwork)
	{
		configuration.subNetworkID = subNetwork;
	}
	if (alias)
	{
		configuration.alias = alias;
	}
	
	configuration.allowLocationServices = YES;
	
	return configuration;
}

#pragma mark - ATInterstitialViewDelegate

- (void)didSuccessfullyFetchInterstitialAd:(ATInterstitialView*)view
{
    [view present];
}

- (void)didHideInterstitialAd:(ATInterstitialView *)view
{
    _interstitialBanner = nil;
}

#pragma mark - ATBannerViewDelegate

- (void)didFetchNextAd:(ATBannerView *)view
{
	view.hidden = NO;
}

- (void)willResizeAd:(ATBannerView *)view toSize:(CGSize)size
{
	// Top banner resizes
	if (self.AdMobBanner == view)
	{
		_kAdMobBannerHeight = size.height;
		
		self.contentSizeView.frame = CGRectMake(self.contentSizeView.frame.origin.x,
												_kAdMobBannerHeight,
												self.contentSizeView.frame.size.width,
												self.view.frame.size.height - _kMRAIDBannerHeight - _kAdMobBannerHeight);
	}
	// Bottom banner resizes
	else if (self.MRAIDBanner == view)
	{
		_kMRAIDBannerHeight = size.height;
		
		self.contentSizeView.frame = CGRectMake(self.contentSizeView.frame.origin.x,
												self.contentSizeView.frame.origin.y,
												self.contentSizeView.frame.size.width,
												self.view.frame.size.height - _kMRAIDBannerHeight - _kAdMobBannerHeight);
	}
	
	[self updateContentViewSizeLabel];
}

@end
