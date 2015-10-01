//
//  FileUtil.m
//  YHPlayer
//
//  Created by Yonghao on 15/9/26.
//  Copyright © 2015年 Yonghao. All rights reserved.
//

#import "FileUtil.h"

@implementation FileUtil

+ (void)initCustomFileDir
{
    BOOL isDir = YES;
    NSString *imageCachePath = [self getImageCachePath];
    if (![self isFileExist:imageCachePath isDirectory:&isDir]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:imageCachePath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    NSString *videoCachePath = [self getVideoCachePath];
    if (![self isFileExist:videoCachePath isDirectory:&isDir]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:videoCachePath withIntermediateDirectories:YES attributes:nil error:nil];
    }
}

+ (BOOL)isFileExist:(NSString *)filePath isDirectory:(BOOL *)isDirectory
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager fileExistsAtPath:filePath isDirectory:isDirectory];
}

+ (long long)fileSizeAtPath:(NSString*) filePath {
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}

+ (BOOL)copyFileWithFilePath:(NSString *)orignalFilePath ToDestFilePath:(NSString *)destFilePath
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSError *error;
    
    BOOL isCopySuccess = [fileManager copyItemAtPath:orignalFilePath toPath:destFilePath error:&error];
    
    NSLog(@"copy error:%@", error.description);
    
    return isCopySuccess;
}

+ (BOOL)moveFileWithFilePath:(NSString *)orignalFilePath ToDestFilePath:(NSString *)destFilePath
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSError *error;
    
    BOOL isMoveSuccess = [fileManager moveItemAtPath:orignalFilePath toPath:destFilePath error:&error];
    
    NSLog(@"move error:%@", error.description);
    
    return isMoveSuccess;
}

+ (NSString *)createFileWithFileName:(NSString *)fileName dirName:(NSString *)dirName dirType:(DirType)dirType contents:(NSData *)content
{
    NSString *filePath = nil;
    
    NSString *dirPre;
    
    BOOL isFileCreated = NO;
    
    dirPre = [self getDirPreByDirType:dirType];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    
    if (dirPre == nil) {
        
        filePath = [dirPre stringByAppendingPathComponent:fileName];
        isFileCreated = [fileManager createFileAtPath:filePath contents:content attributes:nil];
        if (isFileCreated) {
            return filePath;
        }
    } else {
        
        [fileManager createDirectoryAtPath:[dirPre stringByAppendingPathComponent:dirName] withIntermediateDirectories:YES attributes:nil error:nil];
        filePath = [[dirPre stringByAppendingPathComponent:dirName] stringByAppendingPathComponent:fileName];
        isFileCreated = [fileManager createFileAtPath:filePath contents:content attributes:nil];
        if (isFileCreated) {
            return filePath;
        }
    }
    
    return filePath;
}

+ (NSString *)getImageCachePath
{
    return [[self getDirPreByDirType:cache] stringByAppendingPathComponent:@"imageCache"];
}

+ (NSString *)getVideoCachePath
{
    return [[self getDirPreByDirType:cache] stringByAppendingPathComponent:@"videoCache"];
}

+ (NSString *)getDirPreByDirType:(DirType)dirType
{
    switch (dirType) {
        case cache:
            return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
            break;
        case documents:
            return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
            break;
        case temp:
            return NSTemporaryDirectory();
            break;
    }
}

+(BOOL)delFileWithFilePath:(NSString *)filePath
{
    NSError *err;
    return [[NSFileManager defaultManager] removeItemAtPath:filePath error:&err];
}


@end
