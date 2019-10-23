//
//  TingViewController.m
//  ShiTingYueDu
//
//  Created by 袁玉灵 on 2019/3/9.
//  Copyright © 2019年 袁玉灵. All rights reserved.
//

#import "TingViewController.h"
#import "TingCollectionViewCell.h"
#import "ShuJi.h"
#import <AVOSCloud/AVOSCloud.h>
#import "TingDetailViewController.h"
#import "Reachability.h"
#import "MBProgressHUD+PD.h"
@interface TingViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
/**数据数组 */
@property (nonatomic,strong) NSMutableArray *dataArray;

/**加载时的遮罩图层 */
@property (nonatomic,strong) UIView *shadeView;
@end

@implementation TingViewController
-(NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
-(UIView *)shadeView{
    if (_shadeView == nil) {
        _shadeView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        _shadeView.backgroundColor = [UIColor blackColor];
        _shadeView.userInteractionEnabled = NO;
        _shadeView.alpha = 0.6;
    }
    return _shadeView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    
    if ([[self internetStatus] isEqualToString:@"当前无网路连接"]) {
        UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(self.view.bounds.size.width/2-100, self.view.bounds.size.height/2 - 40, 200, 80)];
        lable.text = @"当前无网络连接,需要打开网络,重新打开此应用";
        lable.numberOfLines = 0;
        lable.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:lable];
    }
    UICollectionViewFlowLayout *laly = [[UICollectionViewFlowLayout alloc]init];
    laly.itemSize = CGSizeMake(100,100);
    laly.sectionInset = UIEdgeInsetsMake(20, 20, 20, 20);
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.collectionViewLayout =laly;
    
    //数据
    AVQuery *query = [AVQuery queryWithClassName:@"ShuJi"];
    [query orderByDescending:@"createdAt"];
    [query includeKey:@"image"];
    [query includeKey:@"content"];
    [MBProgressHUD showMessage:@"正在加载" toView:self.view];
    [[UIApplication sharedApplication].delegate.window addSubview:self.shadeView];
    [[UIApplication sharedApplication]beginIgnoringInteractionEvents];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            
            for (AVObject *object in objects) {
                
                ShuJi *shujiModel = [[ShuJi alloc]init];
                shujiModel.title = object[@"title"];
                shujiModel.author = object[@"author"];
                shujiModel.contentString = object[@"contentString"];
                shujiModel.jianjie = object[@"jianjie"];
                AVFile *file = object[@"image"];
                [file downloadWithCompletionHandler:^(NSURL * _Nullable filePath, NSError * _Nullable error) {
                    NSString *path = [NSString stringWithFormat:@"%@",filePath];
                    NSString *pathString = [path substringFromIndex:7];
                    shujiModel.image = pathString;
                    
                    
                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                    [self.shadeView removeFromSuperview];
                    [[UIApplication sharedApplication]endIgnoringInteractionEvents];
                    [self.dataArray addObject:shujiModel];
                    [self.collectionView reloadData];
                }];
              
            }
        }
    }];

}
- (NSString *)internetStatus {
    
    Reachability *reachability   = [Reachability reachabilityWithHostName:@"www.apple.com"];
    
    NetworkStatus internetStatus = [reachability currentReachabilityStatus];
    
    NSString *net = @"WIFI";
    
    switch (internetStatus) {
            
        case ReachableViaWiFi:
            
            net = @"WIFI";
            
            break;
            
        case ReachableViaWWAN:
            
            net = @"蜂窝数据";
            
            //            net = [self getNetType ];   //判断具体类型
            
            break;
            
        case NotReachable:
            
            net = @"当前无网路连接";
            
        default:
            
            break;
            
    }
    
    return net;
    
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    TingCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"tingCollectionViewCell" forIndexPath:indexPath];
    ShuJi *model = self.dataArray[indexPath.row];
    cell.titleLable.text = model.title;
    
    

    
    
    cell.imageView.image = [UIImage imageWithContentsOfFile:model.image];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //KanDescripeController *kan = [[KanDescripeController alloc]init];
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    TingDetailViewController *ting = [story instantiateViewControllerWithIdentifier:@"TingDetailViewController"];
    ShuJi *model = self.dataArray[indexPath.row];
    ting.content = model.contentString;

    [self.navigationController pushViewController:ting animated:YES];
    
}
-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = NO;
    self.navigationController.navigationBarHidden = YES;

    
}
@end
