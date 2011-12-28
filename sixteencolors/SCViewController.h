//
//  SCViewController.h
//  sixteencolors
//
//  Created by Johan Halin on 28.12.2011.
//  Copyright (c) 2011 Aero Deko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RequestManager.h"

@interface SCViewController : UIViewController

@property (nonatomic, strong) RequestManager *requestManager;
@property (nonatomic, strong) UIActivityIndicatorView *loadingSpinner;

- (void)showLoadingSpinner;
- (void)hideLoadingSpinner;

@end

