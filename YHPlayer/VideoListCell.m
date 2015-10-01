//
//  VideoListCell.m
//  YHPlayer
//
//  Created by Yonghao on 15/10/1.
//  Copyright © 2015年 Yonghao. All rights reserved.
//

#import "VideoListCell.h"
#import "YHPlayerCustomControl.h"

NSString * const videoListCelldentifier = @"VideoListCelldentifier";

@implementation VideoListCell

- (void)awakeFromNib {
    
    
    [self configPlayer];
    NSString * urlStr = @"https://devimages.apple.com.edgekey.net/samplecode/avfoundationMedia/AVFoundationQueuePlayer_Progressive.mov";
    NSURL * mediaURL = [NSURL URLWithString:urlStr];
    
    _player.inputUrl = mediaURL;
    _player.coverImageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"bg_female.png" ofType:nil]];
    
}

- (void)configPlayer {
    [_player initPlayerViews];
    _player.isPlayAfterFinishDownload = YES;
    _player.isTouchPause = YES;
}

+ (NSString *)cellIdentifier {
    return videoListCelldentifier;
}

+ (CGFloat)cellHeight {
    return 200.0;
}

@end
