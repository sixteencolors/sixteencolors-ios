//
//  RequestManager.h
//  sixteencolors
//
//  Created by Johan Halin on 28.12.2011.
//  Copyright (c) 2011 Aero Deko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RequestManager : NSObject

// TODO: add failure handling and actual model objects, not just stupid arrays and dictionaries

- (void)fetchYearList:(void (^)(NSArray *yearList))success;
- (void)fetchPacksForYear:(NSString *)year success:(void (^)(NSArray *packs))success;
- (void)fetchPackWithName:(NSString *)name success:(void (^)(NSDictionary *pack))success;

@end
