//
//  NSDictionary+Check.h
//  BaseProject
//
//  Created by Guicai_Li on 14-6-5.
//  Copyright (c) 2014年 Guicai_Li. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Categories)

/**
 *  非空校验（nil或者元素个数为0）
 *
 *  @return 是否为空
 */
+(BOOL)isEmpty:(NSDictionary *)dict;

@end
