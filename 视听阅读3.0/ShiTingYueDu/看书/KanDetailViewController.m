//
//  KanDetailViewController.m
//  ShiTingYueDu
//
//  Created by 袁玉灵 on 2019/3/8.
//  Copyright © 2019年 袁玉灵. All rights reserved.
//

#import "KanDetailViewController.h"
#import "ControlView.h"
#import "UIView+Category.h"
@interface KanDetailViewController ()
@property (weak, nonatomic) IBOutlet UIButton *shezhiButton;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) IBOutlet ControlView *controlView;
/**<#注释#> */
@property (nonatomic,strong) NSMutableAttributedString *attri;
/**<#注释#> */
@property (nonatomic,strong) NSMutableParagraphStyle *para;
@property (weak, nonatomic) IBOutlet UIStepper *stepper;
@property (weak, nonatomic) IBOutlet UISlider *slider;
/**<#注释#>**/
@property (nonatomic , assign) NSInteger butflag;
/**textView背景色标记**/
@property (nonatomic , assign) NSInteger backgroundFlag;

@end

@implementation KanDetailViewController
- (IBAction)backC1:(id)sender {
    self.textView.backgroundColor = [UIColor blackColor];
    _backgroundFlag = 0;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;

   
    _butflag = 4;
    _backgroundFlag = 5;
    self.stepper.minimumValue = 5;
    self.stepper.maximumValue = 20;
    self.stepper.stepValue = 1;
    self.stepper.value = 12;
    self.textView.text = self.content;
    self.controlView = [[NSBundle mainBundle]loadNibNamed:@"ControlView" owner:self options:nil].firstObject;
    self.controlView.frame = CGRectMake(10, self.view.bounds.size.height, self.view.bounds.size.width - 20, 180);
    [self.view addSubview:self.controlView];
    self.textView.editable = NO;
}

//字号NSFontAttributeName  UIFont, default Helvetica(Neue) 12
//行间距lineHeightMultiple
//字体颜色NSForegroundColorAttributeName
//字体背景色NSBackgroundColorAttributeName
//字符间距NSKernAttributeName
//CGFloat lineSpacing;                 // 字体的行间距

