//
//  MeDownViewController.m
//  ShiTingYueDu
//
//  Created by 袁玉灵 on 2019/3/9.
//  Copyright © 2019年 袁玉灵. All rights reserved.
//

#import "MeDownViewController.h"
#import "MeDownCell.h"
#import "DataBaseHelper.h"
#import "ShuJi.h"
#import "TingDetailViewController.h"
#import "KanDetailViewController.h"
@interface MeDownViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
/**<#注释#> */
@property (nonatomic,strong) NSArray *dataArray;

@end

@implementation MeDownViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MeDownCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MeDownCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    ShuJi *model = self.dataArray[indexPath.row];
    
    
    NSArray *filePaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cache = [filePaths objectAtIndex:0];
   NSArray *arr =  [model.image componentsSeparatedByString:@"/Files"];
   NSString *path = [NSString stringWithFormat:@"%@/com.leancloud.caches/Files%@",cache, arr.lastObject];
    
    
    
    cell.picture.image = [UIImage imageWithContentsOfFile:path];
    cell.nameLable.text = model.title;
    cell.authorLable.text = [NSString stringWithFormat:@"作者:%@", model.author];
    
   
    cell.delateButton.tag = 100+indexPath.row;
    [cell.delateButton addTarget:self action:@selector(delateButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    cell.tingButton.tag = 200 +indexPath.row;
    [cell.tingButton  addTarget:self action:@selector(tingButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    cell.kanButton.tag = 300 + indexPath.row;
    [cell.kanButton addTarget:self action:@selector(kanButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
-(void)delateButtonAction:(UIButton *)sender{
   NSInteger index =  sender.tag - 100;
    
    DataBaseHelper *dataBase = [DataBaseHelper shareDataBaseHelper];
    ShuJi *model = self.dataArray[index];
    [dataBase deletaFromTable:@"ShuJi" withPath:model.image];
    self.dataArray =   [dataBase selectAllFromTable:@"ShuJi"];
    [self.tableView reloadData];
    
}
-(void)tingButtonAction:(UIButton *)sender{
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    TingDetailViewController *ting = [story instantiateViewControllerWithIdentifier:@"TingDetailViewController"];
    NSInteger index =  sender.tag - 200;
    ShuJi *model = self.dataArray[index];
    ting.content = model.contentString;
    
    [self.navigationController pushViewController:ting animated:YES];
    
}
-(void)kanButtonAction:(UIButton *)sender{
    
    
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    KanDetailViewController *kan = [story instantiateViewControllerWithIdentifier:@"KanDetailViewController"];
    NSInteger index =  sender.tag - 300;
    ShuJi *model = self.dataArray[index];
    kan.content = model.contentString;
    [self.navigationController pushViewController:kan animated:YES];
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden = NO;
    
    
    DataBaseHelper *dataBase = [DataBaseHelper shareDataBaseHelper];
    [dataBase buildSqliteWithTableName:@"ShuJi"];
    self.dataArray =   [dataBase selectAllFromTable:@"ShuJi"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView reloadData];
    
    
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    
}

@end
