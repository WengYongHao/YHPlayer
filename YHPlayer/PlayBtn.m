//
//  PlayBtn.m
//  YHPlayer
//
//  Created by Yonghao on 15/9/25.
//  Copyright © 2015年 Yonghao. All rights reserved.
//

#import "PlayBtn.h"

@implementation PlayBtn

- (void)drawRect:(CGRect)rect {
    CGFloat roundWidth = MIN(rect.size.height, rect.size.width) - 1;
    
    CGRect backRect = CGRectMake(rect.size.width/2 - roundWidth/2, rect.size.height/2 - roundWidth/2, roundWidth, roundWidth);
    UIBezierPath * bezierPath = [UIBezierPath bezierPathWithOvalInRect:backRect];
    self.backColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    [self.backColor setFill];
    
    [bezierPath fill];
    
    UIColor * lineColor = [UIColor whiteColor];
    [lineColor set];

    roundWidth *= .5f;
    CGFloat triangleHiegt = sqrt(roundWidth*roundWidth * 3.0f/4.0f);
    
    CGPoint topPoint = CGPointMake(rect.size.width/2 - triangleHiegt/3 - 1, rect.size.height/2 - triangleHiegt/2);
    CGPoint bottomPoint = CGPointMake(rect.size.width/2 - triangleHiegt/3 - 1, rect.size.height/2 + triangleHiegt/2);
    CGPoint rightPoint = CGPointMake(rect.size.width/2 + triangleHiegt * 2.0f/3.0f, rect.size.height/2 );
    
    bezierPath = [UIBezierPath bezierPath];
    
    [bezierPath moveToPoint:topPoint];
    [bezierPath addLineToPoint:bottomPoint];
    [bezierPath addLineToPoint:rightPoint];
    bezierPath.lineWidth = 2;

    [bezierPath closePath];
    
    [bezierPath stroke];
}

@end
