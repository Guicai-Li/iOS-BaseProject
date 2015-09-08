//
//  FileManagerUtils.m
//  封装
//
//  Created by LiGuicai on 15/5/13.
//  Copyright (c) 2015年 guicai.li.china@gmail.com. All rights reserved.
//

#import "FileManagerUtils.h"

@implementation FileManagerUtils

/**
 *  创建一个单例
 *
 *  @return 返回 FileManagerUtils 单例
 */
+ (instancetype)sharedInstance {
    static FileManagerUtils *singleton = nil;
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        singleton = [[FileManagerUtils alloc] init];
    });
    return singleton;
}

#pragma mark - 文件操作
/**
 *  获取document路径
 *
 *  @return document路径
 */
+ (NSString *)getDocumentsPath {
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [pathArray objectAtIndex:0];
    return documentPath;
}

/**
 *  获取document下其他目录路径
 *
 *  @return 其他目录路径
 */
+ (NSString *)getOtherPath : (NSString *)otherDirectoryName {
    NSString *documentPath = [self getDocumentsPath];
    NSString *otherPath = [documentPath stringByAppendingPathComponent:otherDirectoryName];
    return otherPath;
}

/**
 *  判断文件在Document里是否存在
 *
 *  @param fileName      文件名
 *  @param directoryName 目录名
 *
 *  @return YES/NO
 */
+ (BOOL)fileIsExistInDocument:(NSString *)fileName directoryName:(NSString *)directoryName {
    NSString *documentsDirectory = [self getDocumentsPath];
    NSString *filePath = [[documentsDirectory stringByAppendingPathComponent:directoryName] stringByAppendingPathComponent:fileName];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager fileExistsAtPath:filePath];
}

/**
 *  获取Document中指定文件的路径
 *
 *  @param fileName      文件名
 *  @param directoryName 目录名
 *
 *  @return 文件的路径
 */
+ (NSString *)getFilePathFromDocument:(NSString *)fileNname directoryName:(NSString *)directoryName {
    NSString *path = [self getOtherPath:directoryName];
    return [path stringByAppendingPathComponent:fileNname];
}

/**
 *  获取Caches路径
 *
 *  @return Caches路径
 */
+ (NSString *)getCachesPath {
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [pathArray objectAtIndex:0];
    return documentPath;
}

/**
 *  判断文件在Caches里是否存在
 *
 *  @param fileName      文件名
 *  @param directoryName 目录名
 *
 *  @return YES/NO
 */
+ (BOOL)fileIsExistInCaches:(NSString *)fileName directoryName:(NSString *)directoryName {
    NSString *cachesDirectory = [self getCachesPath];
    NSString *filePath = [[cachesDirectory stringByAppendingPathComponent:directoryName] stringByAppendingPathComponent:fileName];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager fileExistsAtPath:filePath];
}

/**
 *  创建文件夹
 *
 *  @param directoryName    目录名
 */
+ (void)createResDirByDirectoryName:(NSString *)directoryName {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir = TRUE;
    BOOL isDirExist = [fileManager fileExistsAtPath:[FileManagerUtils getOtherPath:directoryName] isDirectory:&isDir];
    if (!(isDirExist && isDir)) {
        BOOL dCreateDir = [fileManager createDirectoryAtPath:[[FileManagerUtils getDocumentsPath] stringByAppendingPathComponent:directoryName] withIntermediateDirectories:YES attributes:nil error:nil];
        if (!dCreateDir) {
            DLog(@"Create Res Directory Failed.");
        }
    }
}

/**
 *  重命名文件
 *
 *  @param directoryName 目录名
 *  @param oldFileName   旧文件名
 *  @param newFileName   新文件名
 */
+ (void)renameFileByDirectoryName:(NSString *)directoryName oldFileName:(NSString *)oldFileName newFileName:(NSString *)newFileName {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //通过移动该文件对文件重命名
    NSString *oldFilePath = [self getFilePathFromDocument:oldFileName directoryName:directoryName];
    NSString *newFilePath = [self getFilePathFromDocument:newFileName directoryName:directoryName];
    NSError *error = [[NSError alloc] init];
    //判断是否移动
    if ([fileManager moveItemAtPath:oldFilePath toPath:newFilePath error:&error] != YES) {
        DLog(@"Unable to move file: %@", [error localizedDescription]);
    }
    //显示文件目录的内容
    DLog(@"Documentsdirectory: %@", [fileManager contentsOfDirectoryAtPath:[[self getDocumentsPath] stringByAppendingPathComponent:directoryName] error:&error]);
}

/**
 *  删除document里指定文件夹或文件
 *
 *  @param directoryName 文件夹或文件
 *
 *  @return YES/NO
 */
+ (BOOL)deleteFolderAndSubFile:(NSString *)directoryName {
    NSString *pathString = [self getOtherPath:directoryName];
    return [[NSFileManager defaultManager] removeItemAtPath:pathString error:nil];
}

/**
 *  移动文件夹里面文件到指定文件夹
 *
 *  @param directoryName 目录路径
 *  @param toPath        目标目录路径
 *
 *  @return YES/NO
 */
+ (BOOL)moveFolderSubFile:(NSString *)directoryName toFolderPath:(NSString *)toPath {
    NSString *pathString = [[self getDocumentsPath] stringByAppendingPathComponent:directoryName];
    NSString *toPathString = [[self getDocumentsPath] stringByAppendingPathComponent:toPath];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if ([fileManager fileExistsAtPath:toPathString]){
        [fileManager removeItemAtPath:toPathString error:nil];
    }
    
    NSError *error = nil;
    BOOL flag = [fileManager moveItemAtPath:pathString toPath:toPathString error:&error];
    if(error){
        NSLog(@"%@",error.userInfo);
    }
    return flag;
}

/**
 *  复制文件夹里面文件到指定文件夹
 *
 *  @param directoryName 目录路径
 *  @param toPath        目标目录路径
 *
 *  @return YES/NO
 */
+ (BOOL)copyFolderSubFile:(NSString *)directoryName toFolderPath:(NSString *)toPath {
    NSString *pathString = [self getOtherPath:directoryName];
    NSString *toPathString = [self getOtherPath:toPath];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:toPathString]){
        [fileManager removeItemAtPath:toPathString error:nil];
    }
    NSError *error = nil;
    BOOL flag = [fileManager copyItemAtPath:pathString toPath:toPathString error:nil];
    if(error){
        NSLog(@"%@",error.userInfo);
    }
    return flag;
}

/**
 *  复制文件
 *
 *  @param path   原路径
 *  @param toPath 目标路径
 */
+ (void)copyFileByPath:(NSString *)path toPath:(NSString *)toPath {
    NSError *error = [[NSError alloc] init];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager copyItemAtPath:path toPath:toPath error:&error];
}



@end
