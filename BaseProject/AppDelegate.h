//
//  AppDelegate.h
//  BaseProject
//
//  Created by Guicai_Li on 15/8/5.
//  Copyright (c) 2015年 Guicai_Li. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Reachability.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate> {
    Reachability* internetReach;
}

@property (strong, nonatomic) UIWindow *window;


@end

