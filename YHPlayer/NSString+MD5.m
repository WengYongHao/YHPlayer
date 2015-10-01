//
//  NSString+MD5.m
//  YHPlayer
//
//  Created by Yonghao on 15/9/26.
//  Copyright © 2015年 Yonghao. All rights reserved.
//

#import "NSString+MD5.h"

#import <CommonCrypto/CommonDigest.h>

@implementation NSString (MD5)

+ (NSString *)md5:(NSString *)str {
    if (str && str.length > 0) {
        const char *cStr = [str UTF8String]; //转换成utf-8
        unsigned char result[16]; //开辟一个16字节（128位：md5加密出来就是128位/bit）的空间（一个字节=8字位=8个二进制数）
        CC_MD5( cStr, (unsigned int)strlen(cStr), result);
        /*
         extern unsigned char *CC_MD5(const void *data, CC_LONG len, unsigned char *md)官方封装好的加密方法
         把cStr字符串转换成了32位的16进制数列（这个过程不可逆转）存储到了result这个空间中
         */
        return [NSString stringWithFormat:
                @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
                result[0], result[1], result[2], result[3],
                result[4], result[5], result[6], result[7],
                result[8], result[9], result[10], result[11],
                result[12], result[13], result[14], result[15]
                ];
        /*
         x表示十六进制，%02X  意思是不足两位将用0补齐，如果多余两位则不影响
         NSLog("%02X", 0x888);  //888
         NSLog("%02X", 0x4); //04
         */
        
    } else {
        return @"";
    }
}

- (NSString *)fileType
{
    //默认为空
    NSString * fileTypeStr = @"";
    //从url中获取图片类型
    NSMutableArray *arr = (NSMutableArray *)[self componentsSeparatedByString:@"."];
    if (arr) {
        fileTypeStr = [NSString stringWithFormat:@".%@", [arr objectAtIndex:arr.count-1]];
    }
    
    if (![fileTypeStr isEqualToString:@".jpg"] && ![fileTypeStr isEqualToString:@".png"] && ![fileTypeStr isEqualToString:@".mp4"] && ![fileTypeStr isEqualToString:@".mov"]) {
        fileTypeStr = @"";
    }
    
    return fileTypeStr;
}

@end
