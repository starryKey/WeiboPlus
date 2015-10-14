//
//  ProfileTableView.h
//  WeiboPlus
//
//  Created by wol on 15/10/4.
//  Copyright (c) 2015年 wol. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeiboModel.h"
#import "MyCommentCell.h"
#import "MyMaterialView.h"
#import "WeiboViewLayoutFrame.h"
@interface ProfileTableView : UITableView<UITableViewDataSource,UITableViewDelegate>{

    UIView *_tableHeaderView;
    MyMaterialView  *_myMaterialView;
    
}

@property(nonatomic,strong)WeiboModel *weiboModel;
@property(nonatomic,strong)UserModel *userModel;
@property(nonatomic, strong)NSArray *layoutFrameArray;



@end
