//
//  SCListViewController.m
//  sixteencolors
//
//  Created by Johan Halin on 28.12.2011.
//  Copyright (c) 2011 Aero Deko. All rights reserved.
//

#import "SCListViewController.h"
#import "NSArray+SCAdditions.h"
#import "UIImageView+AFNetworking.h"

@interface SCListViewController ()
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *listContents;
@end

@implementation SCListViewController

@synthesize tableView = mTableView;
@synthesize listContents = mListContents;
@synthesize listType = mListType;
@synthesize year = mYear;
@synthesize packName = mPackName;

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
	
	if (self.listType == SCListTypeYear)
	{
		self.title = NSLocalizedString(@"Years", nil);
		
		[self.requestManager fetchYearList:^(NSArray *yearList) {
			bself.listContents = yearList;
			[bself.tableView reloadData];
		}];
	}
	else if (self.listType == SCListTypePacks)
	{
		self.title = [NSString stringWithFormat:NSLocalizedString(@"%@", nil), self.year];
		
		[self.requestManager fetchPacksForYear:self.year success:^(NSArray *packs) {
			bself.listContents = packs;
			[bself.tableView reloadData];
		}];
	}
	else if (self.listType == SCListTypePack)
	{
		self.title = [NSString stringWithFormat:NSLocalizedString(@"%@", nil), self.packName];
		
		[self.requestManager fetchPackWithName:self.packName success:^(NSDictionary *pack) {
			bself.listContents = [pack objectForKey:@"files"];
			[bself.tableView reloadData];
		}];
	}
	else
		NSLog(@"unknown list type");
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
	__block UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
	if (!cell)
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
	
	NSDictionary *item = [self.listContents objectAtIndexOrNil:indexPath.row];

	if (self.listType == SCListTypeYear)
	{
		cell.textLabel.text = [NSString stringWithFormat:NSLocalizedString(@"%d", nil), [[item objectForKey:@"year"] integerValue]];
		cell.detailTextLabel.text = [NSString stringWithFormat:NSLocalizedString(@"%d packs", nil), [[item objectForKey:@"packs"] integerValue]];
	}
	else if (self.listType == SCListTypePacks)
	{
		cell.textLabel.text = [item objectForKey:@"name"];
	}
	else if (self.listType == SCListTypePack)
	{
		cell.textLabel.text = [item objectForKey:@"filename"];
		UIImageView *thumb = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
		NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://sixteencolors.net%@", [item objectForKey:@"thumbnail"]]];
		NSURLRequest *req = [NSURLRequest requestWithURL:url];
		__block UITableView *tv = tableView;
		__block NSIndexPath *ip = indexPath;
		cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
		[thumb setImageWithURLRequest:req placeholderImage:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
				[tv reloadRowsAtIndexPaths:[NSArray arrayWithObject:ip] withRowAnimation:UITableViewRowAnimationNone];
		} failure:nil];
		cell.imageView.image = thumb.image;
	}
	else
		NSLog(@"unknown list type");

	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	
	return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	
	// starting to realize that this may not be the best design in existence
	if (self.listType == SCListTypeYear)
	{
		NSString *year = [[[self.listContents objectAtIndexOrNil:indexPath.row] objectForKey:@"year"] stringValue];
		SCListViewController *lvc = [[SCListViewController alloc] initWithNibName:nil bundle:nil];
		lvc.listType = SCListTypePacks;
		lvc.year = year;
		lvc.requestManager = self.requestManager;
		[self.navigationController pushViewController:lvc animated:YES];
	}
	else if (self.listType == SCListTypePacks)
	{
		NSString *pack = [[self.listContents objectAtIndexOrNil:indexPath.row] objectForKey:@"name"];
		SCListViewController *lvc = [[SCListViewController alloc] initWithNibName:nil bundle:nil];
		lvc.listType = SCListTypePack;
		lvc.packName = pack;
		lvc.requestManager = self.requestManager;
		[self.navigationController pushViewController:lvc animated:YES];
	}
	else if (self.listType == SCListTypePack)
	{
		// TODO
	}	
}

@end
