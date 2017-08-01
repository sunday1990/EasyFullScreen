//
//  NavDefaultPercentAnimator.m
//  SpaceHome
//
//  Created by ccSunday on 2017/7/28.
//  Copyright © 2017年 kongjianjia.com. All rights reserved.
//

#import "NavDefaultPercentAnimator.h"

@implementation NavDefaultPercentAnimator

//开始交互转场,实现 UIViewControllerInteractiveTransitioning 协议的方法（必须实现）
- (void)startInteractiveTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    //相当于走到 Animator 中的代理方法去了，那里实现了具体的动画
    [super startInteractiveTransition:transitionContext];
}

- (instancetype)initWithGestureRecognizer:(UIPanGestureRecognizer *)gestureRecognizer
{
    self = [super init];
    if (self)
    {
        _gestureRecognizer = gestureRecognizer;
        
        [_gestureRecognizer addTarget:self action:@selector(updateTransitionPercent:)];
    }
    return self;
}

- (void)setGestureRecognizer:(UIPanGestureRecognizer *)gestureRecognizer{
    _gestureRecognizer = gestureRecognizer;
    [_gestureRecognizer addTarget:self action:@selector(updateTransitionPercent:)];
}

- (void)updateTransitionPercent:(UIPanGestureRecognizer *)gestureRecognizer{
    CGFloat scale = 1 - [self percentForGesture:gestureRecognizer];
    switch (gestureRecognizer.state)
    {
        case UIGestureRecognizerStateBegan:
            break;
        case UIGestureRecognizerStateChanged:
            //更新百分比
            [self updateInteractiveTransition:scale];
            break;
        case UIGestureRecognizerStateEnded:
            if (scale < 0.2){
                //取消转场
                [self cancelInteractiveTransition];
            }else{
                //完成转场
                [self finishInteractiveTransition];
            }
            break;
        default:
            //取消转场
            [self cancelInteractiveTransition];
            break;
    }
}

- (CGFloat)percentForGesture:(UIPanGestureRecognizer *)gesture
{
    CGPoint translation = [gesture translationInView:gesture.view];
    /*此处只计算x向右移动的情况*/
    if (translation.x < 0) {
        return 1;
    }else{
        CGFloat scale = 1 - (translation.x / [UIScreen mainScreen].bounds.size.width);
        return scale;
    }
}

- (void)dealloc
{
    [self.gestureRecognizer removeTarget:self action:@selector(updateTransitionPercent:)];
}

@end
