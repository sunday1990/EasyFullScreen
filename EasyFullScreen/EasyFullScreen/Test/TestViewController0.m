//
//  TestViewController0.m
//  EasyFullScreen
//
//  Created by ccSunday on 2017/8/1.
//  Copyright © 2017年 ccSunday. All rights reserved.
//

#import "TestViewController0.h"
#import "TestViewController1.h"

@interface TestViewController0 ()

@end

@implementation TestViewController0

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"test0_Easy";
    self.view.backgroundColor = [UIColor greenColor];
    self.descriptionLabel.text = @"将采用默认转场策略进入test1页面，test1页面将拥有全屏返回和返回时颜色、透明度渐变效果";
}

- (void)rightNavButtonDidClick:(UIButton *)rightNavBtn{
    TestViewController1 *test1VC = [[TestViewController1 alloc]init];
    [self.navigationController pushViewController:test1VC animated:YES animationStrategy:NavAnimationTransitionStrategyDefault];
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
