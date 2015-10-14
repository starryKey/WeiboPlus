//
//  DetailViewController.h
//  WeiboPlus
//
//  Created by wol on 15/9/19.
//  Copyright (c) 2015年 wol. All rights reserved.
//

#import "BaseViewController.h"
#import "WeiboModel.h"
#import "SinaWeibo.h"
#import "CommentTableView.h"
@interface DetailViewController : BaseViewController<SinaWeiboRequestDelegate>
{
    CommentTableView *_tableView;

}
//评论微博的model
@property (nonatomic,strong) WeiboModel *weiboModel;
//微博评论列表的数据
@property (nonatomic,strong) NSMutableArray *data;

@end
