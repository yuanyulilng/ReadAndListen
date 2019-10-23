//
//  TingDetailViewController.m
//  ShiTingYueDu
//
//  Created by 袁玉灵 on 2019/3/9.
//  Copyright © 2019年 袁玉灵. All rights reserved.
//

#import "TingDetailViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "TingControlView.h"
#import "UIView+Category.h"
@interface TingDetailViewController ()<AVSpeechSynthesizerDelegate>
@property (strong, nonatomic) IBOutlet TingControlView *tingControlView;

@property (weak, nonatomic) IBOutlet UITextView *textView;

@property(nonatomic,strong) NSArray * strArray;
@property(nonatomic,strong) NSArray *voiceArray;
@property(nonatomic,strong) AVSpeechSynthesizer *synthesizer;
@property (nonatomic,assign)BOOL isPlay;
/**<#注释#> */
@property (nonatomic,strong) AVSpeechUtterance *utterance;
/**<#注释#> */
@property (nonatomic,strong) NSString *string1;
/**<#注释#> */
@property (nonatomic,strong) NSString *str;

@property (weak, nonatomic) IBOutlet UIButton *sheZhiButton;
//音调slider
@property (weak, nonatomic) IBOutlet UISlider *yinDiao;
@property (weak, nonatomic) IBOutlet UISlider *yusu;
@property (weak, nonatomic) IBOutlet UISlider *yinliang;

@property (weak, nonatomic) IBOutlet UISlider *delay;


/**语调标记**/
@property (nonatomic , assign) CGFloat pitchflag;
/**语速标记**/
@property (nonatomic , assign) CGFloat rateflag;
/**声音标记**/
@property (nonatomic , assign) CGFloat volumflag;
/**延时标记**/
@property (nonatomic , assign) CGFloat delayflag;



@end

@implementation TingDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _pitchflag = 0.0;
    _rateflag = 0.0;
    _volumflag = 0.0;
    _delayflag = 0.0;
    self.navigationController.navigationBarHidden = YES;
    
    _string1 = @"";
    _str = @"";
    
   

    self.tingControlView = [[NSBundle mainBundle]loadNibNamed:@"TingControlView" owner:self options:nil].firstObject;
    self.tingControlView.frame = CGRectMake(10, self.view.bounds.size.height, self.view.bounds.size.width - 20, 250);
    
   
    [self.view addSubview:self.tingControlView];
    
    [self yuyinbofangRate:self.yusu.value pitchMultipiler:self.yinDiao.value preUtteranceDelay:self.delay.value volume:self.yinliang.value];
    
    
}
-(void)yuyinbofangRate:(CGFloat )rate pitchMultipiler:(CGFloat )pitch preUtteranceDelay:(CGFloat )delay volume:(CGFloat )volume {
   
    //字符串分割,装进数组
    self.strArray =   [self.content componentsSeparatedByString:@"。"];
    
    self.voiceArray = @[[AVSpeechSynthesisVoice voiceWithLanguage:@"en-GB"],[AVSpeechSynthesisVoice voiceWithLanguage:@"en-US"]];
    self.synthesizer = [[AVSpeechSynthesizer alloc]init];
    
    self.synthesizer.delegate = self;
    for (int i = 0; i < self.strArray.count;  i ++) {
        self.utterance = [[AVSpeechUtterance alloc]initWithString:self.strArray[i]];
        //需要读的语言
        if (i < 200) {
            _utterance.voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"zh-CN"];
        }
        else{
            _utterance.voice = self.voiceArray[i%2];
        }
        /*
        //语速0.0f~1.0f
        _utterance.rate = 0.5f;
        //声音的音调0.5f~2.0f
        _utterance.pitchMultiplier = 1.0f;
        //播放下下一句话的时候有多长时间的延迟
        _utterance.postUtteranceDelay = 0.05f;
        //上一句之前需要多久
        _utterance.preUtteranceDelay = 0.5f;
        //音量
        _utterance.volume = 1.0f;
         */
        _utterance.rate = rate;
        _utterance.pitchMultiplier = pitch;
        _utterance.preUtteranceDelay = delay;
        _utterance.volume = volume;
        //开始播放
        [self.synthesizer speakUtterance:_utterance];
        _isPlay = YES;
}
}
//开始朗读的代理方法
- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didStartSpeechUtterance:(AVSpeechUtterance *)utterance{
    //NSLog(@"didStartSpeechUtterance->%@",utterance.speechString);
}
//结束朗读的代理方法
- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didFinishSpeechUtterance:(AVSpeechUtterance *)utterance{
   // NSLog(@"didFinishSpeechUtterance->%@",utterance.speechString);
}
//暂停朗读的代理方法
- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didPauseSpeechUtterance:(AVSpeechUtterance *)utterance{
  //  NSLog(@"didPauseSpeechUtterance->%@",utterance.speechString);
}
//继续朗读的代理方法
- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didContinueSpeechUtterance:(AVSpeechUtterance *)utterance{
  //  NSLog(@"didContinueSpeechUtterance->%@",utterance.speechString);
}
//取消朗读的代理方法
- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didCancelSpeechUtterance:(AVSpeechUtterance *)utterance{
  //  NSLog(@"didCancelSpeechUtterance->%@",utterance.speechString);
}
//将要播放的语音文字
- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer willSpeakRangeOfSpeechString:(NSRange)characterRange utterance:(AVSpeechUtterance *)utterance{
  // NSLog(@"willSpeakRangeOfSpeechString->characterRange.location = %zd->characterRange.length = %zd->utterance.speechString= %@",characterRange.location,characterRange.length,utterance.speechString);
    if (![utterance.speechString isEqualToString: _str]) {
       
        _string1 =  [_string1 stringByAppendingString:utterance.speechString];
        
        //self.textView.text = _string1;
        UITextRange *textRange = [self.textView textRangeFromPosition:self.textView.beginningOfDocument toPosition:self.textView.endOfDocument];
        [ self.textView replaceRange:textRange withText:_string1];
        [self.textView scrollRangeToVisible:NSMakeRange(_string1.length, 1)];
    }

    _str = utterance.speechString;
}