-(NSMutableAttributedString *)setStringAttributeForegroundColor:(NSDictionary *)colorDic fontDic:(NSDictionary *)fontDic lineHeight:(CGFloat )heigt{
    self.attri = [[NSMutableAttributedString alloc]initWithString:self.content];
    NSRange ran =  NSMakeRange(0, self.content.length);
    //字体颜色
    [self.attri addAttributes:colorDic range:ran];
    //字体大小
    [self.attri  addAttributes:fontDic range:ran];
    //行间距
    self.para = [[NSMutableParagraphStyle alloc] init];
    self.para.lineHeightMultiple = heigt; // 调整行间距
    [self.attri addAttribute:NSParagraphStyleAttributeName value:self.para range:NSMakeRange(0, self.content.length)];
    return self.attri;
}
- (IBAction)sheZhiButton:(UIButton *)sender {
    
    
    if (self.controlView.y == self.view.bounds.size.height) {
        [UIView animateWithDuration:0.3 animations:^{
            self.controlView.frame = CGRectMake(10, self.view.bounds.size.height - 200, self.view.bounds.size.width - 20, 180);
        }];
        [self.shezhiButton setTitle:@"完成" forState:UIControlStateNormal];
        
        
    }else{
        [UIView animateWithDuration:0.3 animations:^{
             self.controlView.frame = CGRectMake(10, self.view.bounds.size.height, self.view.bounds.size.width - 20, 180);
        }];
        [self.shezhiButton setTitle:@"设置" forState:UIControlStateNormal];
     
    }
    
}
-(void)backC1Action:(UIButton *)sender{
    self.textView.backgroundColor = [UIColor orangeColor];
 
}
- (IBAction)backButton:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)stepperAction:(UIStepper *)sender {
    NSDictionary* attrs =@{NSFontAttributeName:[UIFont fontWithName:@"Helvetica" size:sender.value]};
    
    self.textView.attributedText = [self setStringAttributeForegroundColor:[self getColorWithButfalg:self.butflag] fontDic:attrs lineHeight:self.slider.value];
    
    
    
}
- (IBAction)slider:(UISlider *)sender {
   
    NSDictionary* attrs =@{NSFontAttributeName:[UIFont fontWithName:@"Helvetica" size:self.stepper.value]};
    self.textView.attributedText = [self setStringAttributeForegroundColor:[self getColorWithButfalg:self.butflag] fontDic:attrs lineHeight:self.slider.value];
    
   
    
}
-(NSDictionary *)getColorWithButfalg:(NSInteger )flag{
    
    switch (_butflag) {
        case 0:
            return  @{ NSForegroundColorAttributeName: [UIColor colorWithRed:252.0/255 green:36.0/255 blue:36.0 /255 alpha:1.0]};
            break;
        case 1:
            return  @{ NSForegroundColorAttributeName: [UIColor colorWithRed:71.0/255 green:253.0/255 blue:67.0 /255 alpha:1.0]};
            break;
        case 2:
            return @{ NSForegroundColorAttributeName: [UIColor colorWithRed:254.0/255 green:211.0/255 blue:118.0 /255 alpha:1.0]};
            break;
        case 3:
            return @{ NSForegroundColorAttributeName: [UIColor colorWithRed:201.0/255 green:211.0/255 blue:253.0 /255 alpha:1.0]};
            break;
        case 4:
            return @{ NSForegroundColorAttributeName: [UIColor blackColor]};
            break;
        case 5:
            return @{ NSForegroundColorAttributeName: [UIColor colorWithRed:251.0/255 green:243.0/255 blue:244.0 /255 alpha:1.0]};
            break;
        case 6:
            return @{ NSForegroundColorAttributeName: [UIColor colorWithRed:169.0/255 green:121.0/255 blue:71.0 /255 alpha:1.0]};
            
            break;
    
        
        
            
        default:
            break;
    }
    return 0;
}
- (IBAction)color1:(UIButton *)sender {
    NSDictionary *attrDict1 = @{ NSForegroundColorAttributeName: [UIColor colorWithRed:252.0/255 green:36.0/255 blue:36.0 /255 alpha:1.0]};
      NSDictionary* attrs =@{NSFontAttributeName:[UIFont fontWithName:@"Helvetica" size:self.stepper.value]};
    self.textView.attributedText = [self setStringAttributeForegroundColor:attrDict1 fontDic:attrs lineHeight:self.slider.value];
    _butflag = 0;
 
}
- (IBAction)color2:(UIButton *)sender {
     NSDictionary *attrDict1 = @{ NSForegroundColorAttributeName: [UIColor colorWithRed:71.0/255 green:253.0/255 blue:67.0 /255 alpha:1.0]};
    NSDictionary* attrs =@{NSFontAttributeName:[UIFont fontWithName:@"Helvetica" size:self.stepper.value]};
    self.textView.attributedText = [self setStringAttributeForegroundColor:attrDict1 fontDic:attrs lineHeight:self.slider.value];
    _butflag = 1;

}
- (IBAction)color3:(UIButton *)sender {
     NSDictionary *attrDict1 = @{ NSForegroundColorAttributeName: [UIColor colorWithRed:254.0/255 green:211.0/255 blue:118.0 /255 alpha:1.0]};
    NSDictionary* attrs =@{NSFontAttributeName:[UIFont fontWithName:@"Helvetica" size:self.stepper.value]};
    self.textView.attributedText = [self setStringAttributeForegroundColor:attrDict1 fontDic:attrs lineHeight:self.slider.value];
    _butflag = 2;

}
- (IBAction)color4:(UIButton *)sender {
     NSDictionary *attrDict1 = @{ NSForegroundColorAttributeName: [UIColor colorWithRed:201.0/255 green:211.0/255 blue:253.0 /255 alpha:1.0]};
    NSDictionary* attrs =@{NSFontAttributeName:[UIFont fontWithName:@"Helvetica" size:self.stepper.value]};
    self.textView.attributedText = [self setStringAttributeForegroundColor:attrDict1 fontDic:attrs lineHeight:self.slider.value];
    _butflag = 3;

}
- (IBAction)color5:(UIButton *)sender {
     NSDictionary *attrDict1 = @{ NSForegroundColorAttributeName: [UIColor blackColor]};
    NSDictionary* attrs =@{NSFontAttributeName:[UIFont fontWithName:@"Helvetica" size:self.stepper.value]};
    self.textView.attributedText = [self setStringAttributeForegroundColor:attrDict1 fontDic:attrs lineHeight:self.slider.value];
    _butflag = 4;

}
- (IBAction)color6:(UIButton *)sender {
     NSDictionary *attrDict1 = @{ NSForegroundColorAttributeName: [UIColor colorWithRed:251.0/255 green:243.0/255 blue:244.0 /255 alpha:1.0]};
    NSDictionary* attrs =@{NSFontAttributeName:[UIFont fontWithName:@"Helvetica" size:self.stepper.value]};
    self.textView.attributedText = [self setStringAttributeForegroundColor:attrDict1 fontDic:attrs lineHeight:self.slider.value];
    _butflag = 5;

}
- (IBAction)color7:(UIButton *)sender {
     NSDictionary *attrDict1 = @{ NSForegroundColorAttributeName: [UIColor colorWithRed:169.0/255 green:121.0/255 blue:71.0 /255 alpha:1.0]};
    NSDictionary* attrs =@{NSFontAttributeName:[UIFont fontWithName:@"Helvetica" size:self.stepper.value]};
    self.textView.attributedText = [self setStringAttributeForegroundColor:attrDict1 fontDic:attrs lineHeight:self.slider.value];
    _butflag = 6;

}







