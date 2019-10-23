//
//  MBProgressHUD+PD.h
//  fanyin
//
//  Created by 袁玉灵 on 2018/8/19.
//  Copyright © 2018年 袁玉灵. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (PD)
+ (void)showSuccess:(NSString *)success;
+ (void)showSuccess:(NSString *)success toView:(UIView *)view;

+ (void)showError:(NSString *)error;
+ (void)showError:(NSString *)error toView:(UIView *)view;

+ (MBProgressHUD *)showMessage:(NSString *)message;
+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view;

+ (void)hideHUD;
+ (void)hideHUDForView:(UIView *)view;
@end
