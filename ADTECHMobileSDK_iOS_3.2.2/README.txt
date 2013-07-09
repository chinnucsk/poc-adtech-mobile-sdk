ADTECH Mobile SDK
Version 3.2.2

* Purpose

The main purpose of the SDK is to help the application developers with placing ads inside their developed applications. The SDK is intended to have a simple, consistent and user friendly interface that helps developers to seamlessly integrate in their applications banners, interstitial ads and video ads.


* Contents

The SDK is delivered as a ZIP package. Its content includes the following:

 - The binaries and the resources: the SDK library together with the header files (packaged as a framework) and some additional configuration files
 - Documentation: the SDK interface documentation
 - Sample application: a sample application that works out of the box, where the SDK is included and used in a simple way
 - Readme.txt: this file
 - License.txt: text file containing the license statements for the SDK and the third party libraries used

* API Differences

3.2 -> 3.2.1

** Added APIs

Added to ATVideoAdConfiguration
@property (nonatomic, copy) NSString *videoType;

** Changed APIs

ATAdConfiguration.refreshInterval is now deprecated.
ATAdConfiguration.animation is now deprecated.

3.1 -> 3.2

** Added APIs

ATRubiconConfiguration class

Added to ATAdConfiguration
@property(nonatomic,copy,readonly) ATRubiconConfiguration *rubiconConfig;

Added to ATBannerViewDelegate
[ATBannerViewDelegate didStopOnCustomMediation:];

Added to ATInterstitialViewDelegate
[ATInterstitialViewDelegate didFetchCustomMediation:];

3.0.1 -> 3.1

** Added APIs

ATAdtechAdConfiguration class
ATGenericAdConfiguration class
ATAdtechVideoAdConfiguration class

Added to ATBaseConfiguration
@property(nonatomic,copy) NSString *schema;
@property(nonatomic,assign) NSUInteger port;

Added to ATAdConfiguration
@property(nonatomic,readwrite) BOOL hideAfterRefreshInterval;

3.0 -> 3.0.1

** Added APIs

ATBaseConfiguration
[ATBaseConfiguration openLandingPagesThroughBrowser]

2.2.4 -> 3.0

** Changed APIs

ATInterstitialView now inherits from NSObject instead of UIView

ATAdConfiguration.maxSize is now deprecated. Using it has no effect.

2.2 -> 2.2.1

** Added APIs

ATAdConfiguration
@property(nonatomic,readwrite) BOOL enableImageBannerResize;

2.1 -> 2.2

** Added APIs

ATBaseConfiguration
[ATBaseConfiguration version]

ATMoviePlayerController
[ATMoviePlayerController configuration]
[ATMoviePlayerController presentingViewController]


ATVideoAdConfiguration
[ATVideoAdConfiguration videoDimension]
[ATVideoAdConfiguration videoLength]
[ATVideoAdConfiguration videoBitrate]
[ATVideoAdConfiguration overlays]
[ATVideoAdConfiguration maxWrapperRedirections]
[ATVideoAdConfiguration isValid]
[ATVideoAdConfiguration enableAdType:]
[ATVideoAdConfiguration disableAdType:]
[ATVideoAdConfiguration isAdTypeEnabled:]
[ATVideoAdConfiguration addOverlay:]
[ATVideoAdConfiguration removeOverlay:]

ATVideoAdOverlay
[ATVideoAdOverlay startTime]
[ATVideoAdOverlay duration]
[ATVideoAdOverlay placement]
[ATVideoAdOverlay percentOfMargin]
[ATVideoAdOverlay secondsUntilDismissable]
[ATVideoAdOverlay overlayWithStartTime:andDuration:]

ATVideoAdType
ATVideoAdOverlayPlacement
ATVideoAdOverlayDismissTime