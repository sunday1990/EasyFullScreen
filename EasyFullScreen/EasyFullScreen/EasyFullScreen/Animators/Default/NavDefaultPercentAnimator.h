//
//  NavDefaultPercentAnimator.h
//  SpaceHome
//
//  Created by ccSunday on 2017/7/28.
//  Copyright © 2017年 kongjianjia.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NavDefaultPercentAnimator : UIPercentDrivenInteractiveTransition
/**
 滑动手势
 */
@property (nonatomic,strong)UIPanGestureRecognizer *gestureRecognizer;

- (instancetype)initWithGestureRecognizer:(UIPanGestureRecognizer *)gestureRecognizer;

@end
