//
//  BaseViewController.m
//  BaseProject
//
//  Created by Guicai_Li on 15/8/10.
//  Copyright (c) 2015年 Guicai_Li. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()<UIGestureRecognizerDelegate>

@property (weak, nonatomic) UIView *scrollView;
@property (strong, nonatomic)UIPanGestureRecognizer *panGesture;
@property (strong, nonatomic)UIView *overLay;
@property (assign, nonatomic)BOOL isHiddenNavbar;

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)modifyNavbar {
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(NSIntegerMin, NSIntegerMin) forBarMetrics:UIBarMetricsDefault];
    self.navigationItem.backBarButtonItem.imageInsets = UIEdgeInsetsMake(0, -25, 0,25);
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor],NSFontAttributeName:[UIFont fontWithName:@"Hiragino Kaku Gothic ProN W3" size:20]}];
    self.navigationController.navigationBar.translucent = NO;
}

- (void)modifyBackButton {
    if (self.navigationController.viewControllers.count>1) {
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        backButton.frame = CGRectMake(0.0, 0.0, 40, 40);
        [backButton setImage:[UIImage imageNamed:@"btn_topbar_back_normal"] forState:UIControlStateNormal];
        [backButton setImage:[UIImage imageNamed:@"btn_topbar_back_press"] forState:UIControlStateSelected];
        backButton.imageEdgeInsets = UIEdgeInsetsMake(0, -15, 0, 0);
        [backButton handleControlEvent:UIControlEventTouchUpInside withBlock:^(){
            [self.navigationController popViewControllerAnimated:YES];
        }];
        UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
        temporaryBarButtonItem.style = UIBarButtonItemStylePlain;
        self.navigationItem.leftBarButtonItem=temporaryBarButtonItem;
    }
}

#pragma mark - Storyboard

- (void)pushViewControllerFromStoryboard:(NSString *)storyboardName {
    [self pushViewControllerFromStoryboard:storyboardName title:nil];
}

- (void)pushViewControllerFromStoryboard:(NSString *)storyboardName title:(NSString*)title {
    UIViewController *vc = [self vcFormStoryboard:storyboardName];
    vc.title = title;
    [self.navigationController pushViewController:vc animated:YES];
}

- (UIViewController*)vcFormStoryboard:(NSString *)storyboardName {
    UIStoryboard *storyborad = [UIStoryboard storyboardWithName:storyboardName bundle:nil];
    UIViewController *vc = [storyborad instantiateViewControllerWithIdentifier:storyboardName];
    return vc;
}

#pragma mark - Loading

- (void)showLoadingStatus:(NSString *)status andUserInterface:(BOOL)userInterface {
    [SVProgressHUD setBackgroundColor:[UIColor lightGrayColor]];
    [SVProgressHUD showWithStatus:status maskType:userInterface? SVProgressHUDMaskTypeNone:SVProgressHUDMaskTypeBlack];
}

- (void)hideLoading {
    [SVProgressHUD dismiss];
}

#pragma mark - alterView

- (void)showAlertWithTitle:(NSString  *)titleStr contentStr:(NSString *)contentStr cancelButtonStr:(NSString *)cancelStr confirmButtonStr:(NSString *)confirmStr isAutomHidden:(BOOL)isAutohidden {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:titleStr message:contentStr delegate:self cancelButtonTitle:cancelStr otherButtonTitles:confirmStr, nil];
    [alert show];
    
    if (isAutohidden) {
        __block UIAlertView *blockAlert = alert;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW,(int64_t) 2 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            [blockAlert dismissWithClickedButtonIndex:0 animated:YES];
        });
    }
}

#pragma mark - 屏幕旋转

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return (toInterfaceOrientation == UIInterfaceOrientationPortrait);
}

- (BOOL)shouldAutorotate {
    return NO;
}

- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

#pragma mark - 手势

//设置跟随滚动的滑动试图
-(void)followRollingScrollView:(UIView *)scrollView {
    self.scrollView = scrollView;
    
    self.panGesture = [[UIPanGestureRecognizer alloc] init];
    self.panGesture.delegate = self;
    self.panGesture.minimumNumberOfTouches = 1;
    [self.panGesture addTarget:self action:@selector(handlePanGesture:)];
    [self.scrollView addGestureRecognizer:self.panGesture];
    
    self.overLay = [[UIView alloc] initWithFrame:self.navigationController.navigationBar.bounds];
    self.overLay.alpha=0;
    self.overLay.backgroundColor=self.navigationController.navigationBar.barTintColor;
    [self.navigationController.navigationBar addSubview:self.overLay];
    [self.navigationController.navigationBar bringSubviewToFront:self.overLay];
}

//兼容其他手势
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

//手势调用函数
-(void)handlePanGesture:(UIPanGestureRecognizer *)panGesture {
    CGPoint translation = [panGesture translationInView:[self.scrollView superview]];
    
    //    CGFloat detai = self.lastContentset - translation.y;
    //显示
    if (self.isHiddenNavbar) {
        
        self.overLay.alpha = 0;
        CGRect navBarFrame = self.navigationController.navigationBar.frame;
        CGRect scrollViewFrame = self.scrollView.frame;
        
        navBarFrame.origin.y = 20;
        scrollViewFrame.origin.y += 44;
        scrollViewFrame.size.height -= 44;
        
        [UIView animateWithDuration:0.2 animations:^{
            self.navigationController.navigationBar.frame = navBarFrame;
            self.scrollView.frame=scrollViewFrame;
        }];
        self.isHiddenNavbar= NO;
    }
    
    //隐藏
    if (translation.y <= -20) {
        if (!self.isHiddenNavbar) {
            CGRect frame = self.navigationController.navigationBar.frame;
            CGRect scrollViewFrame=self.scrollView.frame;
            frame.origin.y = -24;
            scrollViewFrame.origin.y -= 44;
            scrollViewFrame.size.height += 44;
            [UIView animateWithDuration:0.2 animations:^{
                self.navigationController.navigationBar.frame = frame;
                self.scrollView.frame=scrollViewFrame;
            } completion:^(BOOL finished) {
                self.overLay.alpha=1;
            }];
            self.isHiddenNavbar=YES;
        }
    }
    [self.view bringSubviewToFront:self.scrollView];
    
}

//showNavbar
- (void)showNavbar {
    if (self.isHiddenNavbar) {
        
        self.overLay.alpha = 0;
        CGRect navBarFrame = self.navigationController.navigationBar.frame;
        CGRect scrollViewFrame = self.scrollView.frame;
        
        navBarFrame.origin.y = 20;
        scrollViewFrame.origin.y += 44;
        scrollViewFrame.size.height -= 44;
        
        [UIView animateWithDuration:0.2 animations:^{
            self.navigationController.navigationBar.frame = navBarFrame;
            self.scrollView.frame = scrollViewFrame;
        }];
        self.isHiddenNavbar= NO;
    }
}

@end