- (IBAction)backButton:(UIButton *)sender {
    [_synthesizer stopSpeakingAtBoundary:AVSpeechBoundaryImmediate];
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)sheZhi:(UIButton *)sender {
    
    if (self.tingControlView.y == self.view.bounds.size.height) {
        [UIView animateWithDuration:0.3 animations:^{
            self.tingControlView.frame = CGRectMake(10, self.view.frame.size.height - 270, self.view.bounds.size.width - 20, 250);
        }];
        [self.sheZhiButton setTitle:@"完成" forState:UIControlStateNormal];
        
    }else{
        [UIView animateWithDuration:0.3 animations:^{
            self.tingControlView.frame =CGRectMake(10, self.view.bounds.size.height, self.view.bounds.size.width - 20, 250);
        }];
        [self.sheZhiButton setTitle:@"设置" forState:UIControlStateNormal];

    }
}
- (IBAction)bofang:(UIButton *)sender {
    if (_isPlay) {
        [_synthesizer pauseSpeakingAtBoundary:AVSpeechBoundaryImmediate];
        [sender setTitle:@"播放" forState:UIControlStateNormal];
        _isPlay = NO;
        
    }else if(!_isPlay){
        [_synthesizer continueSpeaking];
    
        [sender setTitle:@"暂停" forState:UIControlStateNormal];
        _isPlay = YES;

    }
}
- (IBAction)yinDiao:(UISlider *)sender {
    
    [_synthesizer stopSpeakingAtBoundary:AVSpeechBoundaryImmediate];
    [self yuyinbofangRate:_rateflag>0?_rateflag:self.yusu.value  pitchMultipiler:sender.value preUtteranceDelay:_delayflag>0?_delayflag: self.delay.value volume:_volumflag>0?_volumflag: self.yinliang.value];
    _string1 = @"";
}
- (IBAction)yusuSlider:(UISlider *)sender {
    
    [_synthesizer stopSpeakingAtBoundary:AVSpeechBoundaryImmediate];
    [self yuyinbofangRate:sender.value  pitchMultipiler:_pitchflag>0?_pitchflag:self.yinDiao.value preUtteranceDelay:_delayflag>0?_delayflag: self.delay.value volume:_volumflag>0?_volumflag: self.yinliang.value];
    
    _string1 = @"";
    
}
- (IBAction)yinliangSlider:(UISlider *)sender {
    [_synthesizer stopSpeakingAtBoundary:AVSpeechBoundaryImmediate];
    [self yuyinbofangRate:_rateflag>0?_rateflag:self.yusu.value   pitchMultipiler:_pitchflag>0?_pitchflag:self.yinDiao.value preUtteranceDelay:_delayflag>0?_delayflag: self.delay.value volume: sender.value];
    _string1 = @"";
}
- (IBAction)delaySlider:(UISlider *)sender {
    [_synthesizer stopSpeakingAtBoundary:AVSpeechBoundaryImmediate];
    [self yuyinbofangRate:_rateflag>0?_rateflag:self.yusu.value   pitchMultipiler:_pitchflag>0?_pitchflag:self.yinDiao.value preUtteranceDelay:sender.value volume: _volumflag>0?_volumflag:self.yinliang.value];
    _string1 = @"";
}
-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = YES;
    self.navigationController.navigationBarHidden = YES;

    
}
@end
