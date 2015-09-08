//
//  NSString+Regex.h
//  SharePlugins
//
//  Created by LiGuicai on 15/7/17.
//  Copyright (c) 2015年 guicai.li.china@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString(Regex)

/**
 *  匹配邮箱
 */
- (BOOL)isEmail:(NSString *)str;

/**
 *  匹配手机号码
 */
- (BOOL)isPhoneNumber:(NSString *)str;

/**
 *  匹配中国移动手机号码
 */
- (BOOL)isCMPhoneNumber:(NSString *)str;

/**
 *  匹配中国联通手机号码
 */
- (BOOL)isCUPhoneNumber:(NSString *)str;

/**
 *  匹配中国电信手机号码
 */
- (BOOL)isCTPhoneNumber:(NSString *)str;

/**
 *  匹配国内电话号码
 */
- (BOOL)isCallNumber:(NSString *)str;

/**
 *  匹配QQ号码
 */
- (BOOL)isQQ:(NSString *)str;

/**
 *  匹配网址URL的正则表达式
 */
- (BOOL)isURL:(NSString *)str;

/**
 *  匹配帐号是否合法(字母开头，允许5-16字节，允许字母数字下划线)
 */
- (BOOL)isLegalCount:(NSString *)str;

/**
 *  匹配中国邮政编码
 */
- (BOOL)isPostcode:(NSString *)str;

/**
 *  匹配身份证
 */
- (BOOL)isIDCardNumber:(NSString *)str;

/**
 *  匹配ip地址
 */
-(BOOL)isIpAddress:(NSString *)str;




@end
