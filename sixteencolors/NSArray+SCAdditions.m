//
//  NSArray+SCAdditions.m
//  sixteencolors
//
//  Created by Johan Halin on 4.9.2011.
//  Copyright (c) 2011 Aero Deko. All rights reserved.
//

#import "NSArray+SCAdditions.h"

@implementation NSArray (SCAdditions)

- (id)objectAtIndexOrNil:(NSInteger)index
{
	if (index > [self count] - 1 || [self count] == 0)
		return nil;
	
	return [self objectAtIndex:index];
}

- (id)firstObject
{
	return [self objectAtIndexOrNil:0];
}

@end
