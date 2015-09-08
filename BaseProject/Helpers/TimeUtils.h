//
//  TimeUtils.h
//  封装
//
//  Created by LiGuicai on 15/5/13.
//  Copyright (c) 2015年 guicai.li.china@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimeUtils : NSObject

+ (instancetype)sharedInstance;

#pragma mark - 时间处理


+ (NSString *)getSystemTimeString;

/**
 *  获取系统时间,按照指定格式
 *
 *  @param format 格式字符串
 *
 *  @return 指定格式时间字符串
 */
+ (NSString *)getSystemTimeStringWithFormat:(NSString *)format;

/**
 *  时间戳转日期
 *
 *  @param timeInterval 时间(毫秒)
 *  @param formatString 格式字符串
 *
 *  @return 指定格式时间字符串
 */
+ (NSString *)secondToDate:(long long)timeInterval WithFormat:(NSString *)formatString;

/**
 *  发言时间显示
 *
 *  @param timeInterval 时间戳
 *
 *  1.小于一分钟：刚刚
 *  2.小于一小时：x分钟前
 *  3.超过一小时，小于24小时：x小时前
 *  4.超过1天，小于7天：x天前
 *  5.其余显示：yyyy/MM/dd HH:mm
 *
 *  @return 指定格式字符串
 */
+ (NSString *)intervalSinceNow:(long long)timeInterval;



@end
