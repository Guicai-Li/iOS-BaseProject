//
//  SystemUnit.h
//  Unit
//
//  Created by LiGuicai on 15/1/9.
//  Copyright (c) 2015年 liguicai. All rights reserved.
//

#ifndef Unit_SystemUnit_h
#define Unit_SystemUnit_h
#import "SDiPhoneVersion.h"

#define DEBUG 1

#ifdef DEBUG
#define DLog(fmt, ...) NSLog((fmt), ##__VA_ARGS__);
#else
#define DLog(...)
#endif


/**
 *  接口
 */


/**
 *  一些常用通知定义
 */


/**
 *  一些常用字符串定义
 */


/**
 *  常用字体
 */

#define kFONT_SIZE_24 [UIFont systemFontOfSize:24]

#define kFONT_SIZE_18 [UIFont systemFontOfSize:18]

#define kFONT_SIZE_15 [UIFont systemFontOfSize:15]

#define kFONT_SIZE_13 [UIFont systemFontOfSize:13]

#define kFONT_SIZE_12 [UIFont systemFontOfSize:12]

#define kFONT_SIZE_10 [UIFont systemFontOfSize:10]

#define kFONT_SIZE_24_BOLD [UIFont boldSystemFontOfSize:24]

#define kFONT_SIZE_18_BOLD [UIFont boldSystemFontOfSize:18]

#define kFONT_SIZE_15_BOLD [UIFont boldSystemFontOfSize:15]

#define kFONT_SIZE_12_BOLD [UIFont boldSystemFontOfSize:12]

#define kFONT_SIZE_10_BOLD [UIFont boldSystemFontOfSize:10]

/**
 *  常见颜色
 */




/**
 *  设备信息
 */

//设备是否是iPhone4
#define DEVICE_IS_IPHONE4 [SDiPhoneVersion deviceVersion] == iPhone4

//设备是否是iPhone5
#define DEVICE_IS_IPHONE5 [SDiPhoneVersion deviceVersion] == iPhone5

//设备是否iPhone6
#define DEVICE_IS_IPHONE6 [SDiPhoneVersion deviceVersion] == iPhone6

//设备是否iPhone6plus
#define DEVICE_IS_IPHONE6_PLUS [SDiPhoneVersion deviceVersion] == iPhone6Plus

//设备屏幕宽度
#define DEVICE_SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width

//设备屏幕高度
#define DEVICE_SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height

//设备版本号
#define SYSTEM_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]


#endif
