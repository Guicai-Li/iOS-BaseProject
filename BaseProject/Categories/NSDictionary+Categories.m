//
//  NSDictionary+Check.m
//  BaseProject
//
//  Created by Guicai_Li on 14-6-5.
//  Copyright (c) 2014年 Guicai_Li. All rights reserved.
//

#import "NSDictionary+Categories.h"

@implementation NSDictionary (Categories)

+(BOOL)isEmpty:(NSDictionary *)dict{
    if(dict == nil || dict.count == 0)
        return YES;
    return NO;
}

@end
