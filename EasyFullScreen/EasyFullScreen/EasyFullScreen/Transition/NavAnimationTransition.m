//
//  NavAnimationTransition.m
//  SpaceHome
//
//  Created by ccSunday on 2017/7/27.
//  Copyright © 2017年 kongjianjia.com. All rights reserved.
//

#import "NavAnimationTransition.h"
/*default*/
#import "NavDefaultAnimator.h"
#import "NavDefaultPercentAnimator.h"
@interface NavAnimationTransition ()

/*default*/
@property (nonatomic,strong) NavDefaultAnimator *defaultAnimator;
@property (nonatomic,strong) NavDefaultPercentAnimator *defaultPercentAnimator;

@end

@implementation NavAnimationTransition

- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC{
    switch (self.animationStrategy) {
        case NavAnimationTransitionStrategyDefault:
            return self.defaultAnimator;
            break;
        default:
            break;
    }
    return nil;;
}

/*如果返回的nil的话，那么系统就认为没有交互效果，会直接返回，如果我们想要有交互的话，那么需要返回一个遵守UIViewControllerInteractiveTransitioning协议的对象，里面实现系统需要的方法，而我们的交互动画，又必然跟手势有关，所以需要耦合一个手势，根据手势的变化，来确定交互的进度。*/
- (nullable id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                                   interactionControllerForAnimationController:(nonnull id<UIViewControllerAnimatedTransitioning>)animationController{
    if (_gestureRecognizer == nil) {
        return nil;
    }else{
        switch (self.animationStrategy) {
            case NavAnimationTransitionStrategyDefault:
                return self.defaultPercentAnimator;
                break;
            default:
                break;
        }
        return nil;
    }
}

- (void)setGestureRecognizer:(UIPanGestureRecognizer *)gestureRecognizer{
    _gestureRecognizer = gestureRecognizer;
    switch (self.animationStrategy) {
        case NavAnimationTransitionStrategyDefault:
            self.defaultPercentAnimator.gestureRecognizer = _gestureRecognizer;
            break;
        default:
            break;
    }
}

#pragma mark  ==== Getters ====

#pragma mark default

- (NavDefaultAnimator *)defaultAnimator{
    if (!_defaultAnimator) {
        _defaultAnimator = [[NavDefaultAnimator alloc]init];
    }
    return _defaultAnimator;
}

- (NavDefaultPercentAnimator *)defaultPercentAnimator{
    if (!_defaultPercentAnimator) {
        _defaultPercentAnimator = [[NavDefaultPercentAnimator alloc]init];
    }
    return _defaultPercentAnimator;
}

@end
