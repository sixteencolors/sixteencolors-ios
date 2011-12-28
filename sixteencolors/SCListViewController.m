//
//  SCListViewController.m
//  sixteencolors
//
//  Created by Johan Halin on 28.12.2011.
//  Copyright (c) 2011 Aero Deko. All rights reserved.
//

#import "SCListViewController.h"
#import "NSArray+SCAdditions.h"

@interface SCListViewController ()
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *listContents;
@end

@implementation SCListViewController

@synthesize tableView = mTableView;
@synthesize listContents = mListContents;

#pragma mark - Private

- (void)sc_yearListUpdatedWithList:(NSArray *)list
{
	self.listContents = list;
	[self.tableView reloadData];
}

#pragma mark - View lifecycle etc

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]))
	{
    }

    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

	self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
	self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	self.tableView.dataSource = self;
	self.tableView.delegate = self;
	[self.view addSubview:self.tableView];
	
	__block SCListViewController *bself = self;
	[self.requestManager fetchYearList:^(NSArray *yearList) {
		[bself sc_yearListUpdatedWithList:yearList];
	}];
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

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [self.listContents count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSString *cellIdentifier = @"Cell";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
	if (!cell)
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
	
	NSDictionary *year = [self.listContents objectAtIndexOrNil:indexPath.row];
	cell.textLabel.text = [NSString stringWithFormat:NSLocalizedString(@"%d", nil), [[year objectForKey:@"year"] integerValue]];
	cell.detailTextLabel.text = [NSString stringWithFormat:NSLocalizedString(@"%d packs", nil), [[year objectForKey:@"packs"] integerValue]];
	
	return cell;
}

@end
