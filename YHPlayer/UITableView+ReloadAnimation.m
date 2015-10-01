//
//  UITableView+ReloadAnimation.m
//  YHPlayer
//
//  Created by Yonghao on 15/10/1.
//  Copyright © 2015年 Yonghao. All rights reserved.
//

#import "UITableView+ReloadAnimation.h"

@implementation UITableView (ReloadAnimation)

- (void)reloadDataWithAnimationDirect:(TableViewReloadAnimationDirect)direction animationTime:(NSTimeInterval)animationTime interval:(NSTimeInterval)interval {
    
    [self setContentOffset:self.contentOffset animated:NO];
    [UIView animateWithDuration:0.2 animations:^{
        self.hidden = YES;
        [self reloadData];
    } completion:^(BOOL finished) {
        self.hidden = NO;
        [self visibleRowsBeginAnimationWithDirect:direction animationTime:animationTime interval:interval];
    }];
}

- (void)visibleRowsBeginAnimationWithDirect:(TableViewReloadAnimationDirect)direction animationTime:(NSTimeInterval)animationTime interval:(NSTimeInterval)interval {
    
    NSArray * visibleIndexPathArray = self.indexPathsForVisibleRows;
    NSInteger count = visibleIndexPathArray.count;
    
    switch (direction) {
        case DropDownFromTop:{
            
            for (NSInteger i = 0; i < count; i ++) {
                NSIndexPath * path = visibleIndexPathArray[count - 1 - i];
                UITableViewCell * cell = [self cellForRowAtIndexPath:path];
                cell.hidden = YES;
                CGPoint cellOriginCenter = cell.center;
                cell.center = CGPointMake(cellOriginCenter.x, cellOriginCenter.y - 1000);
                
                [UIView animateWithDuration:(animationTime + ((NSTimeInterval)i) * interval) delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                    
                    cell.hidden = NO;
                    cell.center = CGPointMake(cellOriginCenter.x, cellOriginCenter.y + 2.0);
                    
                } completion:^(BOOL finished) {
                    
                    [UIView animateWithDuration:0.1 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                        
                        cell.center = CGPointMake(cellOriginCenter.x, cellOriginCenter.y - 2.0);
                        
                    } completion:^(BOOL finished) {
                        
                        [UIView animateWithDuration:0.1 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                            
                            cell.center = CGPointMake(cellOriginCenter.x, cellOriginCenter.y);
                            
                        } completion:nil];
                    }];
                    
                }];
                
            }
            
        }
            break;
        case LiftUpFromBottum:{
            for (NSInteger i = 0; i < count; i ++) {
                NSIndexPath * path = visibleIndexPathArray[i];
                UITableViewCell * cell = [self cellForRowAtIndexPath:path];
                cell.hidden = YES;
                CGPoint cellOriginCenter = cell.center;
                cell.center = CGPointMake(cellOriginCenter.x, cellOriginCenter.y + 1000);
                
                [UIView animateWithDuration:(animationTime + ((NSTimeInterval)i) * interval) delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                    
                    cell.hidden = NO;
                    cell.center = CGPointMake(cellOriginCenter.x, cellOriginCenter.y - 2.0);
                    
                } completion:^(BOOL finished) {
                    
                    [UIView animateWithDuration:0.1 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                        
                        cell.center = CGPointMake(cellOriginCenter.x, cellOriginCenter.y + 2.0);
                        
                    } completion:^(BOOL finished) {
                        
                        [UIView animateWithDuration:0.1 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                            
                            cell.center = CGPointMake(cellOriginCenter.x, cellOriginCenter.y);
                            
                        } completion:nil];
                    }];
                    
                }];
                
            }
        }
            break;
        case FromLeftToRight:{
            
            for (NSInteger i = 0; i < count; i ++) {
                NSIndexPath * path = visibleIndexPathArray[i];
                UITableViewCell * cell = [self cellForRowAtIndexPath:path];
                cell.hidden = YES;
                
                CGPoint cellOriginCenter = cell.center;
                cell.center = CGPointMake(-cell.frame.size.width, cellOriginCenter.y);
               
                [UIView animateWithDuration:(animationTime + ((NSTimeInterval)i) * interval) delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                    
                    cell.hidden = NO;
                    cell.center = CGPointMake(cellOriginCenter.x + 2, cellOriginCenter.y);
                    
                } completion:^(BOOL finished) {
                    [UIView animateWithDuration:0.1 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                        
                        cell.center = CGPointMake(cellOriginCenter.x - 2, cellOriginCenter.y);
                        
                    } completion:^(BOOL finished) {
                        cell.center = CGPointMake(cellOriginCenter.x, cellOriginCenter.y);
                    }];
                }];
                
            }
        }
            break;
        case FromRightToLeft:{
            for (NSInteger i = 0; i < count; i ++) {
                NSIndexPath * path = visibleIndexPathArray[i];
                UITableViewCell * cell = [self cellForRowAtIndexPath:path];
                cell.hidden = YES;
                
                CGPoint cellOriginCenter = cell.center;
                cell.center = CGPointMake(cell.frame.size.width * 3, cellOriginCenter.y);
                
                [UIView animateWithDuration:(animationTime + ((NSTimeInterval)i) * interval) delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                    
                    cell.hidden = NO;
                    cell.center = CGPointMake(cellOriginCenter.x + 2, cellOriginCenter.y);
                    
                } completion:^(BOOL finished) {
                    [UIView animateWithDuration:0.1 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                        
                        cell.center = CGPointMake(cellOriginCenter.x - 2, cellOriginCenter.y);
                        
                    } completion:^(BOOL finished) {
                        cell.center = CGPointMake(cellOriginCenter.x, cellOriginCenter.y);
                    }];
                }];
                
            }
        }
            break;
        default:
            break;
    }
    
}


@end
