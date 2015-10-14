//
//  ProfileViewController.m
//  WeiboPlus
//
//  Created by wol on 15/9/7.
//  Copyright (c) 2015年 wol. All rights reserved.
//

#import "ProfileViewController.h"
#import "DataService.h"
#import "SinaWeibo.h"
#import "AppDelegate.h"
#import "WeiboViewLayoutFrame.h"
#import "common.h"
@interface ProfileViewController ()
{
    NSArray *array;
}
@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _createView];
    [self _loadData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)_createView{
    _tableView = [[ProfileTableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_tableView];

}

- (SinaWeibo *)sinaWeibo{

    AppDelegate *delegate = (AppDelegate *)[UIApplication  sharedApplication].delegate;
    return delegate.sinaWeibo;
}

//必选	类型及范围	说明
//source	false	string	采用OAuth授权方式不需要此参数，其他授权方式为必填参数，数值为应用的AppKey。
//access_token	false	string	采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
//uid	false	int64	需要查询的用户ID。
//screen_name	false	string	需要查询的用户昵称。


- (void)_loadData{
    
    //设置请求内容
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    [params setObject:@"也许wol" forKey:@"screen_name"];
    
    [DataService requestAFUrl:@"users/show.json" httpMethod:@"GET" params:params data:nil block:^(id result) {
        UserModel *model = [[UserModel alloc]initWithDataDic:result];
        _tableView.userModel = model;
    }];
    [DataService requestAFUrl:@"statuses/user_timeline.json" httpMethod:@"GET" params:params data:nil block:^(id result) {
        //每一条微博存放在数组里
        NSArray *dicArray = [result objectForKey:@"statuses"];
        NSMutableArray *layoutFrameArray = [[NSMutableArray alloc]initWithCapacity:dicArray.count];
        
        //解析model,然后把model存放到dataArray,然后把dataArray 交给weiboTable;
        for (NSDictionary *dataDic in dicArray) {
            WeiboModel *model = [[WeiboModel alloc]initWithDataDic:dataDic];
            WeiboViewLayoutFrame *layoutFrame = [[WeiboViewLayoutFrame alloc]init];
            layoutFrame.weiboModel = model;
            
            [layoutFrameArray addObject:layoutFrame];
            NSLog(@"%ld",layoutFrameArray.count);
        }
        _tableView.layoutFrameArray = layoutFrameArray;
        [_tableView reloadData];
        
    }];

}


@end
