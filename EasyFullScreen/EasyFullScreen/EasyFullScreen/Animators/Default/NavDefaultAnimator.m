//
//  NavDefaultAnimator.m
//  SpaceHome
//
//  Created by ccSunday on 2017/7/27.
//  Copyright © 2017年 kongjianjia.com. All rights reserved.
//

#import "NavDefaultAnimator.h"

@implementation NavDefaultAnimator
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext{
    return 0.8;
}
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    //转场过渡的容器view
    UIView *containerView = [transitionContext containerView];
    
    //FromVC
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *fromView = fromViewController.view;
    fromView.frame = CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    
    //ToVC
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *toView = toViewController.view;
    toView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    
    //此处判断是push，还是pop 操作
    BOOL isPush = ([toViewController.navigationController.viewControllers indexOfObject:toViewController] > [fromViewController.navigationController.viewControllers indexOfObject:fromViewController]);
    
    if (isPush) {
        [containerView addSubview:fromView];
        [containerView addSubview:toView];
        toView.frame = CGRectMake([UIScreen mainScreen].bounds.size.width, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        toView.alpha = 0.3;
        fromView.alpha = 1;
    }else{
        [containerView addSubview:toView];
        [containerView addSubview:fromView];
        fromView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        fromView.alpha = 1;
        toView.alpha = 0.3;
    }
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                          delay:0
         usingSpringWithDamping:4
          initialSpringVelocity:0.5
                        options:UIViewAnimationCurveEaseOut|UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         if (isPush) {
                             toView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
                             toView.alpha = 1;
                             fromView.alpha = 1;
                         }else{
                             fromView.frame = CGRectMake([UIScreen mainScreen].bounds.size.width, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
                             fromView.alpha = 0.3;
                             toView.alpha = 1;
                             fromView.backgroundColor = toView.backgroundColor;
                         }
                     } completion:^(BOOL finished) {
                         BOOL wasCancelled = [transitionContext transitionWasCancelled];
                         [transitionContext completeTransition:!wasCancelled];

                     }];
}

@end
