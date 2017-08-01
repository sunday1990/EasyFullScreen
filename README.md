# EasyFullScreen
简易的全屏返回工具，全屏返回过程中支持透明度、颜色渐变，可以指定页面全屏返回。可拓展自己的转场策略
*  将`EasyFullScreen`文件夹拖入项目，
* `pch`里导入`UINavigationController+EasyFullScreen.h`文件，
* 在你想要进行全屏返回的页面的上一个页面，push的时候选择一个策略
 例子：
 ```
 [self.navigationController pushViewController:test1VC animated:YES animationStrategy:NavAnimationTransitionStrategyDefault];
 ```
如何制作自己的转场策略：
* 重写`- (void)easyFullScreenInteractiveTransitionRecognizerAction:(UIPanGestureRecognizer *)gestureRecognizer;`方法
* 制作自己的animators，自己控制进度，最后放入EasyFullScreen/Animators/Others即可。

