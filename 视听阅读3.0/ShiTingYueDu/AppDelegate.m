//
//  AppDelegate.m
//  ShiTingYueDu
//
//  Created by 袁玉灵 on 2019/3/8.
//  Copyright © 2019年 袁玉灵. All rights reserved.
//

#import "AppDelegate.h"
#import <AVOSCloud/AVOSCloud.h>
#import <AVFoundation/AVFoundation.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
 

  
    //允许手机外放
    
    AVAudioSession * session = [AVAudioSession sharedInstance];
    [session setActive:YES error:nil];
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    
   
    
   // KNe9DB9yDwglzdeWgY243Wna
    [AVOSCloud setApplicationId:@"PkE0FTSkShfXK61sYHA3gtO6-gzGzoHsz" clientKey:@"KNe9DB9yDwglzdeWgY243Wna"];
                
                NSString *username = @"ShiTingYueDu";
                NSString *password = @"ShiTingYueDu";
                if (username && password) {
                    // LeanCloud - 登录
                    // https://leancloud.cn/docs/leanstorage_guide-objc.html#登录
                    [AVUser logInWithUsernameInBackground:username password:password block:^(AVUser *user, NSError *error) {
                        if (error) {
                         //   NSLog(@"登录失败 %@", error);
                        } else {
                         //   NSLog(@"登录成功");
                        }
                    }];
     
    }
    // Override point for customization after application launch.
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    /*
     AVQuery *query = [AVQuery queryWithClassName:@"ShuJi"];
     [query orderByDescending:@"createdAt"];
     // image 为 File
     [query includeKey:@"image"];
     [query includeKey:@"content"];
     [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
     if (!error) {
     NSString *title = objects.firstObject[@"title"];// 读取 title
     NSLog(@"%@",title);
     for (AVObject *obj in objects) {
     //  NSString *title = obj[@"title"];
     //  NSLog(@"%@",title);
     // AVFile *file = obj[@"content"];
     //   NSLog(@"%@",file);
     AVFile *file = obj[@"image"];
     //  NSLog(@"%@",file);
     //http://lc-PkE0FTSk.cn-n1.lcfile.com/cba9fed7c3b5a638b501.jpg
     // AVFile *file = [AVFile fileWithRemoteURL:[NSURL URLWithString:@"http://lc-PkE0FTSk.cn-n1.lcfile.com/cba9fed7c3b5a638b501.jpg"]];
     // [file getThumbnail:YES width:100 height:100 withBlock:^(UIImage *image, NSError *error) {
     // code
     //  self.imageView.image = image;
     // }];
     [file downloadWithProgress:^(NSInteger number) {
     //下载的进度数据，number 介于 0 和 100。
     } completionHandler:^(NSURL * _Nullable filePath, NSError * _Nullable error) {
     // filePath 是文件下载到本地的地址
     NSLog(@"%@",filePath);
     }];
     }
     
     
     }
     }];
     
     */
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
