//
//  AppDelegate.m
//  歪车
//


#import "AppDelegate.h"
#import "ZCMainController.h"
#import "ZCNewfeatureController.h"
@interface AppDelegate ()

@end
@implementation AppDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    application.statusBarHidden = NO;
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    // 2.设置窗口的根控制器
    // 如何知道第一次使用这个版本？比较上次的使用情况
    //   NSString *versionKey = @"CFBundleVersion";
        NSString *versionKey = (__bridge NSString *)kCFBundleVersionKey;
    
        // 从沙盒中取出上次存储的软件版本号(取出用户上次的使用记录)
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *lastVersion = [defaults objectForKey:versionKey];
    
        // 获得当前打开软件的版本号
        NSString *currentVersion = [NSBundle mainBundle].infoDictionary[versionKey];
    
        if ([currentVersion isEqualToString:lastVersion]) { // 当前版本号 == 上次使用的版本
            
            self.window.rootViewController = [[ZCMainController alloc]init];
        } else { // 当前版本号 != 上次使用的版本：显示版本新特性
    
            self.window.rootViewController = [[ZCNewfeatureController alloc] init];
    
            // 存储这次使用的软件版本
            [defaults setObject:currentVersion forKey:versionKey];
            [defaults synchronize];
        }

    return YES;
}
- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    [[SDImageCache sharedImageCache] clearMemory];
    [[SDWebImageManager sharedManager] cancelAll];
}
@end