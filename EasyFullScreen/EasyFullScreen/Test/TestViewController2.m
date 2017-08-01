//
//  TestViewController2.m
//  EasyFullScreen
//
//  Created by ccSunday on 2017/8/1.
//  Copyright © 2017年 ccSunday. All rights reserved.
//

#import "TestViewController2.h"
#import "TestViewController0.h"
@interface TestViewController2 ()

@end

@implementation TestViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"test2";
    self.view.backgroundColor = [UIColor orangeColor];
    self.descriptionLabel.text = @"将采用默认转场策略进入test0页面，test0页面将拥有全屏返回和返回时颜色、透明度渐变效果，但该页面返回的时候，没有全屏返回功能";

}

- (void)rightNavButtonDidClick:(UIButton *)rightNavBtn{
    TestViewController0 *test0VC = [[TestViewController0 alloc]init];
    [self.navigationController pushViewController:test0VC animated:YES animationStrategy:NavAnimationTransitionStrategyDefault];
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
