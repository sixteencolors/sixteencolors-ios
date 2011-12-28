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
	NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://api.sixteencolors.net/v0/year"]];
	AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
		if ([JSON isKindOfClass:[NSArray class]])
		{
			NSArray *yearList = JSON;
			success(yearList);
		}
	} failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
		NSLog(@"year list failed: %@", [error localizedDescription]);
	}];
	
	NSOperationQueue *queue = [[NSOperationQueue alloc] init];
	[queue addOperation:operation];
}

- (void)fetchPacksForYear:(NSString *)year success:(void (^)(NSArray *packs))success
{
	NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://api.sixteencolors.net/v0/year/%@?rows=*", year]]];
	AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
		if ([JSON isKindOfClass:[NSArray class]])
		{
			NSArray *packList = JSON;
			success(packList);
		}
	} failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
		NSLog(@"year pack list failed: %@", [error localizedDescription]);
	}];
	
	NSOperationQueue *queue = [[NSOperationQueue alloc] init];
	[queue addOperation:operation];
}

- (void)fetchPackWithName:(NSString *)name success:(void (^)(NSDictionary *pack))success
{
	NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://api.sixteencolors.net/v0/pack/%@", name]]];
	AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
		if ([JSON isKindOfClass:[NSDictionary class]])
		{
			NSDictionary *pack = JSON;
			success(pack);
		}
	} failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
		NSLog(@"pack failed: %@", [error localizedDescription]);
	}];
	
	NSOperationQueue *queue = [[NSOperationQueue alloc] init];
	[queue addOperation:operation];
}

@end
