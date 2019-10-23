//
//  UIView+Shade.h
//  fanyin
//
//  Created by 袁玉灵 on 2018/8/22.
//  Copyright © 2018年 袁玉灵. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Shade)
//添加shadeview后,覆盖整个屏幕呈现灰黑色,所有按钮不能点击
+(void)addShadeViewTo:(UIView *)view;
+(void)removeShadeViewFrom:(UIView *)view;
@end
