//
//  NSString+Regex.m
//  SharePlugins
//
//  Created by LiGuicai on 15/7/17.
//  Copyright (c) 2015年 guicai.li.china@gmail.com. All rights reserved.
//

#import "NSString+Regex.h"

@implementation NSString(Regex)

/**
 *  匹配邮箱
 */
- (BOOL)isEmail:(NSString *)str {
    NSString * regex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    return [self checkStringWithRegex:regex checkString:str];
}

/**
 *  匹配手机号码
 */
- (BOOL)isPhoneNumber:(NSString *)str {
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * regex = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    return [self checkStringWithRegex:regex checkString:str];
}

/**
 *  匹配中国移动手机号码
 */
- (BOOL)isCMPhoneNumber:(NSString *)str {
    NSString * regex = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    return [self checkStringWithRegex:regex checkString:str];
}

/**
 *  匹配中国联通手机号码
 */
- (BOOL)isCUPhoneNumber:(NSString *)str {
    NSString * regex = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    return [self checkStringWithRegex:regex checkString:str];
}

/**
 *  匹配中国电信手机号码
 */
- (BOOL)isCTPhoneNumber:(NSString *)str {
    NSString * regex = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    return [self checkStringWithRegex:regex checkString:str];
}

/**
 *  匹配国内电话号码
 */
- (BOOL)isCallNumber:(NSString *)str {
    NSString * regex = @"d{3}-d{8}|d{4}-d{7}";
    return [self checkStringWithRegex:regex checkString:str];
}

/**
 *  匹配QQ号码
 */
- (BOOL)isQQ:(NSString *)str {
    NSString * regex = @"[1-9][0-9]{4,}";
    return [self checkStringWithRegex:regex checkString:str];
}

/**
 *  匹配网址URL
 */
- (BOOL)isURL:(NSString *)str {
    NSString * regex = @"[a-zA-z]+://[^s]*";
    return [self checkStringWithRegex:regex checkString:str];
}

/**
 *  匹配帐号是否合法(字母开头，允许5-16字节，允许字母数字下划线)
 */
- (BOOL)isLegalCount:(NSString *)str {
    NSString * regex = @"^[a-zA-Z][a-zA-Z0-9_]{4,15}$";
    return [self checkStringWithRegex:regex checkString:str];
}

/**
 *  匹配中国邮政编码
 */
- (BOOL)isPostcode:(NSString *)str {
    NSString * regex = @"[1-9]d{5}(?!d)";
    return [self checkStringWithRegex:regex checkString:str];
}

/**
 *  匹配身份证
 */
- (BOOL)isIDCardNumber:(NSString *)str {
    NSString * regex = @"d{15}|d{18}";
    return [self checkStringWithRegex:regex checkString:str];
}

/**
 *  匹配ip地址
 */
-(BOOL)isIpAddress:(NSString *)str {
    NSString * regex = @"d+.d+.d+.d+";
    return [self checkStringWithRegex:regex checkString:str];
}

#pragma mark - private

- (BOOL)checkStringWithRegex:(NSString *)regex checkString:(NSString *)checkString {
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:checkString];
}

@end
