//
//  TypeTableViewCell.m
//  YHPlayer
//
//  Created by Yonghao on 15/9/30.
//  Copyright © 2015年 Yonghao. All rights reserved.
//

#import "TypeTableViewCell.h"

NSString * const defaultCellIdentifier = @"defaultCellIdentifier";

@implementation TypeTableViewCell

- (void)awakeFromNib {
}

+ (CGFloat)cellHeight {
    return 50.0f;
}

+ (NSString *)cellIdentifier {
    return defaultCellIdentifier;
}

@end
