//
//  DismissSegue.m
//  YHPlayer
//
//  Created by Yonghao on 15/9/29.
//  Copyright © 2015年 Yonghao. All rights reserved.
//

#import "DismissSegue.h"

@implementation DismissSegue

- (void)perform {
    [self.sourceViewController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

@end
