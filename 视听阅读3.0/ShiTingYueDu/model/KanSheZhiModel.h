//
//  KanSheZhiModel.h
//  ShiTingYueDu
//
//  Created by 袁玉灵 on 2019/3/10.
//  Copyright © 2019年 袁玉灵. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KanSheZhiModel : NSObject
/**字号**/
@property (nonatomic , assign) NSInteger fontSize;
/**行距**/
@property (nonatomic , assign) float lineSpace;
/**字体颜色,存储第几个Button**/
@property (nonatomic , assign) NSInteger textColor;
/**背景颜色,textView的颜色,存储第几个Button**/
@property (nonatomic , assign) NSInteger backgroundColor;
@end
