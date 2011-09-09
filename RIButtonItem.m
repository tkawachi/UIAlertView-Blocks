//
//  RIButtonItem.m
//  Shibui
//
//  Created by Jiva DeVoe on 1/12/11.
//  Copyright 2011 Random Ideas, LLC. All rights reserved.
//

#import "RIButtonItem.h"

@implementation RIButtonItem

@synthesize label = _label;
@synthesize action = _action;

+ (id)item
{
    return [[[self alloc] init] autorelease];
}

+ (id)itemWithLabel:(NSString *)label
{
    return [[[self alloc] initWithLabel:label] autorelease];
}

+ (id)itemWithLabel:(NSString *)label action:(void (^)(void))action
{
	return [[[self alloc] initWithLabel:label action:action] autorelease];
}

- (id)init
{
	if ((self = [self initWithLabel:nil action:nil]))
	{
	}
	
	return self;
}

- (id)initWithLabel:(NSString *)label
{
	if ((self = [self initWithLabel:label action:nil]))
	{
	}
	
	return self;
}

- (id)initWithLabel:(NSString *)label action:(void (^)(void))action
{
	if ((self = [super init]))
	{
		self.label = label;
		self.action = action;
	}
	
	return self;
}

- (void)dealloc
{
    [_action release]; _action = nil;
    [_label release]; _label = nil;
	
    [super dealloc];
}

@end

