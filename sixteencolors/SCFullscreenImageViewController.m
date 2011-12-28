//
//  SCFullscreenImageViewController.m
//  sixteencolors
//
//  Created by Johan Halin on 28.12.2011.
//  Copyright (c) 2011 Aero Deko. All rights reserved.
//

#import "SCFullscreenImageViewController.h"
#import "UIImageView+AFNetworking.h"

@interface SCFullscreenImageViewController ()
@end

@implementation SCFullscreenImageViewController

@synthesize filename;
@synthesize url;

#pragma mark - View lifecycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
	self.view.backgroundColor = [UIColor blackColor];
	[self showLoadingSpinner];
	
	UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.frame];
	imageView.contentMode = UIViewContentModeScaleAspectFit;
	NSURLRequest *req = [NSURLRequest requestWithURL:self.url];
	__block SCFullscreenImageViewController *bself = self;
	[imageView setImageWithURLRequest:req placeholderImage:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
		[bself hideLoadingSpinner];
	} failure:nil];
	[self.view addSubview:imageView];
	
	self.title = self.filename;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
