//
//  BaseViewController.m
//  EasyFullScreen
//
//  Created by ccSunday on 2017/8/1.
//  Copyright © 2017年 ccSunday. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    [self.rightNavBtn setTitle:@"Next" forState:UIControlStateNormal];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if ([self isRootViewController]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }else{
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
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

*/
- (void)rightNavButtonDidClick:(UIButton *)rightNavBtn{
    NSLog(@"right navBtn did clicked");
}

- (BOOL)isRootViewController{
    return (self == self.navigationController.viewControllers.firstObject);
}

- (UIButton *)rightNavBtn{
    if (!_rightNavBtn) {
        _rightNavBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        [_rightNavBtn setTitle:@"" forState:UIControlStateNormal];
        _rightNavBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -16);
        _rightNavBtn.frame = CGRectMake(0, 0, 70, 37);
        [_rightNavBtn setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
        [_rightNavBtn addTarget:self action:@selector(rightNavButtonDidClick:) forControlEvents:UIControlEventTouchUpInside];
        _rightNavBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        UIBarButtonItem *rightNavBarButton = [[UIBarButtonItem alloc] initWithCustomView:_rightNavBtn];
        self.navigationItem.rightBarButtonItem = rightNavBarButton;
    }
    return _rightNavBtn;
}

- (UILabel *)descriptionLabel{
    if (!_descriptionLabel) {
        _descriptionLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 100)];
        _descriptionLabel.numberOfLines = 0;
        _descriptionLabel.textAlignment = NSTextAlignmentCenter;
        _descriptionLabel.font = [UIFont systemFontOfSize:14];
        [self.view addSubview:_descriptionLabel];
    }
    return _descriptionLabel;
}

@end
