//
//  BaseViewController.h
//  EasyFullScreen
//
//  Created by ccSunday on 2017/8/1.
//  Copyright © 2017年 ccSunday. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UINavigationController+EasyFullScreen.h"

@interface BaseViewController : UIViewController

@property (nonatomic,strong) UIButton *rightNavBtn;

@property (nonatomic,strong) UILabel *descriptionLabel;

- (void)rightNavButtonDidClick:(UIButton *)rightNavBtn;

@end
