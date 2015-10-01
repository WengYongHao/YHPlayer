//
//  VideoListCell.h
//  YHPlayer
//
//  Created by Yonghao on 15/10/1.
//  Copyright © 2015年 Yonghao. All rights reserved.
//

#import "YHTableViewCell.h"
@class YHPlayerCustomControl;

@interface VideoListCell : YHTableViewCell

@property (weak, nonatomic) IBOutlet YHPlayerCustomControl *player;


+ (NSString *)cellIdentifier;
+ (CGFloat)cellHeight;

@end
