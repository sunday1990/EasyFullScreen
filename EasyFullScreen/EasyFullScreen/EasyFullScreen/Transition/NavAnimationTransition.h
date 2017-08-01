//
//  NavAnimationTransition.h
//  SpaceHome
//
//  Created by ccSunday on 2017/7/27.
//  Copyright © 2017年 kongjianjia.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, NavAnimationTransitionStrategy) {
    /*默认策略：透明度、颜色渐变，全屏返回*/
    NavAnimationTransitionStrategyDefault = 0,
    /*微信策略：*/
    NavAnimationTransitionStrategyWX      = 1
};

@interface NavAnimationTransition : NSObject<UINavigationControllerDelegate>
/**
 滑动手势
 */
@property (nonatomic,strong)UIPanGestureRecognizer *gestureRecognizer;

/**
 动画策略
 */
@property (nonatomic,assign)NavAnimationTransitionStrategy animationStrategy;

@end
