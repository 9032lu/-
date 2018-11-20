//
//  AppDelegate.m
//  xkjvxjclkxlkv
//
//  Created by ZhangTu on 2018/7/11.
//  Copyright © 2018年 Test. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
@interface AppDelegate ()
{
    BOOL isUseScreenShots;
}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {


    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(didUseScreenShot) name:UIApplicationUserDidTakeScreenshotNotification object:nil];
    
    return YES;
}

-(void)didUseScreenShot{
    
    NSLog(@"用户使用了截屏操作");
    if (isUseScreenShots==NO) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
         __block  isUseScreenShots = YES;

            UIView *view = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
            
            view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.7];
            [[UIApplication sharedApplication].keyWindow addSubview:view];
            
            
            UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 320-20, 300)];
            
            imgView.image = [self getImgage];
            [view addSubview:imgView];
            
            UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(20,[UIScreen mainScreen].bounds.size.height-50 , 100, 30)];
            btn.backgroundColor = [UIColor redColor];
            [view addSubview:btn];
            
            [btn addTarget:self action:@selector(reoveiView:) forControlEvents:UIControlEventTouchUpInside];
            
            
        });
    }
}

-(void)reoveiView:(UIButton*)sender{
    isUseScreenShots = YES;

    [sender.superview removeFromSuperview];
    
}

-(UIImage *)getImgage{
    
    UIGraphicsBeginImageContext([UIScreen mainScreen].bounds.size);
    
    [[UIApplication sharedApplication].windows[0].layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
