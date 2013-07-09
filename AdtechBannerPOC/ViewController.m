//
//  ViewController.m
//  AdtechBannerPOC
//
//  Created by Alin Muntean on 7/4/13.
//  Copyright (c) 2013 RAM. All rights reserved.
//

#import "ViewController.h"

static CGFloat kORMMABannerHeight;
static CGFloat kMRAIDBannerHeight;

@interface ViewController () <ATBannerViewDelegate, ATInterstitialViewDelegate>
{
	ATInterstitialView *adtechInterstitialBanner;
}

@property (nonatomic, strong) IBOutlet ATBannerView *adtechORMMABanner;
@property (nonatomic, strong) IBOutlet ATBannerView *adtechMRAIDBanner;

@property (nonatomic, strong) IBOutlet UIView *currentSizeView;
@property (nonatomic, strong) IBOutlet UILabel *currentSizeLabel;

- (IBAction)loadORMMAButtonPressed:(id)sender;
- (IBAction)loadMRAIDButtonPressed:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	// Interstitial
	ATAdtechAdConfiguration *interstitialConfiguration = [ATAdtechAdConfiguration configuration];
    interstitialConfiguration.alias = @"interstitial-top-5";
    interstitialConfiguration.networkID = 23;
    interstitialConfiguration.subNetworkID = 4;
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
	
	// Show middle View size and set default values for static members
	self.currentSizeView.frame = CGRectMake(self.currentSizeView.frame.origin.x,
											self.adtechORMMABanner.frame.size.height,
											self.currentSizeView.frame.size.width,
											self.view.frame.size.height - self.adtechORMMABanner.frame.size.height - self.adtechMRAIDBanner.frame.size.height
											);
	[self showCurrentViewSize];
	
	kORMMABannerHeight = self.adtechORMMABanner.frame.size.height;
	kMRAIDBannerHeight = self.adtechMRAIDBanner.frame.size.height;
}

- (void)viewDidUnload
{
	self.adtechMRAIDBanner = nil;
	self.adtechORMMABanner = nil;
	self.currentSizeLabel = nil;
	self.currentSizeView = nil;
	
	[super viewDidUnload];
}

- (void)viewDidAppear:(BOOL)animated
{
	self.adtechMRAIDBanner.visible = YES;
	self.adtechORMMABanner.visible = YES;
	
	[super viewDidAppear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
	
	self.adtechMRAIDBanner.visible = NO;
	self.adtechORMMABanner.visible = NO;
}

- (IBAction)loadORMMAButtonPressed:(id)sender
{
	[self.adtechORMMABanner load];
}

- (IBAction)loadMRAIDButtonPressed:(id)sender
{
	[self.adtechMRAIDBanner load];
}

- (void)showCurrentViewSize
{
	self.currentSizeLabel.text = [NSString stringWithFormat:@"x: %.f, y: %.f - W: %.f x H: %.f",
								  self.currentSizeView.frame.origin.x,
								  self.currentSizeView.frame.origin.y,
								  self.currentSizeView.frame.size.width,
								  self.currentSizeView.frame.size.height];
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

#pragma mark - ATBannerViewDelegate

- (void)didFetchNextAd:(ATBannerView *)view
{
	view.hidden = NO;
}

- (void)willResizeAd:(ATBannerView *)view toSize:(CGSize)size
{
	// Top banner resizes
	if (self.adtechORMMABanner == view)
	{
		kORMMABannerHeight = size.height;
		
		self.currentSizeView.frame = CGRectMake(self.currentSizeView.frame.origin.x,
												kORMMABannerHeight,
												self.currentSizeView.frame.size.width,
												self.view.frame.size.height - kMRAIDBannerHeight - kORMMABannerHeight);
	}
	// Bottom banner resizes
	else if (self.adtechMRAIDBanner == view)
	{
		kMRAIDBannerHeight = size.height;
		
		self.currentSizeView.frame = CGRectMake(self.currentSizeView.frame.origin.x,
												self.currentSizeView.frame.origin.y,
												self.currentSizeView.frame.size.width,
												self.view.frame.size.height - kMRAIDBannerHeight - kORMMABannerHeight);
	}
	
	[self showCurrentViewSize];
}

@end
