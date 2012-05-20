//
//  ViewController.h
//  Smash
//
//  Created by 藤木 裕介 on 12/05/20.
//  Copyright (c) 2012年 Private. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioServices.h>

@interface ViewController : UIViewController
{
    IBOutlet UIImageView *target;
    UIImage *defaultImage;
    UIImage *smashImage;
    UIImage *failImage;
    SystemSoundID smashSoundID;
    SystemSoundID failSoundID;
}

@end
