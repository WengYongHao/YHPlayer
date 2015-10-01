//
//  VideoUtil.m
//  YHPlayer
//
//  Created by Yonghao on 15/9/26.
//  Copyright © 2015年 Yonghao. All rights reserved.
//

#import "VideoUtil.h"

#import "FileUtil.h"
#import "NSString+MD5.h"

@implementation VideoUtil

+ (NSString *)getVideoPathByVideoUrl:(NSString *)videoUrl {
    
    NSString * path = nil;
    BOOL isDir = NO;
    
    if (videoUrl) {
        NSString * videoPath = [[FileUtil getVideoCachePath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@%@",[NSString md5:videoUrl],[videoUrl fileType]]];
        if ([FileUtil isFileExist:videoPath isDirectory:&isDir]) {
            path = videoPath;
        }
    }
    
    return path;
}

+ (BOOL)delVideoByVideoUrl:(NSString *)videoUrl {
    
    NSString *videoPath = [VideoUtil getVideoPathByVideoUrl:videoUrl];
    if (videoPath) {
        return [FileUtil delFileWithFilePath:videoPath];
    } else {
        return NO;
    }
}


@end
