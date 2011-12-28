//
//  SCViewController.m
//  sixteencolors
//
//  Created by Johan Halin on 28.12.2011.
//  Copyright (c) 2011 Aero Deko. All rights reserved.
//

#import "SCViewController.h"

@interface SCViewController ()

@end

@implementation SCViewController

@synthesize requestManager;
@synthesize loadingSpinner;

- (void)loadView
{
	self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	self.view.backgroundColor = [UIColor whiteColor];
	
	self.loadingSpinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
	self.loadingSpinner.color = [UIColor grayColor];
	self.loadingSpinner.frame = CGRectMake(round((self.view.bounds.size.width / 2.0) - (self.loadingSpinner.bounds.size.width / 2.0)), round((self.view.bounds.size.height / 2.0) - (self.loadingSpinner.bounds.size.height / 2.0)), self.loadingSpinner.bounds.size.width, self.loadingSpinner.bounds.size.height);
	self.loadingSpinner.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
	[self.view addSubview:self.loadingSpinner];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) 
	{
	    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
	} 
	else 
	{
	    return YES;
	}
}

#pragma mark - Public

- (void)showLoadingSpinner
{
	self.loadingSpinner.hidden = NO;
	[self.view bringSubviewToFront:self.loadingSpinner];
	[self.loadingSpinner startAnimating];
}

- (void)hideLoadingSpinner
{
	self.loadingSpinner.hidden = YES;
	[self.loadingSpinner stopAnimating];
}

@end
