//
//  SCListViewController.h
//  sixteencolors
//
//  Created by Johan Halin on 28.12.2011.
//  Copyright (c) 2011 Aero Deko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCViewController.h"

typedef enum
{
	SCListTypeYear = 0,
	SCListTypePacks, // list of packs
	SCListTypePack, // pack contents
} SCListType;

@interface SCListViewController : SCViewController <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, assign) SCListType listType;
@property (nonatomic, strong) NSString *year;
@property (nonatomic, strong) NSString *packName;
@end
