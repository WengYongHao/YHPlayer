//
//  YHPlayerCustomControl.h
//  YHPlayer
//
//  Created by Yonghao on 15/9/29.
//  Copyright © 2015年 Yonghao. All rights reserved.
//

/**
 *  自定义播放器的样式
 */

#import "YHPlayerControl.h"

#import "SDDemoItemView.h"

@class PlayBtn;

@interface YHPlayerCustomControl : YHPlayerControl

@property (strong, nonatomic) PlayBtn * playBtn;
@property (strong, nonatomic) UIImageView * coverImageView;
@property (strong, nonatomic) SDDemoItemView * progressView;

@property (assign, nonatomic) BOOL isTouchPause;

@end
