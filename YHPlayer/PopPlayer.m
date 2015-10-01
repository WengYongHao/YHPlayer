//
//  PopPlayer.m
//  YHPlayer
//
//  Created by Yonghao on 15/10/1.
//  Copyright © 2015年 Yonghao. All rights reserved.
//

#import "PopPlayer.h"

@interface PopPlayer()

@property (strong, nonatomic) UIView * backgroundView;

@property (strong, nonatomic) UIWindow * keyWindow;

@end

@implementation PopPlayer

- (void)show:(BOOL)isPlayAfterShow {
    
    [self.keyWindow addSubview:self.backgroundView];
    [self.keyWindow addSubview:self];
    
    [UIView animateWithDuration:.5f delay:0.0 usingSpringWithDamping:0.4 initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        self.frame =  (CGRect){self.center, CGSizeMake(UISCREEN_WIDTH - 40, (9.0/16.0)*(UISCREEN_WIDTH - 40))};
        self.center = CGPointMake(UISCREEN_WIDTH/2, UISCREEN_HEIGHT/2);
        
    } completion:^(BOOL finished) {
        if (isPlayAfterShow) [self play];
    }];
}

- (void)bgtapAction:(UITapGestureRecognizer *)sender {
   
    [UIView animateWithDuration:.5 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _backgroundView.alpha = 0;
        self.frame = CGRectMake(self.frame.origin.x, UISCREEN_HEIGHT, self.frame.size.width, self.frame.size.height);
    } completion:^(BOOL finished) {
        [_backgroundView removeFromSuperview];
        [self removeFromSuperview];
    }];
    
}

- (UIView *)backgroundView {
    if (_backgroundView == nil) {
        _backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UISCREEN_WIDTH, UISCREEN_HEIGHT)];
        _backgroundView.backgroundColor = [UIColor blackColor];
        _backgroundView.alpha = 0.6;
        
        UITapGestureRecognizer * bgtap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bgtapAction:)];
        _backgroundView.userInteractionEnabled = YES;
        [_backgroundView addGestureRecognizer:bgtap];
    }
    return _backgroundView;
}

- (UIWindow *)keyWindow {
    if (_keyWindow == nil) {
        _keyWindow = [UIApplication sharedApplication].keyWindow;
    }
    return _keyWindow;
}

- (void)dealloc {
    NSLog(@"pop player dealloc");
}

@end
