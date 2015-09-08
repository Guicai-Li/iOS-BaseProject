//
//  NSDate+Categories.h
//  BaseProject
//
//  Created by Guicai_Li on 3/13/14.
//  Copyright (c) 2014 Guicai_Li. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Categories)

/**
 *  计算两个时间戳之间的天数间隔
 *
 *  @param fromDateTime 从哪一天开始算
 *  @param toDateTime   到哪一天
 *
 *  @return 时间戳间隔的天数
 */
+ (BOOL)daysBetweenDate:(NSDate *)fromDateTime andDate:(NSDate *)toDateTime;

/**
 *  保存最后一次打开时间
 */
+ (void)saveLastOpenDate;

/**
 *  当前中国时间
 *
 *  @return 返回中国时间，去除8个小时的时间差
 */
+ (NSDate *)ChinaDate;

/**
 *  最后一次打开时间
 *
 *  @return 返回最后一次打开时间
 */
+ (NSDate *)lastOpenDate;

+ (void)saveLastOpenDiagnoseDate;

+ (NSDate *)lastOpenDiagnose;
@end
