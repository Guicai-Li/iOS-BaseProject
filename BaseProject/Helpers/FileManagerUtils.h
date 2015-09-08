//
//  FileManagerUtils.h
//  封装
//
//  Created by LiGuicai on 15/5/13.
//  Copyright (c) 2015年 guicai.li.china@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SystemUnit.h"

@interface FileManagerUtils : NSObject


/**
 *  创建一个单例
 *
 *  @return 返回 FileManagerUtils 单例
 */
+ (instancetype)sharedInstance;

#pragma mark - 文件操作
/**
 *  获取document路径
 *
 *  @return document路径
 */
+ (NSString *)getDocumentsPath;

/**
 *  获取document下其他目录路径
 *
 *  @return 其他目录路径
 */
+ (NSString *)getOtherPath : (NSString *)otherDirectoryName;

/**
 *  判断文件在Document里是否存在
 *
 *  @param fileName      文件名
 *  @param directoryName 目录名
 *
 *  @return YES/NO
 */
+ (BOOL)fileIsExistInDocument:(NSString *)fileName directoryName:(NSString *)directoryName;

/**
 *  获取Document中指定文件的路径
 *
 *  @param fileName      文件名
 *  @param directoryName 目录名
 *
 *  @return 文件的路径
 */
+ (NSString *)getFilePathFromDocument:(NSString *)fileNname directoryName:(NSString *)directoryName;

/**
 *  获取Caches路径
 *
 *  @return Caches路径
 */
+ (NSString *)getCachesPath;

/**
 *  判断文件在Caches里是否存在
 *
 *  @param fileName      文件名
 *  @param directoryName 目录名
 *
 *  @return YES/NO
 */
+ (BOOL)fileIsExistInCaches:(NSString *)fileName directoryName:(NSString *)directoryName;

/**
 *  创建文件夹
 *
 *  @param directoryName    目录名
 */
+ (void)createResDirByDirectoryName:(NSString *)directoryName;

/**
 *  重命名文件
 *
 *  @param directoryName 目录名
 *  @param oldFileName   旧文件名
 *  @param newFileName   新文件名
 */
+ (void)renameFileByDirectoryName:(NSString *)directoryName oldFileName:(NSString *)oldFileName newFileName:(NSString *)newFileName;

/**
 *  删除document里指定文件夹或文件
 *
 *  @param directoryName 文件夹或文件
 *
 *  @return YES/NO
 */
+ (BOOL)deleteFolderAndSubFile:(NSString *)directoryName;

/**
 *  移动文件夹里面文件到指定文件夹
 *
 *  @param directoryName 目录路径
 *  @param toPath        目标目录路径
 *
 *  @return YES/NO
 */
+ (BOOL)moveFolderSubFile:(NSString *)directoryName toFolderPath:(NSString *)toPath;

/**
 *  复制文件夹里面文件到指定文件夹
 *
 *  @param directoryName 目录路径
 *  @param toPath        目标目录路径
 *
 *  @return YES/NO
 */
+ (BOOL)copyFolderSubFile:(NSString *)directoryName toFolderPath:(NSString *)toPath;

/**
 *  复制文件
 *
 *  @param path   原路径
 *  @param toPath 目标路径
 */
+ (void)copyFileByPath:(NSString *)path toPath:(NSString *)toPath;

@end
