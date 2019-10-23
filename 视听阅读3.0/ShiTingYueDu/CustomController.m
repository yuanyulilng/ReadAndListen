//
//  CustomController.m
//  ShiTingYueDu
//
//  Created by 袁玉灵 on 2019/3/9.
//  Copyright © 2019年 袁玉灵. All rights reserved.
//

#import "CustomController.h"

@interface CustomController ()

@end

@implementation CustomController

- (void)viewDidLoad {
    [super viewDidLoad];
    for (UITabBarItem *item in self.tabBar.items) {
        item.selectedImage = [item.selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        item.image = [item.image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
        attrs[NSFontAttributeName] = [UIFont systemFontOfSize:14];
        attrs[NSForegroundColorAttributeName] = [UIColor blackColor];
        
        // 选中
        NSMutableDictionary *attrSelected = [NSMutableDictionary dictionary];
        attrSelected[NSFontAttributeName] = [UIFont systemFontOfSize:14];
        attrSelected[NSForegroundColorAttributeName] = [UIColor blackColor];
        
        
        UITabBarItem *item = [UITabBarItem appearance];
        [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
        [item setTitleTextAttributes:attrSelected forState:UIControlStateSelected];
       
    }
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
