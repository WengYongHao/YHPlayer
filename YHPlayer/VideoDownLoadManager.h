//
//  VideoDownLoadManager.h
//  YHPlayer
//
//  Created by Yonghao on 15/9/26.
//  Copyright © 2015年 Yonghao. All rights reserved.
//

/**
 *  video 下载
 */

#import <Foundation/Foundation.h>

@class AFHTTPRequestOperation;

@interface VideoDownLoadManager : NSObject

@property (copy, nonatomic) NSString * videoUrlstr;
@property (copy, nonatomic) NSString * savePath;

- (instancetype)initWithUrlStr:(NSString *)urlStr;

- (void)startDownload;

- (void)resumeDownload;

- (void)pauseDownload;

- (void)cancelDownload;

- (BOOL)isDownloadExecuting;

- (BOOL)isDownloadPause;

- (void)setDownloadProgressBlock:(void (^)(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead))block;

- (void)setCompletionBlockWithSuccess:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                              failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

@end
