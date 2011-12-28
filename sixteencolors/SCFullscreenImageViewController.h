//
//  SCFullscreenImageViewController.h
//  sixteencolors
//
//  Created by Johan Halin on 28.12.2011.
//  Copyright (c) 2011 Aero Deko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCViewController.h"

@interface SCFullscreenImageViewController : SCViewController
@property (nonatomic, strong) NSString *filename;
@property (nonatomic, strong) NSURL *url;
@end
