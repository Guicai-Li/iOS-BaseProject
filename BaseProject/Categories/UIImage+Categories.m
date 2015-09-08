//
//  UIImage+Categories.m
//  Unit
//
//  Created by LiGuicai on 15/1/9.
//  Copyright (c) 2015年 liguicai. All rights reserved.
//

#import "UIImage+Categories.h"
#import "SystemUnit.h"
#import <QuartzCore/QuartzCore.h>
#import <Accelerate/Accelerate.h>

@implementation UIImage (Categories)

+ (UIImage *)imageWithColor:(UIColor *)color {
    
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

-(UIImage *)boxblurImageWithBlur:(CGFloat)blur {
    
    NSData *imageData = UIImageJPEGRepresentation(self, 1); // convert to jpeg
    UIImage* destImage = [UIImage imageWithData:imageData];
    
    
    if (blur < 0.f || blur > 1.f) {
        blur = 0.5f;
    }
    int boxSize = (int)(blur * 40);
    boxSize = boxSize - (boxSize % 2) + 1;
    
    CGImageRef img = destImage.CGImage;
    
    vImage_Buffer inBuffer, outBuffer;
    
    vImage_Error error;
    
    void *pixelBuffer;
    
    
    //create vImage_Buffer with data from CGImageRef
    
    CGDataProviderRef inProvider = CGImageGetDataProvider(img);
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
    
    
    inBuffer.width = CGImageGetWidth(img);
    inBuffer.height = CGImageGetHeight(img);
    inBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    inBuffer.data = (void*)CFDataGetBytePtr(inBitmapData);
    
    //create vImage_Buffer for output
    
    pixelBuffer = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
    
    if(pixelBuffer == NULL)
        NSLog(@"No pixelbuffer");
    
    outBuffer.data = pixelBuffer;
    outBuffer.width = CGImageGetWidth(img);
    outBuffer.height = CGImageGetHeight(img);
    outBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    // Create a third buffer for intermediate processing
    void *pixelBuffer2 = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
    vImage_Buffer outBuffer2;
    outBuffer2.data = pixelBuffer2;
    outBuffer2.width = CGImageGetWidth(img);
    outBuffer2.height = CGImageGetHeight(img);
    outBuffer2.rowBytes = CGImageGetBytesPerRow(img);
    
    //perform convolution
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer2, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    if (error) {
        NSLog(@"error from convolution %ld", error);
    }
    error = vImageBoxConvolve_ARGB8888(&outBuffer2, &inBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    if (error) {
        NSLog(@"error from convolution %ld", error);
    }
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    if (error) {
        NSLog(@"error from convolution %ld", error);
    }
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef ctx = CGBitmapContextCreate(outBuffer.data,
                                             outBuffer.width,
                                             outBuffer.height,
                                             8,
                                             outBuffer.rowBytes,
                                             colorSpace,
                                             (CGBitmapInfo)kCGImageAlphaNoneSkipLast);
    CGImageRef imageRef = CGBitmapContextCreateImage (ctx);
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
    
    //clean up
    CGContextRelease(ctx);
    CGColorSpaceRelease(colorSpace);
    
    free(pixelBuffer);
    free(pixelBuffer2);
    CFRelease(inBitmapData);
    
    CGImageRelease(imageRef);
    
    return returnImage;
}

CGImageRef CopyImageAndAddAlphaChannel(CGImageRef sourceImage);

+ (UIImage *)maskImage:(UIImage *)image withMask:(UIImage *)maskImage {
    CGImageRef maskRef = maskImage.CGImage;
    
    CGImageRef mask = CGImageMaskCreate(CGImageGetWidth(maskRef),
                                        CGImageGetHeight(maskRef),
                                        CGImageGetBitsPerComponent(maskRef),
                                        CGImageGetBitsPerPixel(maskRef),
                                        CGImageGetBytesPerRow(maskRef),
                                        CGImageGetDataProvider(maskRef), NULL, false);
    
    CGImageRef sourceImage = [image CGImage];
    CGImageRef imageWithAlpha = sourceImage;
    
    //add alpha channel for images that don't have one (ie GIF, JPEG, etc...)
    //this however has a computational cost
    if (CGImageGetAlphaInfo(sourceImage) == kCGImageAlphaNone) {
        imageWithAlpha = CopyImageAndAddAlphaChannel(sourceImage);
    }
    
    CGImageRef masked = CGImageCreateWithMask(imageWithAlpha, mask);
    CGImageRelease(mask);
    
    //release imageWithAlpha if it was created by CopyImageAndAddAlphaChannel
    if (sourceImage != imageWithAlpha) {
        CGImageRelease(imageWithAlpha);
    }
    
    UIImage *retImage = [UIImage imageWithCGImage:masked];
    CGImageRelease(masked);
    
    return retImage;
}

/**
 *  图片等比压缩
 *
 *  @param targetSize 图片目标压缩大小
 *
 *  @return 压缩后的图片
 */
- (UIImage *)imageByScalingProportionallyToSize:(CGSize)targetSize {
    return [self imageCompressForWidth:targetSize.width];
}

//图片旋转
- (UIImage *)imageByRotatingImage:(CGFloat)angle {
    float newSize = MAX([self size].width, [self size].height);
    CGSize size = CGSizeMake(newSize, newSize);
    
    UIGraphicsBeginImageContext(size);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(ctx, newSize / 2, newSize / 2);
    CGContextRotateCTM(ctx, -angle);
    
    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(-[self size].width / 2, -[self size].height / 2, size.width, size.height), self.CGImage);
    
    CGContextTranslateCTM(ctx, -[self size].width / 2, [self size].height / 2);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImage *retImage = [[UIImage alloc] initWithCGImage:image.CGImage
                                                   scale:1.0
                                             orientation:UIImageOrientationDownMirrored];
    
    return retImage;
}

//图片存储
- (NSString *)writeToFilePath:(NSString *)filePath {
    NSString *documentsDirectory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString *temImage = [documentsDirectory stringByAppendingPathComponent:filePath];
    [UIImageJPEGRepresentation(self, 1) writeToFile:temImage atomically:YES];
    return temImage;
}

- (UIImage *)imageCompressForWidth:(CGFloat)defineWidth {
    //OPTIMIZE:【answer】
    UIImage *newImage = nil;
    CGSize imageSize = self.size;
    CGFloat width = imageSize.width * 1.0;
    CGFloat height = imageSize.height * 1.0;
    CGFloat targetWidth = defineWidth * 1.0;
    CGFloat targetHeight = height * targetWidth / width;
    CGSize size = CGSizeMake(targetWidth, targetHeight);
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);
    
    if (!CGSizeEqualToSize(imageSize, size)) {
        
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        scaleFactor = MAX(widthFactor, heightFactor);
        
        scaledWidth = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        if (widthFactor > heightFactor) {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        } else if (widthFactor < heightFactor) {
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
        
    }
    
    UIGraphicsBeginImageContext(size);
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [self drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if (newImage == nil) {
        NSLog(@"scale image fail");
    }
    
    UIGraphicsEndImageContext();
    
    return newImage;
}

- (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size {
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    // 绘制改变大小的图片
    [img drawInRect:CGRectMake(0, 0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return scaledImage;
}

+ (UIImage *)captureImageFromView: (UIView *)view {
    CGRect screenRect = [view bounds];
    UIGraphicsBeginImageContext(screenRect.size);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [view.layer renderInContext:ctx];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end

CGImageRef CopyImageAndAddAlphaChannel(CGImageRef sourceImage) {
    CGImageRef retVal = NULL;
    
    size_t width = CGImageGetWidth(sourceImage);
    size_t height = CGImageGetHeight(sourceImage);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    int bitmapInfo;
    
    if (SYSTEM_VERSION >= 7) {
        bitmapInfo = (CGBitmapInfo) kCGImageAlphaPremultipliedFirst;
    } else {
        bitmapInfo = kCGImageAlphaPremultipliedFirst;
    }
    
    CGContextRef offscreenContext = CGBitmapContextCreate(NULL, width, height,
                                                          8, 0, colorSpace, bitmapInfo);
    
    if (offscreenContext != NULL) {
        CGContextDrawImage(offscreenContext, CGRectMake(0, 0, width, height), sourceImage);
        
        retVal = CGBitmapContextCreateImage(offscreenContext);
        CGContextRelease(offscreenContext);
    }
    
    CGColorSpaceRelease(colorSpace);
    
    return retVal;
}
