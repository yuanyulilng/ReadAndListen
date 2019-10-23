//
//  ShuJi.h
//  ShiTingYueDu
//
//  Created by 袁玉灵 on 2019/3/8.
//  Copyright © 2019年 袁玉灵. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface ShuJi : NSObject
/**书名 */
@property (nonatomic,strong) NSString *title;
/**简介 */
@property (nonatomic,strong) NSString *jianjie;
/**封面 */
@property (nonatomic,strong) NSString * image;
/**作者 */
@property (nonatomic,strong) NSString *author;
/**内容字符串 */
@property (nonatomic,strong) NSString *contentString;
@end
