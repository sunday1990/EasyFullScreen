//
//  TestViewController1.m
//  EasyFullScreen
//
//  Created by ccSunday on 2017/8/1.
//  Copyright © 2017年 ccSunday. All rights reserved.
//

#import "TestViewController1.h"
#import "TestViewController2.h"

@interface TestViewController1 ()

@end

@implementation TestViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"test1_Easy";
    self.view.backgroundColor = [UIColor redColor];
    self.descriptionLabel.text = @"进入下一个test2页面的时候没有策略，因此test2将不具备全屏返回等功能，但当前test1页可以全屏返回";

    
}

- (void)rightNavButtonDidClick:(UIButton *)rightNavBtn{
    TestViewController2 *test2VC = [[TestViewController2 alloc]init];
    [self.navigationController pushViewController:test2VC animated:YES];
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
