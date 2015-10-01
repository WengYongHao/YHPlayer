//
//  YHPlayerControl.h
//  YHPlayer
//
//  Created by Yonghao on 15/9/26.
//  Copyright © 2015年 Yonghao. All rights reserved.
//

#import "YHPlayerView.h"
#import <CoreMedia/CMTime.h>
#import "YHPlayerProtocol.h"

#import "VideoDownLoadManager.h"

@class AVPlayerItem;
@class AVURLAsset;

@interface YHPlayerControl : YHPlayerView

@property (copy, nonatomic) NSURL * inputUrl;

@property (copy, nonatomic) AVPlayerItem * playerItem;
@property (strong, nonatomic) AVURLAsset * urlAsset;

@property (assign, nonatomic) id<YHPlayerProtocol>delegate;

@property (strong, nonatomic, readonly) VideoDownLoadManager * downloadManager;

@property (assign, nonatomic) double progress;

//默认 NO
@property (assign, nonatomic) BOOL isPlayAfterFinishDownload;


//player的初始化
- (void)initPlayerViews;

- (void)play;
- (void)pause;

- (void)resetTimeToZero;
- (void)setCurrentTime:(CMTime)currentTime;

- (void)loadingProgress:(double)progress finish:(BOOL)finish;
@end

