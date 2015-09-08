//
//  UIView+SetFrame.h
//  LazyLoadingTest1
//
//  Created by LiGuicai on 15/1/15.
//  Copyright (c) 2015年 liguicai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Frame)

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGPoint origin;

- (void)setContraint:(NSLayoutAttribute)attribute value:(CGFloat)value;

@end
