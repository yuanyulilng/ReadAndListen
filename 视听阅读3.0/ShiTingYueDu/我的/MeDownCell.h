//
//  MeDownCell.h
//  ShiTingYueDu
//
//  Created by 袁玉灵 on 2019/3/9.
//  Copyright © 2019年 袁玉灵. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MeDownCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *picture;
@property (weak, nonatomic) IBOutlet UIButton *kanButton;
@property (weak, nonatomic) IBOutlet UIButton *tingButton;
@property (weak, nonatomic) IBOutlet UILabel *nameLable;
@property (weak, nonatomic) IBOutlet UILabel *authorLable;
@property (weak, nonatomic) IBOutlet UIButton *delateButton;

@end
