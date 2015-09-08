//
//  UIImage+Categories.h
//  Unit
//
//  Created by LiGuicai on 15/1/9.
//  Copyright (c) 2015年 liguicai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Categories)

/**
 *  根据颜色生成图片
 *
 *  @param color 指定颜色
 *
 *  @return 根据颜色生成的图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color;

/**
 *  根据blur生成毛玻璃图
 *
 *  @param blur 0~1   1最模糊
 *
 *  @return 根据blur生成毛玻璃图
 */
- (UIImage *)boxblurImageWithBlur:(CGFloat)blur;

+ (UIImage *)maskImage:(UIImage *)image withMask:(UIImage *)maskImage;

/**
 *  图片等比压缩
 *
 *  @param targetSize 压缩尺寸
 *
 *  @return UIImage
 */
- (UIImage *)imageByScalingProportionallyToSize:(CGSize)targetSize;

/**
 *  图片旋转
 *
 *  @param angle 旋转角度
 *
 *  @return UIImage
 */
- (UIImage *)imageByRotatingImage:(CGFloat)angle;

/**
 *  图片存储
 *
 *  @param filePath 存储路径
 *
 *  @return 路径
 */
- (NSString *)writeToFilePath:(NSString *)filePath;

/**
 *  图片缩放到某一尺寸
 *
 *  @param img  图片
 *  @param size 目标尺寸
 *
 *  @return UIImage
 */
- (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size;

- (UIImage *)imageCompressForWidth:(CGFloat)defineWidth;

/**
 *  屏幕截屏
 *
 *  @param view 当前界面
 *
 *  @return 图片
 */
+ (UIImage *)captureImageFromView: (UIView *)view;

@end
