//
//  UINavigationController+EasyFullScreen.m
//  EasyFullScreen
//
//  Created by ccSunday on 2017/8/1.
//  Copyright © 2017年 ccSunday. All rights reserved.
//

#import "UINavigationController+EasyFullScreen.h"
#import <objc/runtime.h>

@implementation UIViewController (EasyFullScreen)

static char KNavAnimatedTransitionKey;

static char KNavStrategyPushKey;

static char KNavStrategyPopKey;

+ (void)load{
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^
                  {
                      SEL swizzleSelectors[2] = {
                          @selector(viewDidLoad),
                          @selector(viewDidAppear:)
                      };
                      
                      for (int i = 0; i < 1;  i++) {
                         
                          SEL selector = swizzleSelectors[i];
                          
                          NSString *newSelectorStr = [NSString stringWithFormat:@"easy_%@", NSStringFromSelector(selector)];
                          
                          Method originMethod = class_getInstanceMethod(self, selector);
                          
                          Method swizzledMethod = class_getInstanceMethod(self, NSSelectorFromString(newSelectorStr));
                          
                          method_exchangeImplementations(originMethod, swizzledMethod);
                      }
                  });
}

- (void)easy_viewDidLoad{
    if (self.navAnimatedTransition) {
        UIPanGestureRecognizer *gestureRecognizer;
        gestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(easyFullScreenInteractiveTransitionRecognizerAction:)];
        [self.view addGestureRecognizer:gestureRecognizer];
    }
    [self easy_viewDidLoad];
}

- (void)easy_viewDidAppear:(BOOL)animated{
    
    [self easy_viewDidAppear:animated];
    if (self.navAnimatedTransition) {
        self.navigationController.delegate = self.navAnimatedTransition;
    }
    /*当进入到当前页面后，将该标志位置为NO，这个值只有在进行策略push的时候才会置为YES，当再次pop回该页面的时候，该值需要被置为NO,同理pop*/
    self.isStrategyPush = NO;
    self.isStrategyPop = NO;
}

- (void)setIsStrategyPush:(BOOL)isStrategyPush{
    objc_setAssociatedObject(self, &KNavStrategyPushKey, @(isStrategyPush), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)isStrategyPush{
    NSNumber *pushStrtegy = (NSNumber *)objc_getAssociatedObject(self, &KNavStrategyPushKey);
    return [pushStrtegy boolValue];
}

- (void)setIsStrategyPop:(BOOL)isStrategyPop{
    objc_setAssociatedObject(self, &KNavStrategyPopKey, @(isStrategyPop), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)isStrategyPop{
    NSNumber *popStrtegy = (NSNumber *)objc_getAssociatedObject(self, &KNavStrategyPopKey);
    return [popStrtegy boolValue];
}

- (void)setNavAnimatedTransition:(NavAnimationTransition *)navAnimatedTransition{
    objc_setAssociatedObject(self, &KNavAnimatedTransitionKey, navAnimatedTransition, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NavAnimationTransition *)navAnimatedTransition{
    NavAnimationTransition *navAnimatedTransition = (NavAnimationTransition *)objc_getAssociatedObject(self, &KNavAnimatedTransitionKey);
    return navAnimatedTransition;
}

#pragma mark 子类可以重写该方法,在该方法里，提供默认的几种策略
- (void)easyFullScreenInteractiveTransitionRecognizerAction:(UIPanGestureRecognizer *)gestureRecognizer {
    if (NavAnimationTransitionStrategyDefault == self.navAnimatedTransition.animationStrategy) {
        switch (gestureRecognizer.state) {
            case UIGestureRecognizerStatePossible:
                break;
            case UIGestureRecognizerStateBegan:
                self.navigationController.delegate = self.navAnimatedTransition;
                self.navAnimatedTransition.gestureRecognizer = gestureRecognizer;
                self.isStrategyPop = YES;
                [self.navigationController popViewControllerAnimated:YES];
                break;
            case UIGestureRecognizerStateChanged:
                break;
            case UIGestureRecognizerStateFailed:
            case UIGestureRecognizerStateCancelled:
            case UIGestureRecognizerStateEnded:
                self.navAnimatedTransition.gestureRecognizer = nil;
                break;
        }
    }
}

@end

@implementation UINavigationController (EasyFullScreen)

+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^
                  {
                      SEL swizzleSelectors[4] = {
                          @selector(popToViewController:animated:),
                          @selector(popToRootViewControllerAnimated:),
                          @selector(popViewControllerAnimated:),
                          @selector(pushViewController:animated:)
                      };
                      
                      for (int i = 0; i < 4;  i++) {
                          SEL selector = swizzleSelectors[i];
                          NSString *newSelectorStr = [NSString stringWithFormat:@"easy_%@", NSStringFromSelector(selector)];
                          
                          Method originMethod = class_getInstanceMethod(self, selector);
                          
                          Method swizzledMethod = class_getInstanceMethod(self, NSSelectorFromString(newSelectorStr));
                          
                          method_exchangeImplementations(originMethod, swizzledMethod);
                      }
                  });
}

- (NSArray<UIViewController *> *)easy_popToViewController:(UIViewController *)viewController animated:(BOOL)animated{
    UIViewController *fromVC = self.topViewController;
    if (fromVC.navAnimatedTransition) {
        self.delegate = nil;
    }
    return [self easy_popToViewController:viewController animated:animated];
}

- (NSArray<UIViewController *> *)easy_popToRootViewControllerAnimated:(BOOL)animated{
    UIViewController *fromVC = self.topViewController;
    if (fromVC.navAnimatedTransition) {
        self.delegate = nil;
    }
    return [self easy_popToRootViewControllerAnimated:animated];
}

- (UIViewController *)easy_popViewControllerAnimated:(BOOL)animated{
    UIViewController *fromVC = self.topViewController;
    if (fromVC.navAnimatedTransition&&(fromVC.isStrategyPop != YES)) {
        self.delegate = nil;
    }
    return [self easy_popViewControllerAnimated:animated];
}

- (void)easy_pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    NSLog(@"fromVC:%@",NSStringFromClass([self.topViewController class]));
    UIViewController *fromVC = self.topViewController;
    if (fromVC.navAnimatedTransition && (fromVC.isStrategyPush != YES)) {//当前有策略并且是普通的push的时候，需要将代理位置nil，以保证下一个页面的正确性
        self.delegate = nil;
    }
    if (self.viewControllers.count) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    if (1 == self.viewControllers.count) {
        self.viewControllers.firstObject.hidesBottomBarWhenPushed = NO;
    }
    [self easy_pushViewController:viewController animated:YES];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated animationStrategy:(NavAnimationTransitionStrategy)strategy{
    [self setPriviousAnimationStrategy];
    [self setNavigationDelegateWithController:viewController animationStrategy:strategy];
    [self setNavigationDelegateWithController:self.topViewController animationStrategy:strategy];
    [self pushViewController:viewController animated:YES];
}

- (void)setPriviousAnimationStrategy{
    UIViewController *fromVC = self.topViewController;
    fromVC.isStrategyPush = YES;
}

- (void)setNavigationDelegateWithController:(UIViewController *)controller animationStrategy:(NavAnimationTransitionStrategy)strategy{
    NavAnimationTransition *animatedTransition = [[NavAnimationTransition alloc]init];
    /*初始化的时候，需要传入动画策略*/
    animatedTransition.animationStrategy = strategy;
    controller.navAnimatedTransition = animatedTransition;
    /*设置代理*/
    self.delegate = animatedTransition;
}
@end
