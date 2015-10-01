//
//  YHPlayerProtocol.h
//  YHPlayer
//
//  Created by Yonghao on 15/10/1.
//  Copyright © 2015年 Yonghao. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YHPlayerControl;

@protocol YHPlayerProtocol <NSObject>

@optional
/**
 *  加载视频进度
 *
 *  @param progress 0 ～ 100
 *  @param finish   <#finish description#>
 */
- (void)loadVideoProgress:(double)progress finish:(BOOL)finish;

/**
 *  视频播放进度
 *
 *  @param progress 0 ～ 100
 *  @param finish   <#finish description#>
 */
- (void)playProgress:(double)progress finish:(BOOL)finish;

- (void)playerPrepareToPlay:(YHPlayerControl *)player;

@end
