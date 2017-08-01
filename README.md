# EasyFullScreen
#### 功能
* 简易的全屏返回工具
* 支持全屏返回
* 支持返回过程中的透明度、颜色渐变
* 可以指定页面进行全屏返回
* 可以拓展自己的转场策略
#### 如何使用
*  将`EasyFullScreen`文件夹拖入项目，
* `pch`里导入`UINavigationController+EasyFullScreen.h`文件，
* 在你想要进行全屏返回的页面的上一个页面，push的时候选择一个策略
 例子：
 ```
 [self.navigationController pushViewController:test1VC animated:YES animationStrategy:NavAnimationTransitionStrategyDefault];
 ```
#### 如何制作自己的转场策略：
* 重写`- (void)easyFullScreenInteractiveTransitionRecognizerAction:(UIPanGestureRecognizer *)gestureRecognizer;`方法
* 制作自己的`animators`，自己控制进度，最后放入EasyFullScreen/Animators/Others。
* 到`NavAnimationTransition`中，仿照形式，加入你自己的策略

时间问题，暂时只提供了一种转场策略，后期会不断完善，考虑到需要拓展，暂时没有上传到cocoaPod。
如有问题与建议，请到简书私信我。
简书地址：http://www.jianshu.com/u/32eb67860b09
