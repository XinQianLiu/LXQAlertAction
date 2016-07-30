//
//  UIWindow+LXQWindow.h
//  LXQAlertAction
//
//  Created by 用户 on 16/7/29.
//  Copyright © 2016年 XinQianLiu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIWindow (LXQWindow)

- (UIViewController *)currentViewController;

#ifdef __IPHONE_7_0
- (UIViewController *)viewControllerForStatusBarStyle;
- (UIViewController *)viewControllerForStatusBarHidden;
#endif

@end
