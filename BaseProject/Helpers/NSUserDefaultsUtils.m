//
//  NSUserDefaultsUtils.m
//  封装
//
//  Created by LiGuicai on 15/5/13.
//  Copyright (c) 2015年 guicai.li.china@gmail.com. All rights reserved.
//

#import "NSUserDefaultsUtils.h"

@implementation NSUserDefaultsUtils

/**
 *  应用是否启动过
 */
static NSString *applicationEverLaunched = @"everLaunched";

/**
 *  是否是第一次启动
 */
static NSString *applicationFirstLaunched = @"firstLaunch";

/**
 *  是否是第一次提示升级
 */
static NSString *aplicationFirstHintUpdate = @"firstHintUpdate";

/**
 *  用户是否评分过
 */
static NSString *userNeverGrade = @"neverGrade";


/**
 *  创建一个单例
 *
 *  @return 返回 NSUserDefaultsUtils 单例
 */
+ (instancetype) sharedInstance {
    static NSUserDefaultsUtils *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[NSUserDefaultsUtils alloc] init];
    });
    return sharedInstance;
}

/**
 *  是否启动过应用
 */
- (BOOL)isEverLaunched {
    return [[NSUserDefaults standardUserDefaults] boolForKey:applicationEverLaunched];
}

- (void)setEverLaunched:(BOOL)everLaunched {
    [[NSUserDefaults standardUserDefaults] setBool:everLaunched forKey:applicationEverLaunched];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

/**
 *  是否是第一次启动应用
 */
- (BOOL)isFirstLaunched {
    return [[NSUserDefaults standardUserDefaults] boolForKey:applicationFirstLaunched];
}

- (void)setFirstLaunched:(BOOL)firstLaunch {
    [[NSUserDefaults standardUserDefaults] setBool:firstLaunch forKey:applicationFirstLaunched];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

/**
 *  是否是第一次提示升级
 */
- (BOOL)isFirstHintUpdate {
    return [[NSUserDefaults standardUserDefaults] boolForKey:aplicationFirstHintUpdate];
}

- (void)setFirstHintUpdate:(BOOL)firstHintUpdate {
    [[NSUserDefaults standardUserDefaults] setBool:firstHintUpdate forKey:aplicationFirstHintUpdate];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

/**
 *  用户是否评分过
 */
- (NSString *)neverGrade {
    return [[NSUserDefaults standardUserDefaults] objectForKey:userNeverGrade];
}

- (void)setNeverGrade:(NSString *)neverGrade {
    [[NSUserDefaults standardUserDefaults] setObject:neverGrade forKey:userNeverGrade];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
