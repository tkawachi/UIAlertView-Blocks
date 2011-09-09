//
//  UIAlertView+Blocks.m
//  Shibui
//
//  Created by Jiva DeVoe on 12/28/10.
//  Copyright 2010 Random Ideas, LLC. All rights reserved.
//

#import "UIAlertView+Blocks.h"
#import <objc/runtime.h>

static NSString *RI_BUTTON_ASS_KEY = @"com.random-ideas.BUTTONS";

@implementation UIAlertView (Blocks)

-(id)initWithTitle:(NSString *)title message:(NSString *)message cancelButtonItem:(RIButtonItem *)cancelButtonItem otherButtonItems:(RIButtonItem *)otherButtonItems, ... 
{
    if((self = [self initWithTitle:title message:message delegate:self cancelButtonTitle:cancelButtonItem.label otherButtonTitles:nil]))
    {
        NSMutableArray *buttonsArray = [NSMutableArray array];
        
        RIButtonItem *eachItem;
        va_list argumentList;
        if (otherButtonItems)                     
        {                                  
            [buttonsArray addObject:otherButtonItems];
            va_start(argumentList, otherButtonItems);       
            while((eachItem = va_arg(argumentList, RIButtonItem *))) 
            {
                [buttonsArray addObject: eachItem];            
            }
            va_end(argumentList);
        }    
        
        for(RIButtonItem *item in buttonsArray)
        {
            [self addButtonWithTitle:item.label];
        }
        
        if(cancelButtonItem)
            [buttonsArray insertObject:cancelButtonItem atIndex:0];
        
        objc_setAssociatedObject(self, RI_BUTTON_ASS_KEY, buttonsArray, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
        [self setDelegate:self];
        [self retain];
    }
    return self;
}

- (id)initWithTitle:(NSString *)title 
			message:(NSString *)message 
  cancelButtonTitle:(NSString *)cancelButtonTitle 
	  okButtonTitle:(NSString *)okButtonTitle 
	   cancelAction:(void (^)(void))cancelAction 
		   okAction:(void (^)(void))okAction
{
	if((self = [self initWithTitle:title message:message delegate:self cancelButtonTitle:cancelButtonTitle otherButtonTitles:okButtonTitle, nil]))
	{
		NSMutableArray *buttons = [NSMutableArray array];
        
		RIButtonItem *cancelItem = [[RIButtonItem alloc] initWithLabel:cancelButtonTitle action:cancelAction];
        RIButtonItem *okItem = [[RIButtonItem alloc] initWithLabel:okButtonTitle action:okAction];
      
		[buttons addObject:cancelItem];
		[buttons addObject:okItem];
        
		[okItem release];
		[cancelButtonTitle release];
        
        objc_setAssociatedObject(self, RI_BUTTON_ASS_KEY, buttons, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
        [self setDelegate:self];
        [self retain];
	}
	
	return self;
}

- (void)addButtonItem:(RIButtonItem *)item
{	
    NSMutableArray *buttonsArray = objc_getAssociatedObject(self, RI_BUTTON_ASS_KEY);	
	
	[self addButtonWithTitle:item.label];
	[buttonsArray addObject:item];	
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    NSArray *buttonsArray = objc_getAssociatedObject(self, RI_BUTTON_ASS_KEY);
    RIButtonItem *item = [buttonsArray objectAtIndex:buttonIndex];
    if(item.action)
        item.action();
    objc_setAssociatedObject(self, RI_BUTTON_ASS_KEY, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self release]; // and release yourself!
}

@end
