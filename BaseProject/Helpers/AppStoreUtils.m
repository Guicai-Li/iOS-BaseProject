//
//  AppStoreUtils.m
//  LazyLoadingTest1
//
//  Created by LiGuicai on 15/1/15.
//  Copyright (c) 2015年 liguicai. All rights reserved.
//

#import "AppStoreUtils.h"
#import "SystemUnit.h"

@implementation AppStoreUtils

/*
 *  跳转到App Store评分或者升级
 */
+ (void)gotoAppStore{
    NSString *url;
    if (SYSTEM_VERSION < 7) {
        url = APP_STORE_URL_7_UNDER;
    } else {
        url = APP_STORE_URL_7_SUPPER;
    }
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}

/*
 *  当前程序的版本号
 */
- (NSString *)version{
    
    //系统直接读取的版本号
    NSString *versionValueStringForSystemNow=[[NSBundle mainBundle].infoDictionary valueForKey:(NSString *)kCFBundleVersionKey];
    
    return versionValueStringForSystemNow;
}

@end
