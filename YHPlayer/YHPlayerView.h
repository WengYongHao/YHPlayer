//
//  YHPlayerView.h
//  YHPlayer
//
//  Created by Yonghao on 15/9/24.
//  Copyright © 2015年 Yonghao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AVPlayer;
@class AVPlayerLayer;

@interface YHPlayerView : UIView

@property AVPlayer * player;
@property (readonly) AVPlayerLayer * playerLayer;
@end
