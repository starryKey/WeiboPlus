//
//  CommentTableView.h
//  WeiboPlus
//
//  Created by wol on 15/9/19.
//  Copyright (c) 2015年 wol. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeiboView.h"
#import "WeiboModel.h"
#import "UserView.h"
#import "CommentCell.h"
@interface CommentTableView : UITableView<UITableViewDataSource,UITableViewDelegate>

{
    //用户视图
    UserView *_userView;
    //微博视图
    WeiboView *_weiboView;
    //头视图
    UIView *_theTableHeaderView;
}

@property(nonatomic,strong)NSArray *commentDataArray;
@property(nonatomic,strong)WeiboModel *weiboModel;
@property(nonatomic,strong)NSDictionary *commentDic;

@end
