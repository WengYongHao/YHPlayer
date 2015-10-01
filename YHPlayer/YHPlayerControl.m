//
//  YHPlayerControl.m
//  YHPlayer
//
//  Created by Yonghao on 15/9/26.
//  Copyright © 2015年 Yonghao. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>

#import "YHPlayerControl.h"

#import "FileUtil.h"
#import "VideoUtil.h"
#import "NSString+MD5.h"

@interface YHPlayerControl ()

@property (strong, nonatomic) AVPlayer * currentPlayer;

@property (strong, nonatomic) VideoDownLoadManager * downloadManager;


@end

@implementation YHPlayerControl

- (void)initPlayerViews {
    [self currentPlayer];
}

- (void)layoutIfNeeded {
    [super layoutIfNeeded];
}

- (void)drawRect:(CGRect)rect {
    [self layoutIfNeeded];
    
}

- (void)play {
    
    if ([self.delegate respondsToSelector:@selector(playerPrepareToPlay:)]) {
        [self.delegate playerPrepareToPlay:self];
    }
    if (_isPlayAfterFinishDownload) {
        
        [self initPlayItem];
        if (_currentPlayer.currentItem == nil || ![_currentPlayer.currentItem isEqual:_playerItem]) {
            [self setPlayItemForPlay];
        }
        else {
            [self playerPlay];
        }
        
    }else {
        if (_playerItem.asset == nil) {
            [self asynchronouslyLoadURLAsset:_urlAsset];
        }
        [self playerPlay];
    }
}

- (void)playerPlay {
    
    [_currentPlayer play];
}

- (void)pause {
    [self.currentPlayer pause];
    [_downloadManager pauseDownload];
}

- (void)cancel {
    [_currentPlayer pause];
    [_downloadManager cancelDownload];
}

//初始化PlayItem
- (void)initPlayItem {
    if (_inputUrl) {
        if (_playerItem) {
            AVURLAsset * urlAsset = (AVURLAsset *)_playerItem.asset;
            
            NSString * currentUrlStr = [NSString stringWithFormat:@"file://%@", [[FileUtil getVideoCachePath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@%@", [NSString md5:_inputUrl.absoluteString], [_inputUrl.absoluteString fileType]]]];

            if (![currentUrlStr isEqualToString:urlAsset.URL.absoluteString]) {
                _playerItem  = [AVPlayerItem playerItemWithAsset:[AVURLAsset URLAssetWithURL:_inputUrl options:nil]];
            }
        }
        else {
            _playerItem  = [AVPlayerItem playerItemWithAsset:[AVURLAsset URLAssetWithURL:_inputUrl options:nil]];
        }
        
    }
}

- (void)setPlayItemForPlay {
    if (_inputUrl) {
        
        NSString * videoPath = [VideoUtil getVideoPathByVideoUrl:_inputUrl.absoluteString];
        if (videoPath) {
            _playerItem = [AVPlayerItem playerItemWithURL:[NSURL fileURLWithPath:videoPath isDirectory:NO]];
            [_currentPlayer replaceCurrentItemWithPlayerItem:_playerItem];
            
            [self playerPlay];
        }
        else {
            [self downloadVideoWithVideoUrl:_inputUrl.absoluteString];
        }
    }
}

- (void)downloadVideoWithVideoUrl:(NSString *)videoUrl {
    [self downloadManager];
    [self loadingProgress:_progress finish:NO];
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [self.downloadManager setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                CGFloat progress = totalBytesRead * 100.0f / totalBytesExpectedToRead;
                weakSelf.progress = progress;
                [weakSelf loadingProgress:progress finish:NO];
                if ([weakSelf.delegate respondsToSelector:@selector(loadingProgress:finish:)]) {
                    [weakSelf.delegate loadVideoProgress:progress finish:NO];
                }
                
                
            });
           
        }];
        
        [self.downloadManager setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            dispatch_async(dispatch_get_main_queue(), ^{
                CGFloat progress = 100.0;
                [weakSelf loadingProgress:progress finish:YES];
                if ([weakSelf.delegate respondsToSelector:@selector(loadingProgress:finish:)]) {
                    [weakSelf.delegate loadVideoProgress:progress finish:YES];
                }
            });
            
            [weakSelf downloadCompleteToPlay:[VideoUtil getVideoPathByVideoUrl:videoUrl]];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [weakSelf cancel];
            [VideoUtil delVideoByVideoUrl:weakSelf.inputUrl.absoluteString];
        }];
        
        [self.downloadManager startDownload];
        
        if ([_downloadManager isDownloadPause]) {
            [self.downloadManager resumeDownload];
        }
    });
    
}

- (void)downloadCompleteToPlay:(NSString *)videoPath {
    
}

- (void)loadingProgress:(double)progress finish:(BOOL)finish {
    
}

//在线播放,无永久性缓存(无加载后自动播放)
- (void)asynchronouslyLoadURLAsset:(AVURLAsset *)asset {
    
    _urlAsset = asset;
    [_urlAsset loadValuesAsynchronouslyForKeys:self.class.assetKeysRequiredToPlay completionHandler:^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            for (NSString *key in self.class.assetKeysRequiredToPlay) {
                NSError *error = nil;
                if ([_urlAsset statusOfValueForKey:key error:&error] == AVKeyValueStatusFailed) {
                  return;
                }
            }
            
            if (!_urlAsset.playable || _urlAsset.hasProtectedContent) {
                return;
            }
            _playerItem = [AVPlayerItem playerItemWithAsset:_urlAsset];
            [self.currentPlayer replaceCurrentItemWithPlayerItem:_playerItem];
            [self.currentPlayer play];
        });
    }];
}

//尝试加载和检测资源
+ (NSArray *)assetKeysRequiredToPlay {
    return @[@"playable", @"hasProtectedContent"];
}

#pragma mark - setter
- (void)setCurrentTime:(CMTime)currentTime {
    [_currentPlayer seekToTime:currentTime toleranceBefore:kCMTimeZero toleranceAfter:kCMTimeZero];
}

- (void)resetTimeToZero {
    [_currentPlayer seekToTime:kCMTimeZero];
    [self pause];
}

- (void)setInputUrl:(NSURL *)inputUrl {
    _inputUrl = inputUrl;
    self.downloadManager.videoUrlstr = inputUrl.absoluteString;
    
    //在线播放
    _urlAsset = [AVURLAsset assetWithURL:_inputUrl];
}


#pragma maek - getter
- (AVPlayer *)currentPlayer {
    if (_currentPlayer == nil) {
        _currentPlayer = [[AVPlayer alloc] init];
        self.player = _currentPlayer;
    }
    return _currentPlayer;
}

- (VideoDownLoadManager *)downloadManager {
    if (_downloadManager == nil) {
        _downloadManager = [[VideoDownLoadManager alloc] init];
    }
    return _downloadManager;
}


- (void)dealloc {
    [self cancel];
    NSLog(@"YHPlayerControl dealloc");
}

@end
