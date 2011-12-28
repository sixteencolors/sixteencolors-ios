//
//  RequestManager.m
//  sixteencolors
//
//  Created by Johan Halin on 28.12.2011.
//  Copyright (c) 2011 Aero Deko. All rights reserved.
//

#import "RequestManager.h"
#import "AFNetworking.h"

@implementation RequestManager

- (void)fetchYearList:(void (^)(NSArray *yearList))success
{
	__block NSArray *yearList = nil;

	NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://api.sixteencolors.net/v0/year"]];
	AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
		if ([JSON isKindOfClass:[NSArray class]])
		{
			yearList = JSON;
			success(yearList);
		}
	} failure:nil];
	
	NSOperationQueue *queue = [[NSOperationQueue alloc] init];
	[queue addOperation:operation];
}

- (void)fetchPacksForYear:(NSString *)year success:(void (^)(NSArray *packs))success
{
}

@end
