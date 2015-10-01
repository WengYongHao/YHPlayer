//
//  VideoUtil.h
//  YHPlayer
//
//  Created by Yonghao on 15/9/26.
//  Copyright © 2015年 Yonghao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VideoUtil : NSObject

+ (NSString *)getVideoPathByVideoUrl:(NSString *)VideoUrl;
+ (BOOL)delVideoByVideoUrl:(NSString *)videoUrl;

@end
