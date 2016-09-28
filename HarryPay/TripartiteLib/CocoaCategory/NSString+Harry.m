//
//  NSString+Harry.m
//  HarryPay
//
//  Created by Harry on 15/1/28.
//  Copyright (c) 2015年 Harry. All rights reserved.
//

#import "NSString+Harry.h"

@implementation NSString (Localize)

- (NSString *)localize{
    NSString *s = NSLocalizedString(self, self);
    return s;
    return NSLocalizedString(self, self);
}

@end
