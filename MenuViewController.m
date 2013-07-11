//
//  MenuViewController.m
//  AdtechBannerPOC
//
//  Created by Alin Muntean on 7/10/13.
//  Copyright (c) 2013 RAM. All rights reserved.
//

#import "MenuViewController.h"
#import "ContentSizeViewController.h"
#import "VideoViewController.h"
#import "MediationViewController.h"
#import "ImageAdViewController.h"
#import "ImageResizeViewController.h"

@interface MenuViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) IBOutlet UITableView *menuTableView;

@end



@implementation MenuViewController

#pragma mark -
#pragma mark Table view delegate & data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *defaultCellIdentifier = @"DefaultCell";
    
    UITableViewCell *cell = [self.menuTableView dequeueReusableCellWithIdentifier:defaultCellIdentifier];
    if (nil == cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:defaultCellIdentifier];
	}
	
	NSString *text = nil;
	
	switch (indexPath.row)
	{
		case 0:
		{
			text = NSLocalizedString(@"Content Size", nil);
		}
			break;
			
		case 1:
		{
			text = NSLocalizedString(@"Mediation Ads", nil);
		}
			break;
			
		case 2:
		{
			text = NSLocalizedString(@"iTunes banner", nil);
		}
			break;
			
		case 3:
		{
			text = NSLocalizedString(@"Video Ads", nil);
		}
			break;
			
		case 4:
		{
			text = NSLocalizedString(@"Image resize ads", nil);
		}
			break;
			
		default:
			break;
	}
	
	cell.textLabel.text = text;
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[self.menuTableView deselectRowAtIndexPath:indexPath animated:YES];
	
	NSString *segue = nil;
	
	switch (indexPath.row)
	{
		case 0:
		{
			segue = @"contentSizeViewControllerSegue";
		}
			break;

		case 1:
		{
			segue = @"mediationViewControllerSegue";
		}
			break;
				
		case 2:
		{
			segue = @"imageAdViewControllerSegue";
		}
			break;
				
		case 3:
		{
			segue = @"videoViewControllerSegue";
		}
			break;
			
		case 4:
		{
			segue = @"imageResizeViewController";
		}
			break;

		default:
			break;
	}
	
	if (segue)
	{
		[self performSegueWithIdentifier:segue sender:self];
	}
}

@end
