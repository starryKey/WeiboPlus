//
//  MoreViewController.m
//  WeiboPlus
//
//  Created by wol on 15/9/7.
//  Copyright (c) 2015年 wol. All rights reserved.
//

#import "MoreViewController.h"
#import "ThemeTableViewController.h"
#import "MoreTableViewCell.h"
#import "SinaWeibo.h"
#import "AppDelegate.h"

@interface MoreViewController ()

@end

@implementation MoreViewController{

    UITableView *_tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _createTableView];
    
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)viewWillAppear:(BOOL)animated{

    [_tableView reloadData];
}

- (void)_createTableView{

    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:_tableView];
    
    [_tableView registerClass:[MoreTableViewCell class] forCellReuseIdentifier:@"moreCell"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if (section == 0) {
        return 2;
    }
    return 1;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MoreTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"moreCell"];
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell. themeImageView.imgName = @"more_icon_theme.png";
            cell.themeTextLabel.text = @"主题选择";
            cell.themeDetailLabel.text = [ThemeManager shareInstance].themeName;
        }
        else if(indexPath.row == 1){
        
            cell.themeImageView.imgName = @"more_icon_account.png";
            cell.themeTextLabel.text = @"账户管理";
        }
    }
    else if (indexPath.section == 1){
    
        cell.themeTextLabel.text = @"意见反馈";
        cell.themeImageView.imgName = @"more_icon_feedback.png";
       // cell.themeTextLabel.center = cell.contentView.center;
    
    }
    else if(indexPath.section == 2){
    
        cell.themeTextLabel.text = @"登出当前帐户";
        cell.themeTextLabel.textAlignment = NSTextAlignmentCenter;
        cell.themeTextLabel.center = cell.contentView.center;
    }
    //设置箭头
    if (indexPath.section != 2) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    } else{
    
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //进入主题选择界面
    if (indexPath.section == 0 && indexPath.row == 0) {
        ThemeTableViewController *themeTableVC = [[ThemeTableViewController alloc]init];
        
        [self.navigationController pushViewController:themeTableVC animated:YES];
    }
    //登出
    if (indexPath.section == 2) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"确定登出吗？"message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
        
        [alert show];
    }

}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

    if ( buttonIndex == 1) {
        AppDelegate *appdelegate = (AppDelegate *)[UIApplication  sharedApplication].delegate;
        [appdelegate.sinaWeibo logOut];
        
    }

}














@end
