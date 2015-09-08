//
//  AppDelegate.m
//  BaseProject
//
//  Created by Guicai_Li on 15/8/5.
//  Copyright (c) 2015年 Guicai_Li. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

void uncaughtExceptionHandler(NSException *exception) {
    
    // 异常的堆栈信息
    NSArray *stackArray = [exception callStackSymbols];
    // 出现异常的原因
    NSString *reason = [exception reason];
    // 异常名称
    NSString *name = [exception name];
    
    NSString *syserror = [NSString stringWithFormat:@"异常名称：%@\n异常原因：%@\n异常堆栈信息：%@", name, reason, stackArray];
    DDLogInfo(@"CRASH: %@", syserror);
    
    NSString *dirName = @"exception";
    NSString *fileDir = [NSString stringWithFormat:@"%@/%@/", [FileManagerUtils getDocumentsPath], dirName];
    BOOL isDir = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL existed = [fileManager fileExistsAtPath:fileDir isDirectory:&isDir];
    if (!(isDir && existed)) {
        [fileManager createDirectoryAtPath:fileDir withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    //更改到待操作的目录下
    [fileManager changeCurrentDirectoryPath:[fileDir stringByExpandingTildeInPath]];
    [fileManager createFileAtPath:[fileDir stringByAppendingString:[TimeUtils getSystemTimeString]] contents:[syserror dataUsingEncoding:NSUTF8StringEncoding] attributes:nil];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self initMobClick];
    [self DDLogsetup];
    [self networkReachability];
    [self registerRemoteNotifications];
    
    [TMCache sharedCache].memoryCache.costLimit = 20 * 1024 * 1024;
    
    return YES;
}

#pragma mark - 推送

- (void)registerRemoteNotifications {
    UIApplication *application = [UIApplication sharedApplication];
    // iOS8 及以上注册通知
    if ([application respondsToSelector:@selector(isRegisteredForRemoteNotifications)]) {
        UIUserNotificationCategory *category1 = [self registerActions1];
        UIUserNotificationCategory *category2 = [self registerActions2];
        NSMutableSet *categories = [NSMutableSet set];
        [categories addObject:category1];
        [categories addObject:category2];
        
        UIUserNotificationSettings* notificationSettings = [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound) categories:categories];
        [application registerUserNotificationSettings:notificationSettings];
        [application registerForRemoteNotifications];
    }else {
        [application registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
    }
}

- (UIMutableUserNotificationCategory*)registerActions1 {
    UIMutableUserNotificationAction *acceptLeadAction = [[UIMutableUserNotificationAction alloc] init];
    acceptLeadAction.identifier = @"Accept1";
    acceptLeadAction.title = @"Accept1";
    acceptLeadAction.activationMode = UIUserNotificationActivationModeBackground;
    acceptLeadAction.authenticationRequired = YES;
    acceptLeadAction.destructive = false;
    
    
    UIMutableUserNotificationAction *rejectLeadAction = [[UIMutableUserNotificationAction alloc] init];
    rejectLeadAction.identifier = @"Reject1";
    rejectLeadAction.title = @"Reject1";
    rejectLeadAction.activationMode = UIUserNotificationActivationModeBackground;
    rejectLeadAction.authenticationRequired = YES;
    rejectLeadAction.destructive = YES;
    
    
    UIMutableUserNotificationCategory* category = [[UIMutableUserNotificationCategory alloc] init];
    category.identifier = @"identifier1";
    [category setActions:@[acceptLeadAction, rejectLeadAction] forContext: UIUserNotificationActionContextMinimal];
    return category;
}

- (UIMutableUserNotificationCategory*)registerActions2 {
    UIMutableUserNotificationAction *acceptLeadAction = [[UIMutableUserNotificationAction alloc] init];
    acceptLeadAction.identifier = @"Accept2";
    acceptLeadAction.title = @"Accept2";
    acceptLeadAction.activationMode = UIUserNotificationActivationModeBackground;
    acceptLeadAction.authenticationRequired = YES;
    acceptLeadAction.destructive = false;
    
    
    UIMutableUserNotificationAction *rejectLeadAction = [[UIMutableUserNotificationAction alloc] init];
    rejectLeadAction.identifier = @"Reject2";
    rejectLeadAction.title = @"Reject2";
    rejectLeadAction.activationMode = UIUserNotificationActivationModeBackground;
    rejectLeadAction.authenticationRequired = YES;
    rejectLeadAction.destructive = YES;
    
    
    UIMutableUserNotificationCategory* category = [[UIMutableUserNotificationCategory alloc] init];
    category.identifier = @"identifier2";
    [category setActions:@[acceptLeadAction, rejectLeadAction] forContext: UIUserNotificationActionContextMinimal];
    return category;
}

#pragma makr UMeng

- (void)initMobClick {
    [MobClick startWithAppkey:kUMengAppKey reportPolicy:REALTIME channelId:kUMengChannelId];
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [MobClick setAppVersion:version];
    [MobClick setLogEnabled:YES];
}

#pragma mark setup

- (void)DDLogsetup {
    NSSetUncaughtExceptionHandler(&uncaughtExceptionHandler);
    [DDLog addLogger:[DDTTYLogger sharedInstance] withLevel:ddLogLevel];
    [[DDTTYLogger sharedInstance] setColorsEnabled:YES];
}

#pragma mark - NetworkReachability

- (void)networkReachability {
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(reachabilityChanged:)
                                                 name: kReachabilityChangedNotification
                                               object: nil];
    
    internetReach = [Reachability reachabilityForInternetConnection];
    [internetReach startNotifier];
}

- (void)reachabilityChanged: (NSNotification* )note
{
    Reachability* curReach = [note object];
    NSParameterAssert([curReach isKindOfClass: [Reachability class]]);
    
    if (curReach == internetReach) {
        NetworkStatus netStatus = [curReach currentReachabilityStatus];
        
        switch (netStatus) {
            case NotReachable: {
                DDLogInfo(@"[Reachability]:no internet");
            }
                break;
            default:{
                DDLogInfo(@"[Reachability]:internet on working");
            }
                break;
        }
    }
}

#pragma mark - NavigationBar

- (void)customizeInterface {
    UINavigationBar *navigationBarAppearance = [UINavigationBar appearance];
    
    UIImage *backgroundImage = nil;
    NSDictionary *textAttributes = nil;
    
    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1) {
        backgroundImage = [UIImage imageNamed:@"nav_bar_big_red"];
        
        textAttributes = @{
                           NSFontAttributeName : [UIFont boldSystemFontOfSize:18],
                           NSForegroundColorAttributeName : [UIColor blackColor],
                           };
    } else {
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
        backgroundImage = [UIImage imageNamed:@"nav_bar_red"];
        
        textAttributes = @{
                           UITextAttributeFont: [UIFont boldSystemFontOfSize:18],
                           UITextAttributeTextColor: [UIColor blackColor],
                           UITextAttributeTextShadowColor: [UIColor clearColor],
                           UITextAttributeTextShadowOffset: [NSValue valueWithUIOffset:UIOffsetZero],
                           };
#endif
    }
    
    [navigationBarAppearance setBackgroundImage:backgroundImage forBarMetrics:UIBarMetricsDefault];
    [navigationBarAppearance setTitleTextAttributes:textAttributes];
}

@end
