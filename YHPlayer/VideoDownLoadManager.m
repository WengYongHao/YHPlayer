//
//  VideoDownLoadManager.m
//  YHPlayer
//
//  Created by Yonghao on 15/9/26.
//  Copyright © 2015年 Yonghao. All rights reserved.
//

#import "VideoDownLoadManager.h"

#import "AFHTTPRequestOperation.h"

#import "FileUtil.h"
#import "NSString+MD5.h"

@interface VideoDownLoadManager ()

@property (strong, nonatomic) AFHTTPRequestOperation * requestOperation;

@end

@implementation VideoDownLoadManager

- (void)setVideoUrlstr:(NSString *)videoUrlstr {
    _videoUrlstr = videoUrlstr;
    [self initDownloadOperationWithUrl:videoUrlstr];
}

- (instancetype)initWithUrlStr:(NSString *)urlStr {
    if (self = [super init]) {
        self.videoUrlstr = urlStr;
        [self initDownloadOperationWithUrl:urlStr];
    }
    return self;
}

- (void)initDownloadOperationWithUrl:(NSString *)urlStr {
    NSURL * videoUrl = [NSURL URLWithString:urlStr];
    NSMutableURLRequest * downloadUrlReq = [NSMutableURLRequest requestWithURL:videoUrl];
//    downloadUrlReq addValue:<#(nonnull NSString *)#> forHTTPHeaderField:<#(nonnull NSString *)#>
    
    _requestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:downloadUrlReq];
    
    NSString *tempPath = [FileUtil getDirPreByDirType:temp];
    NSString *filePath = [tempPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@%@", [NSString md5:urlStr], [urlStr fileType]]];

    //大文件stream
    _requestOperation.inputStream = [NSInputStream inputStreamWithURL:videoUrl];
    _requestOperation.outputStream = [NSOutputStream outputStreamToFileAtPath:filePath append:NO];
}

- (void)setDownloadProgressBlock:(void (^)(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead))block {
    [_requestOperation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
        block(bytesRead, totalBytesRead, totalBytesExpectedToRead);
    }];
}

- (void)setCompletionBlockWithSuccess:(void (^)(AFHTTPRequestOperation *, id))success failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure {
    
    __block NSString *videoUrl = _videoUrlstr;
    __weak typeof(VideoDownLoadManager *) weakself = self;
    
    [_requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        NSString * tempPath = [FileUtil getDirPreByDirType:temp];
        NSString * originFilePath = [tempPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@%@", [NSString md5:videoUrl], [videoUrl fileType]]];
        
        NSString * destFilePath = nil;
        if (weakself.savePath != nil) {
            destFilePath = _savePath;
        }
        else {
            NSString *videoCachePath = [FileUtil getVideoCachePath];
            destFilePath = [videoCachePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@%@", [NSString md5:videoUrl], [videoUrl fileType]]];
        }
        
        [FileUtil moveFileWithFilePath:originFilePath ToDestFilePath:destFilePath];
        
        long long fileSize = [FileUtil fileSizeAtPath:destFilePath];
        
        success(operation, [NSNumber numberWithLongLong:fileSize]);
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        failure(operation, error);
        
    }];
}

- (void)startDownload
{
    if (_requestOperation) {
        [_requestOperation start];
    }
}

- (void)resumeDownload
{
    if (_requestOperation) {
        [_requestOperation resume];
    }
}

- (void)pauseDownload
{
    if (_requestOperation) {
        [_requestOperation pause];
    }
}

- (void)cancelDownload
{
    if (_requestOperation) {
        [_requestOperation cancel];
    }
}

- (BOOL)isDownloadExecuting
{
    if (_requestOperation) {
        return [_requestOperation isExecuting];
    } else {
        return NO;
    }
}

- (BOOL)isDownloadPause
{
    if (_requestOperation) {
        return [_requestOperation isPaused];
    } else {
        return NO;
    }
}

@end
