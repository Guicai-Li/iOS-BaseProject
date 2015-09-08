//
//  BaseViewController.h
//  BaseProject
//
//  Created by Guicai_Li on 15/8/10.
//  Copyright (c) 2015年 Guicai_Li. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

/**
 *  push到storyboard
 *
 *  @param storyboardName
 */
- (void)pushViewControllerFromStoryboard:(NSString *)storyboardName;
- (void)pushViewControllerFromStoryboard:(NSString *)storyboardName title:(NSString*)title;
- (UIViewController*)vcFormStoryboard:(NSString *)storyboardName;

/**
 *  显示正在加载 loading
 *
 *  @param status        加载提示信息
 *  @param userInterface 加载过程中 vc的交互性
 */
- (void)showLoadingStatus:(NSString *)status andUserInterface:(BOOL)userInterface;
- (void)hideLoading;

/**
 *  显示alert
 *
 *  @param titleStr     提示信息title
 *  @param contentStr   提示信息content
 *  @param cancelStr    取消按钮title
 *  @param confirmStr   确定按钮title
 *  @param isAutohidden 是否自动隐藏 3秒后自动隐藏
 */
- (void)showAlertWithTitle:(NSString *)titleStr contentStr:(NSString *)contentStr cancelButtonStr:(NSString *)cancelStr confirmButtonStr:(NSString *)confirmStr isAutomHidden:(BOOL)isAutohidden;



@end
