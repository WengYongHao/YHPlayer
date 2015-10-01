//
//  ViewController.m
//  YHPlayer
//
//  Created by Yonghao on 15/9/23.
//  Copyright © 2015年 Yonghao. All rights reserved.
//

#import "ViewController.h"

#import <AVFoundation/AVFoundation.h>
#import "YHPlayerView.h"
#import "YHPlayerControl.h"

#import "YHPlayerCustomControl.h"
#import "PlayBtn.h"

#define iOS9 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0)
#define iOS8 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#define iOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_9_0
#import <Photos/Photos.h>
#elif #if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_7_0
#import <AssetsLibrary/AssetsLibrary.h>
#endif

#if DEBUG
#import <AssetsLibrary/AssetsLibrary.h>
#endif


@interface ViewController () {
    YHPlayerCustomControl * _fullScreenPlayer;
}

@property (strong, nonatomic) AVQueuePlayer * player;
@property (weak, nonatomic) IBOutlet YHPlayerView *playerView;

@property (weak, nonatomic) IBOutlet PlayBtn *btn;
@property (weak, nonatomic) IBOutlet YHPlayerCustomControl *playerControl;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    self.playerView.player = self.player;
    
    NSString * urlStr = @"https://devimages.apple.com.edgekey.net/samplecode/avfoundationMedia/AVFoundationQueuePlayer_Progressive.mov";
    NSURL * mediaURL = [NSURL URLWithString:urlStr];
    [_playerControl initPlayerViews];
    _playerControl.isPlayAfterFinishDownload = NO;
    _playerControl.inputUrl = mediaURL;
    _playerControl.coverImageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"bg_female.png" ofType:nil]];
    _playerControl.isTouchPause = YES;
//    [self asynchronouslyLoadURLAsset:[AVURLAsset assetWithURL:mediaURL] title:nil thumbnailResourceName:nil];
}

- (IBAction)playAction:(PlayBtn *)sender {
    static BOOL y = YES;
    y = !y;
    if (!y) {
        
    }
    else {
        UIWindow * screenView = [UIApplication sharedApplication].keyWindow;
//        ////    [_playerControl mutableCopy];
//        [_playerControl removeFromSuperview];
//        [self.view addSubview:_playerControl];
        
        _fullScreenPlayer = [[YHPlayerCustomControl alloc] init];
        NSString * urlStr = @"https://devimages.apple.com.edgekey.net/samplecode/avfoundationMedia/AVFoundationQueuePlayer_Progressive.mov";
        NSURL * mediaURL = [NSURL URLWithString:urlStr];
        [_fullScreenPlayer initPlayerViews];
        _fullScreenPlayer.isPlayAfterFinishDownload = _playerControl.isPlayAfterFinishDownload;
        _fullScreenPlayer.inputUrl = mediaURL;
        _fullScreenPlayer.isTouchPause = YES;
        
        double newRate = self.player.rate;//[change[NSKeyValueChangeNewKey] doubleValue];
        BOOL isPlaying = (newRate >= 1.0) ? YES : NO;
        
        [_playerControl pause];
        [_fullScreenPlayer play];
        [_fullScreenPlayer setCurrentTime:_playerControl.playerItem.currentTime];
        [screenView addSubview:_fullScreenPlayer];
        _fullScreenPlayer.frame = _playerControl.frame;
        
        if (isPlaying) {
            
        }
        [UIView animateWithDuration:0.6 animations:^{
            _fullScreenPlayer.transform = CGAffineTransformMakeRotation(M_PI/2);
            _fullScreenPlayer.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
            
            _fullScreenPlayer.playBtn.center = CGPointMake([UIScreen mainScreen].bounds.size.height/2, [UIScreen mainScreen].bounds.size.width/2);
//            [_playerControl layoutIfNeeded];
        } completion:^(BOOL finished) {
            
        }];
        
    }
    
    
}



- (UIViewController *)activityViewController
{
    UIViewController* activityViewController = nil;
    
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    if(window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow *tmpWin in windows)
        {
            if(tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    NSArray *viewsArray = [window subviews];
    if([viewsArray count] > 0)
    {
        UIView *frontView = [viewsArray objectAtIndex:0];
        
        id nextResponder = [frontView nextResponder];
        
        if([nextResponder isKindOfClass:[UIViewController class]])
        {
            activityViewController = nextResponder;
        }
        else
        {
            activityViewController = window.rootViewController;
        }
    }
    
    return activityViewController;
}

- (void)playfullAction:(UITapGestureRecognizer *)sender {
    static BOOL y = YES;
    y = !y;
    if (!y) {
        //        [self.playerControl play];
        [_fullScreenPlayer play];
    }else {
        //        [self.playerControl pause];
        [_fullScreenPlayer pause];
    }
}

- (AVQueuePlayer *)player {
    if (!_player) {
        _player = [[AVQueuePlayer alloc] init];
    }
    return _player;
}



+ (NSArray *)assetKeysRequiredToPlay {
    return @[@"playable", @"hasProtectedContent"];
}

- (void)asynchronouslyLoadURLAssetsWithManifestURL:(NSURL *)jsonURL
{
    NSArray *assetsArray = nil;
    
    NSData *jsonData = [[NSData alloc] initWithContentsOfURL:jsonURL];
    if (jsonData) {
        assetsArray = (NSArray *)[NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
        if (!assetsArray) {
            
        }
    }
    else {
           }
    
    for (NSDictionary *assetDict in assetsArray) {
        
        NSURL *mediaURL = nil;
        NSString *optionalResourceName = assetDict[@"mediaResourceName"];
        NSString *optionalURLString = assetDict[@"mediaURL"];
        if (optionalResourceName) {
            mediaURL = [[NSBundle mainBundle] URLForResource:[optionalResourceName stringByDeletingPathExtension] withExtension:optionalResourceName.pathExtension];
        }
        else if (optionalURLString) {
            
            mediaURL = [NSURL URLWithString:optionalURLString];
            
        }
        
        
        [self asynchronouslyLoadURLAsset:[AVURLAsset URLAssetWithURL:mediaURL options:nil]
                                   title:assetDict[@"title"]
                   thumbnailResourceName:assetDict[@"thumbnailResourceName"]];
    }
}

- (void)asynchronouslyLoadURLAsset:(AVURLAsset *)asset title:(NSString *)title thumbnailResourceName:(NSString *)thumbnailResourceName {
    __weak typeof(self) weakSelf = self;
   
    [asset loadValuesAsynchronouslyForKeys:ViewController.assetKeysRequiredToPlay completionHandler:^{
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
    
            for (NSString *key in self.class.assetKeysRequiredToPlay) {
                NSError *error = nil;
                if ([asset statusOfValueForKey:key error:&error] == AVKeyValueStatusFailed) {
                    
                    
//                    [self handleErrorWithMessage:message error:error];
                    
                    return;
                }
            }
            
            // We can't play this asset.
            if (!asset.playable || asset.hasProtectedContent) {
               //                [self handleErrorWithMessage:message error:nil];
                
                return;
            }
            
            
            
            AVPlayerItem * playerItem = [[AVPlayerItem alloc] initWithAsset:asset];
            [weakSelf.player insertItem:playerItem afterItem:nil];
            
        });
    }];
}


-(NSURL *)getFileUrl{
    NSURL *url= [[NSBundle mainBundle] URLForResource:@"shasiqinliugan.mp4" withExtension:nil]; //[NSURL fileURLWithPath:urlStr];
    return url;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
