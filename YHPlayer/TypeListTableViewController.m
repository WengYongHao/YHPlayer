//
//  TypeListTableViewController.m
//  YHPlayer
//
//  Created by Yonghao on 15/9/30.
//  Copyright © 2015年 Yonghao. All rights reserved.
//

#import "TypeListTableViewController.h"
#import "VideoListViewController.h"

#import "PopPlayer.h"

#import "TypeTableViewCell.h"
#import "UITableView+ReloadAnimation.h"

@interface TypeListTableViewController ()

@property (copy, nonatomic) NSMutableArray * dataList;

@property (strong, nonatomic) YHPlayerCustomControl * player;

@end

@implementation TypeListTableViewController

- (void)awakeFromNib {
    [self initValues];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - init
- (void)initValues {
    [self.dataList addObjectsFromArray:@[
                                         @"home! OK~",
                                         @"play after downLoad",
                                         @"play during loading",
                                         @"video list!!!",
                                         @"pop here",
                                         ]];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _dataList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TypeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[TypeTableViewCell cellIdentifier] forIndexPath:indexPath];
    
    cell.titleLabel.text = _dataList[indexPath.section];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString * title = _dataList[indexPath.section];
    
    
    
    if ([title isEqualToString:@"pop here"]) {
        [self popOnWindow];
    }
    
    else {
        NSInteger tag = indexPath.section;
        
        
        UIStoryboard * storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        VideoListViewController * videoList = [storyBoard instantiateViewControllerWithIdentifier:@"VideoListView"];
        videoList.view.tag = tag;
        [self presentViewController:videoList animated:YES completion:nil];
    }
    
}


- (void)popOnWindow {
    
    PopPlayer * player = [[PopPlayer alloc] init];
    [player initPlayerViews];
    NSString * urlStr = @"https://devimages.apple.com.edgekey.net/samplecode/avfoundationMedia/AVFoundationQueuePlayer_Progressive.mov";
    NSURL * mediaURL = [NSURL URLWithString:urlStr];

    player.isPlayAfterFinishDownload = YES;
    player.inputUrl = mediaURL;
    player.coverImageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"bg_female.png" ofType:nil]];
    player.isTouchPause = YES;

    [player show:YES];
    
//    [window addSubview:player];
//    
//    [UIView animateWithDuration:.5f delay:0.0 usingSpringWithDamping:0.4 initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//        player.frame =  (CGRect){player.center, CGSizeMake(UISCREEN_WIDTH - 40, (9.0/16.0)*(UISCREEN_WIDTH - 40))};
//        player.center = CGPointMake(UISCREEN_WIDTH/2, UISCREEN_HEIGHT/2);
//    } completion:^(BOOL finished) {
//        [player play];
//    }];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


#pragma mark - getter

- (NSMutableArray *)dataList {
    if (_dataList == nil) {
        _dataList = [[NSMutableArray alloc] init];
    }
    return _dataList;
}

@end






