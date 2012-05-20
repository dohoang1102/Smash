//
//  ViewController.m
//  Smash
//
//  Created by 藤木 裕介 on 12/05/20.
//  Copyright (c) 2012年 Private. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // 乱数の初期化
    srand(time(NULL));
    
    // タイマーの作成
    [NSTimer scheduledTimerWithTimeInterval:1 // 時間間隔(秒)
                                    target:self // 呼び出すオブジェクト
                      selector:@selector(move:) // 呼び出すメソッド
                                   userInfo:nil // ユーザー利用の情報オブジェクト
                                  repeats:YES]; // 繰り返し

    // 効果音の再生を準備
    NSURL *smashSoundURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"Smash" ofType:@"aif"]];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)smashSoundURL, &smashSoundID);

    NSURL *failSoundURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"Fail" ofType:@"aif"]];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)failSoundURL, &failSoundID);

    defaultImage = [UIImage imageNamed:@"Target.png"];
    smashImage = [UIImage imageNamed:@"Target-Smashed.png"];
    failImage = [UIImage imageNamed:@"Target-Failed.png"];
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint loc = [((UITouch *)[touches anyObject])locationInView:self.view];
    UIView *subview = [self.view hitTest:loc withEvent:nil];
    
    switch (subview.tag) {
        case 1:
            AudioServicesPlayAlertSound(smashSoundID);
            [target setImage:smashImage];
            break;
            
        default:
            AudioServicesPlayAlertSound(failSoundID);
            [target setImage:failImage];
            break;
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [target setImage:defaultImage];
}

- (void)move:(NSTimer *)timer
{
    // アニメーションの定義開始
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    
    // アニメーションによって変化させる事柄を設定
    // UFOを移動
    int x = rand() % 320;
    int y = rand() % 480;
    target.center = CGPointMake(x, y);
    
    // アニメーションの定義終了、実行
    [UIView commitAnimations];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
