//
//  TypeTableViewCell.h
//  YHPlayer
//
//  Created by Yonghao on 15/9/30.
//  Copyright © 2015年 Yonghao. All rights reserved.
//

#import "YHTableViewCell.h"

@interface TypeTableViewCell : YHTableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

+ (CGFloat)cellHeight;
+ (NSString *)cellIdentifier;

@end
