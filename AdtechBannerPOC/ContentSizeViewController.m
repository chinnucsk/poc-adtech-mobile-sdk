//
//  ViewController.m
//  AdtechBannerPOC
//
//  Created by Alin Muntean on 7/4/13.
//  Copyright (c) 2013 RAM. All rights reserved.
//

#import "ContentSizeViewController.h"

@interface ContentSizeViewController () <ATBannerViewDelegate, ATInterstitialViewDelegate>
{
	ATInterstitialView *_interstitialBanner;
	CGFloat _kORMMABannerHeight;
	CGFloat _kMRAIDBannerHeight;
}

@property (nonatomic, strong) IBOutlet ATBannerView *ORMMABanner;
@property (nonatomic, strong) IBOutlet ATBannerView *MRAIDBanner;

@property (nonatomic, strong) IBOutlet UIView *contentSizeView;
@property (nonatomic, strong) IBOutlet UILabel *contentSizeLabel;

- (IBAction)loadAdMobButtonPressed:(id)sender;
- (IBAction)loadMRAIDButtonPressed:(id)sender;

@end



@implementation ContentSizeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	// Interstitial
	_interstitialBanner = [[ATInterstitialView alloc] init];
	_interstitialBanner.configuration = [self configurationWithDomain:nil network:23 subNetwork:4 andAlias:@"interstitial-top-5"];
	_interstitialBanner.delegate = self;
	_interstitialBanner.viewController = self;
	
	[_interstitialBanner load];
	
	// ORMMA	
	self.ORMMABanner.configuration = [self configurationWithDomain:@"a.adtech.de" network:23 subNetwork:10 andAlias:@"test"];
	self.ORMMABanner.viewController = self;
	self.ORMMABanner.delegate = self;
	
	[self.ORMMABanner load];
	
	// MRAID
	self.MRAIDBanner.configuration = [self configurationWithDomain:@"a.adtech.de" network:23 subNetwork:10 andAlias:@"testmraid"];
	self.MRAIDBanner.viewController = self;
	self.MRAIDBanner.delegate = self;
	
	[self.MRAIDBanner load];
	
	// Show middle View size and set default values for static members
	self.contentSizeView.frame = CGRectMake(self.contentSizeView.frame.origin.x,
											self.ORMMABanner.frame.size.height,
											self.contentSizeView.frame.size.width,
											self.view.frame.size.height - self.ORMMABanner.frame.size.height - self.MRAIDBanner.frame.size.height
											);
	[self updateContentViewSizeLabel];
	
	_kORMMABannerHeight = self.ORMMABanner.frame.size.height;
	_kMRAIDBannerHeight = self.MRAIDBanner.frame.size.height;
}

- (void)viewDidUnload
{
	self.MRAIDBanner = nil;
	self.ORMMABanner = nil;
	self.contentSizeLabel = nil;
	self.contentSizeView = nil;
	
	[super viewDidUnload];
}

- (void)viewDidAppear:(BOOL)animated
{
	self.MRAIDBanner.visible = YES;
	self.ORMMABanner.visible = YES;
	
	[super viewDidAppear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
	
	self.MRAIDBanner.visible = NO;
	self.ORMMABanner.visible = NO;
}

- (IBAction)loadAdMobButtonPressed:(id)sender
{
	[self.ORMMABanner load];
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
	if (self.ORMMABanner == view)
	{
		_kORMMABannerHeight = size.height;
		
		self.contentSizeView.frame = CGRectMake(self.contentSizeView.frame.origin.x,
												_kORMMABannerHeight,
												self.contentSizeView.frame.size.width,
												self.view.frame.size.height - _kMRAIDBannerHeight - _kORMMABannerHeight);
	}
	// Bottom banner resizes
	else if (self.MRAIDBanner == view)
	{
		_kMRAIDBannerHeight = size.height;
		
		self.contentSizeView.frame = CGRectMake(self.contentSizeView.frame.origin.x,
												self.contentSizeView.frame.origin.y,
												self.contentSizeView.frame.size.width,
												self.view.frame.size.height - _kMRAIDBannerHeight - _kORMMABannerHeight);
	}
	
	[self updateContentViewSizeLabel];
}

@end
