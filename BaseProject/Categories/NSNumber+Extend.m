//
//  NSNumber+Extend.m
//  BaseProject
//
//  Created by Guicai_Li on 15/8/5.
//  Copyright (c) 2015年 Guicai_Li. All rights reserved.
//

#import "NSNumber+Extend.h"

@implementation NSNumber (Extend)

- (double)safeDouble{
    NSNumber *object = [self isKindOfClass:[NSNull class]] ?  __DOUBLE(0.0): self;
    double number = object !=nil ? [object doubleValue] :0;
    return number;
}

- (BOOL)numberIsInt{
    if([self floatValue] == [self intValue]){
        return YES;
    }else{
        return NO;
    }
}

- (BOOL)numberIsFloat{
    return ![self numberIsInt];
}

@end