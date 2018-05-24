//
//  AppDelegate.m
//  后台线程
//
//  Created by zhph on 2018/5/24.
//  Copyright © 2018年 正和普惠. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@property(nonatomic,strong)NSTimer * timer;

@end

NSInteger i =0;

@implementation AppDelegate{
    
    
    __block UIBackgroundTaskIdentifier taskIdentifier;
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {

    NSLog(@"辞去活跃");
}


-(void)applicationDidBecomeActive:(UIApplication *)application{
    NSLog(@"运行后台 是否保存了%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"isSame2"]);
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
    NSLog(@"后台运行");
    


    taskIdentifier=  [application beginBackgroundTaskWithExpirationHandler:^{
        //保存一条数据
        //暂停后台任务
        [application endBackgroundTask:taskIdentifier];
        taskIdentifier = UIBackgroundTaskInvalid;
        NSLog(@"暂停后台任务");
    }];
//
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeStart) userInfo:nil repeats:(YES)];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3* NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            //保存一条数据
            [[NSUserDefaults standardUserDefaults]setObject:@"1" forKey:@"isSame2"];
            [[NSUserDefaults standardUserDefaults]synchronize];
        });

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //暂停后台任务
        [application endBackgroundTask:taskIdentifier];
        taskIdentifier = UIBackgroundTaskInvalid;
    });

}

-(void)timeStart{
    
    NSLog(@"后台打印值***%ld",i++);
    
}

@end
