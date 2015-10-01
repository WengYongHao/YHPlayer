//
//  VideoListViewController.m
//  YHPlayer
//
//  Created by Yonghao on 15/10/1.
//  Copyright © 2015年 Yonghao. All rights reserved.
//

#import "VideoListViewController.h"

#import "UITableView+ReloadAnimation.h"

#import "VideoListCell.h"

#import "YHPlayerCustomControl.h"

@interface VideoListViewController ()
<
    UITableViewDataSource,
    UITableViewDelegate,
    YHPlayerProtocol
>

@property (weak, nonatomic) IBOutlet UITableView *mainTableView;

@property (strong, nonatomic) YHPlayerCustomControl * playingPlayer;

@end

@implementation VideoListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)viewDidAppear:(BOOL)animated {
    
    TableViewReloadAnimationDirect dir;
    switch (self.view.tag) {
        case 0:
            dir = DropDownFromTop;
            break;
        case 1:
            dir = LiftUpFromBottum;
            break;
            
        case 2:
            dir = FromLeftToRight;
            break;
        case 3:
            dir = FromRightToLeft;
            break;
        default:
            break;
    }

    
    [_mainTableView reloadDataWithAnimationDirect:dir animationTime:0.5 interval:0.05];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    VideoListCell * cell = [tableView dequeueReusableCellWithIdentifier:[VideoListCell cellIdentifier]];
    [cell.player pause];
    cell.player.delegate = self;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [VideoListCell cellHeight];
}

#pragma mark - yhplayer delegate
- (void)playerPrepareToPlay:(YHPlayerControl *)player {
    if (player != _playingPlayer) {
        [_playingPlayer resetTimeToZero];
    }
    
    
    _playingPlayer = (YHPlayerCustomControl *)player;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