- (IBAction)backC2:(UIButton *)sender {
    self.textView.backgroundColor = [UIColor colorWithRed:248.0/255 green:228.0/255 blue:233.0 /255 alpha:1.0];
    _backgroundFlag = 1;
}
- (IBAction)backC3:(id)sender {
    self.textView.backgroundColor = [UIColor colorWithRed:207.0 /255 green:241.0/255 blue:239.0 /255 alpha:1.0];
    _backgroundFlag = 2;
}
- (IBAction)backC4:(id)sender {
    self.textView.backgroundColor = [UIColor colorWithRed:197.0/255 green:241.0/255 blue:239.0/255 alpha:1.0];
    _backgroundFlag = 3;
}
- (IBAction)backC5:(id)sender {
    self.textView.backgroundColor = [UIColor colorWithRed:216.0/255 green:201.0/255 blue:241.0/255 alpha:1.0];
    _backgroundFlag = 4;
}
- (IBAction)backC6:(id)sender {
    self.textView.backgroundColor = [UIColor colorWithRed:253.0/255 green:249.0/255 blue:249.0/255 alpha:1.0];
    _backgroundFlag = 5;
}
- (IBAction)backC7:(id)sender {
    self.textView.backgroundColor = [UIColor colorWithRed:226.0/255 green:240.0/255 blue:247.0/255 alpha:1.0];
    _backgroundFlag = 6;
}
- (IBAction)backC8:(id)sender {
    self.textView.backgroundColor = [UIColor colorWithRed:245.0/255 green:235.0/255 blue:219.0/255 alpha:1.0];
    _backgroundFlag = 7;
}
- (IBAction)backC9:(id)sender {
    self.textView.backgroundColor = [UIColor colorWithRed:228.0/255 green:240.0/255 blue:200.0/255 alpha:1.0];
    _backgroundFlag = 8;
}
-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = YES;
    self.navigationController.navigationBarHidden = YES;
}


@end
