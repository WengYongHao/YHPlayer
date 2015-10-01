//
//  YHPlayerCustomControl.m
//  YHPlayer
//
//  Created by Yonghao on 15/9/29.
//  Copyright © 2015年 Yonghao. All rights reserved.
//

#import "YHPlayerCustomControl.h"
#import <AVFoundation/AVFoundation.h>

#import "SDProgressView.h"
#import "PlayBtn.h"

#import "VideoUtil.h"

static int AAPLPlayerViewControllerKVOContext = 0;

@interface YHPlayerCustomControl ()
<
    YHPlayerProtocol
>
{
    id<NSObject> _timeObserverToken;
}

@end

@implementation YHPlayerCustomControl

- (void)initPlayerViews {
    
    [super initPlayerViews];
    [self playBtn];
    [self coverImageView];
    [self progressView];
    
    [self addPlayerObserver];
}

- (void)addPlayerObserver {
    
    //监听播放进度,设置进度条
    __weak typeof(self) weakSelf = self;
    _timeObserverToken = [self.player addPeriodicTimeObserverForInterval:CMTimeMake(1, 1) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
        
        double timeElapsed = CMTimeGetSeconds(time);
        double durTime = CMTimeGetSeconds(weakSelf.playerItem.duration);
        double progress = 100 * timeElapsed/durTime;
        
        BOOL finish = fabs(timeElapsed - durTime) < DBL_EPSILON?YES:NO;

        if ([weakSelf respondsToSelector:@selector(playProgress:finish:)]) {
            [weakSelf.delegate playProgress:progress finish:finish];
        }
        
//        NSLog(@"%f", progress);
//        NSLog(@"%i", finish);
    }];
    
    //监听 暂停/播放 状态
    [self addObserver:self forKeyPath:@"player.rate" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionInitial context:&AAPLPlayerViewControllerKVOContext];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    if (context != &AAPLPlayerViewControllerKVOContext) {
    
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        return;
    }
    
    if ([keyPath isEqualToString:@"player.rate"]) {
        NSLog(@"unknow err 第一次播放 多了一次rate 变化");
        
        //设置播放按钮显示状态
        double newRate = self.player.rate;//[change[NSKeyValueChangeNewKey] doubleValue];
        BOOL isPlayBtnHiden = (newRate >= 1.0) ? YES : NO;
        _playBtn.hidden = isPlayBtnHiden;
        
        if (isPlayBtnHiden) _coverImageView.hidden = YES;
        
        //设置播放结束后回滚
        double currentTime = CMTimeGetSeconds(self.player.currentItem.currentTime);
        double durTime = CMTimeGetSeconds(self.playerItem.duration);
        
        if (fabs(durTime - currentTime) < DBL_EPSILON) {
            [self resetTimeToZero];
        }
    }
    
    else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }

}


#pragma mark - action
- (void)tapPauseAction:(UITapGestureRecognizer *)sender {
    
    BOOL isPlaying = (self.player.rate >= 1.0) ? YES : NO;
    
    NSString * videoPath = [VideoUtil getVideoPathByVideoUrl:self.inputUrl.absoluteString];
    
    if (videoPath == nil) {
        if ([self.downloadManager isDownloadExecuting]) {
            [self pause];
        }
        else {
            [self play];
        }
    }
    else {
        if (isPlaying) {
            [self pause];
        }
        else {
            _progressView.hidden = YES;
            [self play];
        }
    }
}

#pragma mark - setter
- (void)setIsTouchPause:(BOOL)isTouchPause {
    _isTouchPause = isTouchPause;
    if (_isTouchPause) {
        UITapGestureRecognizer * pauseTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapPauseAction:)];
        self.userInteractionEnabled = YES;
        [self addGestureRecognizer:pauseTap];
    }
}


#pragma mark- getter
- (PlayBtn *)playBtn {
    if (_playBtn == nil) {
        _playBtn = [[PlayBtn alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
        _playBtn.enabled = NO;
        [self addSubview:_playBtn];
    }
    return _playBtn;
}

- (UIImageView *)coverImageView {
    if (_coverImageView == nil) {
        _coverImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _coverImageView.clipsToBounds = YES;
        _coverImageView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:_coverImageView];
        [self bringSubviewToFront:self.playBtn];
    }
    return _coverImageView;
}

- (SDDemoItemView *)progressView {
    if (_progressView == nil) {
        _progressView = [SDDemoItemView demoItemViewWithClass:[SDPieProgressView class]];
        _progressView.hidden = YES;
        _progressView.userInteractionEnabled = NO;
        [self addSubview:_progressView];
    }
    return _progressView;
}

#pragma mark - overide

- (void)loadingProgress:(double)progress finish:(BOOL)finish {
    [super loadingProgress:progress finish:finish];
    _playBtn.hidden = YES;
    _progressView.hidden = finish;
    _progressView.progressView.progress = progress/100;
    
    if (finish) {
        [self play];
    }
}

- (void)resetTimeToZero {
    [super resetTimeToZero];
    _progressView.hidden = YES;
    _coverImageView.hidden = NO;
    _playBtn.hidden = NO;
    [self pause];
}

- (void)layoutIfNeeded {
    [super layoutIfNeeded];
    
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    _playBtn.center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    _coverImageView.frame = CGRectMake(0, 0, rect.size.width, rect.size.height);
    _progressView.frame = CGRectMake(0, 0, 44, 44);
    _progressView.center = _playBtn.center;
}

- (void)dealloc {
    [self.player removeTimeObserver:_timeObserverToken];

    [self removeObserver:self forKeyPath:@"player.rate" context:&AAPLPlayerViewControllerKVOContext];
    NSLog(@"YHPlayerCustomControl dealloc");
}

@end
