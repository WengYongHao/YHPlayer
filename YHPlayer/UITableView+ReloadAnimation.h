//
//  UITableView+ReloadAnimation.h
//  YHPlayer
//
//  Created by Yonghao on 15/10/1.
//  Copyright © 2015年 Yonghao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, TableViewReloadAnimationDirect) {
    DropDownFromTop,
    LiftUpFromBottum,
    FromRightToLeft,
    FromLeftToRight,
};


@interface UITableView (ReloadAnimation)

/**
 *  动态刷新tableView
 *
 *  @param direct        动画方向
 *  @param animationTime 动画持续时间，设置成1.0
 *  @param interval      每个cell间隔，设置成0.1
 */
- (void)reloadDataWithAnimationDirect:(TableViewReloadAnimationDirect)direction
                        animationTime:(NSTimeInterval)animationTime
                             interval:(NSTimeInterval)interval;


@end
