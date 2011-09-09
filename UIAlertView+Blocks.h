//
//  UIAlertView+Blocks.h
//  Shibui
//
//  Created by Jiva DeVoe on 12/28/10.
//  Copyright 2010 Random Ideas, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RIButtonItem.h"

@interface UIAlertView (Blocks)

- (id)initWithTitle:(NSString *)title message:(NSString *)message cancelButtonItem:(RIButtonItem *)cancelButtonItem otherButtonItems:(RIButtonItem *)otherButtonItems, ... NS_REQUIRES_NIL_TERMINATION;
- (id)initWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle okButtonTitle:(NSString *)okButtonTitle cancelAction:(void (^)(void))cancelAction okAction:(void (^)(void))okAction;

- (void)addButtonItem:(RIButtonItem *)item;

@end
