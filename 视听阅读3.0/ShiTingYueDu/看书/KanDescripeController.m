//
//  KanDescripeController.m
//  ShiTingYueDu
//
//  Created by 袁玉灵 on 2019/3/8.
//  Copyright © 2019年 袁玉灵. All rights reserved.
//

#import "KanDescripeController.h"
#import "ShuJi.h"
#import "KanDetailViewController.h"
#import "DataBaseHelper.h"
@interface KanDescripeController ()

@property (weak, nonatomic) IBOutlet UIImageView *picture;

@property (weak, nonatomic) IBOutlet UILabel *tiLab;

@property (weak, nonatomic) IBOutlet UILabel *author;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@end

@implementation KanDescripeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tiLab.text = self.dataModel.title;
    self.author.text = [NSString stringWithFormat:@"作者:%@", self.dataModel.author];
    self.picture.image = [UIImage imageWithContentsOfFile:self.dataModel.image];
    self.textView.text = self.dataModel.jianjie;
    self.textView.editable = NO;
    // Do any additional setup after loading the view.
}
- (IBAction)backButton:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)down:(UIButton *)sender {
    DataBaseHelper *dataBase = [DataBaseHelper shareDataBaseHelper];
    [dataBase creatDataBase];
    [dataBase buildSqliteWithTableName:@"ShuJi"];
    [dataBase insertIntoTable:@"ShuJi" WithDownload:self.dataModel];
    
}
- (IBAction)kanButton:(UIButton *)sender {
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    KanDetailViewController *kan = [story instantiateViewControllerWithIdentifier:@"KanDetailViewController"];
    kan.content = self.dataModel.contentString;
    [self.navigationController pushViewController:kan animated:YES];
    
}
-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = YES;
    self.navigationController.navigationBarHidden = YES;

    
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
