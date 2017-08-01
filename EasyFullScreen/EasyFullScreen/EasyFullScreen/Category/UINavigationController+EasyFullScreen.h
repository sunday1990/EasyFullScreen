//
//  UINavigationController+EasyFullScreen.h
//  EasyFullScreen
//
//  Created by ccSunday on 2017/8/1.
//  Copyright © 2017年 ccSunday. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NavAnimationTransition.h"

@interface UIViewController (EasyFullScreen)
/*自定义navigationController动画协议的实现者*/
@property (nonatomic,strong) NavAnimationTransition *navAnimatedTransition;

/*是否是策略push，如果A push到 B的时候，带着策略，那么A的isStrategyPush属性为YES*/
@property (nonatomic,assign) BOOL isStrategyPush;

/*是否是策略pop，如果B pop回 A的时候，带着策略，那么B的isStrategyPop属性为YES*/
@property (nonatomic,assign) BOOL isStrategyPop;
/**
 策略转场的时候，交互手势的响应事件，可以重写该方法
 
 @param gestureRecognizer gestureRecognizer description
 */
- (void)easyFullScreenInteractiveTransitionRecognizerAction:(UIPanGestureRecognizer *)gestureRecognizer;

@end

@interface UINavigationController (EasyFullScreen)

/**
 带动画策略的push操作
 
 @param viewController viewController description
 @param animated animated description
 @param strategy strategy description
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated animationStrategy:(NavAnimationTransitionStrategy)strategy;

@end
