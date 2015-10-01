//
//  YHPlayerView.m
//  YHPlayer
//
//  Created by Yonghao on 15/9/24.
//  Copyright © 2015年 Yonghao. All rights reserved.
//

#import "YHPlayerView.h"
#import <AVFoundation/AVFoundation.h>

@interface YHPlayerView ()


@end

@implementation YHPlayerView


- (AVPlayer *)player {
    return self.playerLayer.player;
}

- (void)setPlayer:(AVPlayer *)player {
    self.playerLayer.player = player;
}

+ (Class)layerClass {
    return [AVPlayerLayer class];
}

- (AVPlayerLayer *)playerLayer {
    return (AVPlayerLayer *)self.layer;
}


@end
