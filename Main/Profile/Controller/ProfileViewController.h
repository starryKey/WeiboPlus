//
//  ProfileViewController.h
//  WeiboPlus
//
//  Created by wol on 15/9/7.
//  Copyright (c) 2015年 wol. All rights reserved.
//

#import "BaseViewController.h"
#import "WeiboModel.h"
#import "SinaWeiboRequest.h"
#import "UserModel.h"
#import "ProfileTableView.h"
@interface ProfileViewController : BaseViewController<SinaWeiboRequestDelegate>

@property (nonatomic, strong) WeiboModel *weiboMoael;
@property (nonatomic, strong)UserModel *userModel;
@property (nonatomic, strong)ProfileTableView *tableView;

@end
