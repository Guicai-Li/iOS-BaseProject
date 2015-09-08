//
//  AppMacro.h
//  BaseProject
//
//  Created by Guicai_Li on 15/8/10.
//  Copyright (c) 2015年 Guicai_Li. All rights reserved.
//

#ifndef BaseProject_AppMacro_h
#define BaseProject_AppMacro_h

/**
 *  DDLog参数
 */
#if DEBUG
static const int ddLogLevel = LOG_LEVEL_VERBOSE;
#else
static const int ddLogLevel = LOG_LEVEL_OFF;
#endif

/**
 *  AppStore
 */
#define APP_STORE_URL_7_UNDER @""

#define APP_STORE_URL_7_SUPPER @""


/**
 *  UMeng参数
 */
#define kUMengAppKey @"5507ae2afd98c5cb3f020175"
#define kUMengChannelId @"baidu.com"

#endif
