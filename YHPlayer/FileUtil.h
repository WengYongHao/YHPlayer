//
//  FileUtil.h
//  YHPlayer
//
//  Created by Yonghao on 15/9/26.
//  Copyright © 2015年 Yonghao. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  目录类型
 */
typedef NS_ENUM(NSInteger, DirType)
{
    /**
     *  临时
     */
    temp,
    /**
     *  文档
     */
    documents,
    /**
     *  缓存
     */
    cache
};

@interface FileUtil : NSObject

/**
 *  保存文件到本地
 *
 *  @param fileName 文件名
 *  @param dirName  目录名
 *  @param dirType  目录类型
 *  @param content  文件内容
 *
 *  @return 文件路径
 */
+ (NSString *)createFileWithFileName:(NSString *)fileName dirName:(NSString *)dirName dirType:(DirType)dirType contents:(NSData *)content;


/**
 *  复制文件
 *
 *  @param filePath     源文件路径
 *  @param destFilePath 目标文件路径
 *
 *  @return <#return value description#>
 */
+ (BOOL)copyFileWithFilePath:(NSString *)orignalFilePath ToDestFilePath:(NSString *)destFilePath;

/**
 *  移动文件
 *
 *  @param orignalFilePath 源文件路径
 *  @param destFilePath    目标文件路径
 *
 *  @return
 */
+ (BOOL)moveFileWithFilePath:(NSString *)orignalFilePath ToDestFilePath:(NSString *)destFilePath;

/**
 *  获取图片缓存目录
 *
 *  @return 图片缓存目录路径
 */
+ (NSString *)getImageCachePath;

/**
 *  获取视频缓存目录
 *
 *  @return 视频缓存目录路径
 */
+ (NSString *)getVideoCachePath;

/**
 *  文件是否存在
 *
 *  @param filePath 文件路径
 *
 *  @return 文件是否存在
 */
+ (BOOL)isFileExist:(NSString *)filePath isDirectory:(BOOL *)isDirectory;

/**
 *  创建自定义文件夹
 */
+(void)initCustomFileDir;

/**
 *  删除文件
 *
 *  @param filePath 文件路径
 *
 *  @return 是否成功
 */
+(BOOL)delFileWithFilePath:(NSString *)filePath;

/**
 *  获取文件大小
 *
 *  @param filePath 文件路径
 *
 *  @return 文件大小
 */
+ (long long)fileSizeAtPath:(NSString*)filePath;

/**
 *  获取存储目录
 *
 *  @param dirType 目录类型
 *
 *  @return 目录路径
 */
+ (NSString *)getDirPreByDirType:(DirType)dirType;



@end
