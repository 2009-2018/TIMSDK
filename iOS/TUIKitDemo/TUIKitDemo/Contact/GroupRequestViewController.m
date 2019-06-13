//
//  GroupRequestViewController.m
//  TUIKitDemo
//
//  Created by annidyfeng on 2019/5/20.
//  Copyright © 2019年 Tencent. All rights reserved.
//

#import "GroupRequestViewController.h"
#import "TIMUserProfile+DataProvider.h"
#import "Toast/Toast.h"
#import <ReactiveObjC.h>
#import "MMLayout/UIView+MMLayout.h"
#import "TIMUserProfile+DataProvider.h"
#import "TUIProfileCardCell.h"
#import "THeader.h"
#import "UIImage+TUIKIT.h"
#import "TUIKit.h"

@interface GroupRequestViewController ()<UITableViewDataSource, UITableViewDelegate>
@property UITableView *tableView;
@property UITextView  *addMsgTextView;
@property TUIProfileCardCellData *cardCellData;
@end

@implementation GroupRequestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [self.view addSubview:self.tableView];
    self.tableView.mm_fill();
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.addMsgTextView = [[UITextView alloc] initWithFrame:CGRectZero];
    self.addMsgTextView.font = [UIFont systemFontOfSize:14];
    [[TIMFriendshipManager sharedInstance] getSelfProfile:^(TIMUserProfile *profile) {
        self.addMsgTextView.text = [NSString stringWithFormat:@"%@ 申请加入群聊", [profile showName]];
    } fail:^(int code, NSString *msg) {
        
    }];
    
    TUIProfileCardCellData *data = [TUIProfileCardCellData new];
    data.name = self.groupInfo.groupName;
    data.identifier = self.groupInfo.group;
    data.avatarImage = DefaultGroupAvatarImage;
    self.cardCellData = data;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStylePlain target:self action:@selector(onSend)];
    self.title = @"添加群组";
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    if (indexPath.section == 0) {
        return [self.cardCellData heightOfWidth:Screen_Width];
    }
    if (indexPath.section == 1) {
        return 120;
    }
    if (indexPath.section == 2) {
        return 44;
    }
    return 0.;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return 2;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 1)
        return @"填写验证信息";
    return nil;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        TUIProfileCardCell *cell = [[TUIProfileCardCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TPersonalCommonCell_ReuseId"];
        [cell fillWithData:self.cardCellData];
        return cell;
    }
    if (indexPath.section == 1) {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AddWord"];
        [cell.contentView addSubview:self.addMsgTextView];
        self.addMsgTextView.mm_width(Screen_Width).mm_height(120);
        return cell;
    }
    
    return nil;
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

- (void)onSend
{
    // display toast with an activity spinner
    [self.view makeToastActivity:CSToastPositionCenter];
    
    [[TIMGroupManager sharedInstance] joinGroup:self.groupInfo.group
                                            msg:self.addMsgTextView.text
                                           succ:^{
                                               [self.view hideToastActivity];
                                               [self.view makeToast:@"发送成功"
                                                           duration:3.0
                                                           position:CSToastPositionBottom];
    } fail:^(int code, NSString *msg) {
        [self.view hideToastActivity];
        [self.view makeToast:msg
                    duration:3.0
                    position:CSToastPositionBottom];
    }];
}
@end