//
//  HomeViewController.m
//  WeiboPlus
//
//  Created by wol on 15/9/7.
//  Copyright (c) 2015年 wol. All rights reserved.
//

#import "HomeViewController.h"
#import "AppDelegate.h"
#import "ThemeManager.h"
#import "WeiboModel.h"
#import "WeiboTableView.h"
#import "WeiboViewLayoutFrame.h"
#import "MJRefresh.h"
#import "ThemeImageView.h"
#import "ThemeLabel.h"
//播放系统声音
#import <AudioToolbox/AudioToolbox.h>
@interface HomeViewController ()
{

    NSMutableArray *_data;
    WeiboTableView *_weiboTable;
    ThemeImageView *_barImgView;//弹出微博条数提示
    ThemeLabel *_barLabel;//条数label
    
}
@end

@implementation HomeViewController

  



//- (IBAction)themeChangeButton:(id)sender {
//    ThemeManager *manager = [ThemeManager shareInstance];
//    if ([manager.themeName isEqualToString:@"Blue Moon"]) {
//        manager.themeName = @"Dark Fairy" ;
//    }
//    else{
//    
//        manager.themeName = @"Blue Moon";
//    }
//}


- (void)viewDidLoad {
    [super viewDidLoad];
    _data = [[NSMutableArray alloc]init];
    
    [self setNavItem];
    
    [self _createTableView];
    [self _loadWeiboData];

    
    
   
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - tableView创建


- (void)_createTableView{
    
    _weiboTable = [[WeiboTableView alloc]initWithFrame:self.view.bounds];
    _weiboTable.backgroundColor =[UIColor clearColor];
    
    //_weiboTable.hidden = YES;
    //设置内容偏移
    // _weiboTable.contentInset = UIEdgeInsetsMake(64, 0, 49, 0);
    
    [self.view addSubview:_weiboTable];
    
    //上拉加载 ，下拉刷新
    _weiboTable.header = [MJRefreshNormalHeader  headerWithRefreshingTarget:self refreshingAction:@selector(_loadNewData)];
    
    _weiboTable.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(_loadMoreData)];
    
    
}


//拿到新浪微博对象
//- (IBAction)loginButton:(id)sender {

#pragma mark - 微博请求
- (void)_loadWeiboData{
    //[self showLoading:YES];
    [self showHUD:@"正在加载"];
    
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    //判断是否已经登陆
    if (appDelegate.sinaWeibo.isLoggedIn) {
        // 请求网络链接 获取用户微博
        
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
   [params setObject:@"10" forKey:@"count"];                                                      //home
    SinaWeiboRequest *request = [appDelegate.sinaWeibo requestWithURL:home_timeline//@"statuses/home_timeline.json"
                           params:params
                                 //[NSMutableDictionary dictionaryWithObject:appDelegate.sinaWeibo.userID forKey:@"uid"]
                       httpMethod:@"GET"
                         delegate:self];
        
        request.tag = 100;
        return;
    }
    [appDelegate.sinaWeibo logIn];
}

//- (IBAction)logoutButton:(id)sender {
//    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
//     [appDelegate.sinaWeibo logOut];
//}





#pragma mark - 上拉加载 下拉刷新
//上拉加载更多
- (void)_loadMoreData{

    //设置maxID
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    //判断是否已经登陆
    if (appDelegate.sinaWeibo.isLoggedIn) {
        
        //params处理
        NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
        [params setObject:@"10" forKey:@"count"];
        
        //设置maxID
        if (_data.count != 0) {
            WeiboViewLayoutFrame *layoutFrame = [_data lastObject];
            WeiboModel *model = layoutFrame.weiboModel;
            NSString *maxID = model.weiboIdStr;
            [params setObject:maxID forKey:@"max_id"];
        }

        // 请求网络链接 获取用户微博
        //home
    SinaWeiboRequest *request = [appDelegate.sinaWeibo requestWithURL:home_timeline//@"statuses/home_timeline.json"
                                       params:params
                                 //[NSMutableDictionary dictionaryWithObject:appDelegate.sinaWeibo.userID forKey:@"uid"]
                                   httpMethod:@"GET"
                                     delegate:self];
        
        request.tag = 101;
        return;
    }
    [appDelegate.sinaWeibo logIn];

    
    
}

//下拉刷新
- (void)_loadNewData{
    //设置sinceID

    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    //判断是否已经登陆
    if (appDelegate.sinaWeibo.isLoggedIn) {
        
        NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
        [params setObject:@"10" forKey:@"count"];
        
        //设置sinceID
        if (_data.count != 0) {
            WeiboViewLayoutFrame *layoutFrame = _data[0];
            WeiboModel *model = layoutFrame.weiboModel;
            NSString *sinceID = model.weiboIdStr;
            [params setObject:sinceID forKey:@"since_id"];
        }
       // 请求网络链接 获取用户微博
        
        //home
        SinaWeiboRequest *request = [appDelegate.sinaWeibo requestWithURL:home_timeline//@"statuses/home_timeline.json"
                                                                   params:params//[NSMutableDictionary dictionaryWithObject:appDelegate.sinaWeibo.userID forKey:@"uid"]
                                                               httpMethod:@"GET"
                                                                 delegate:self];
        
        request.tag = 102;
        return;
    }
    [appDelegate.sinaWeibo logIn];
    

    
}




#pragma mark - 网络请求
//- (void)request:(SinaWeiboRequest *)request didReceiveResponse:(NSURLResponse *)response{
//
//}
//- (void)request:(SinaWeiboRequest *)request didReceiveRawData:(NSData *)data{
//}
//- (void)request:(SinaWeiboRequest *)request didFailWithError:(NSError *)error{
//}
- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result{
    //是返回已经完成json解析的数据
//    NSLog(@"接收完成%@",result);
//    NSArray *dicArray = [result objectForKey:@"statues"];
//    NSDictionary *weiboDic =  dicArray[0];
//    NSLog(@"字典 %@",weiboDic);
//    WeiboModel *model = [[WeiboModel alloc]initWithDataDic: weiboDic];
    
    _weiboTable.hidden = NO;
    NSArray *dicArray = [result objectForKey:@"statuses"];
    
    //NSMutableArray *dataArray = [[NSMutableArray  alloc]initWithCapacity:dicArray.count];
    
    NSMutableArray *layoutFrameArray = [[NSMutableArray  alloc]initWithCapacity:dicArray.count];
    //解析model，然后把model存放到DataArray,然后再把dataarray 交给weibotable;
    for (NSDictionary *dic in dicArray) {
        WeiboModel *model = [[WeiboModel alloc]initWithDataDic:dic];
        WeiboViewLayoutFrame *layoutFrame = [[WeiboViewLayoutFrame alloc]init];
        layoutFrame.weiboModel = model;
        
        [layoutFrameArray addObject:layoutFrame];
    }
    
    if (request.tag == 100) {//普通加载微博
       // [self showLoading:NO];
        
       // [self hideDUD];
        [self completeHUD:@"加载完成"];
        _data = layoutFrameArray;
        
    }else if(request.tag == 101){//更多微博
        if (layoutFrameArray.count > 1) {
            [layoutFrameArray removeObjectAtIndex:0];
            [_data addObjectsFromArray:layoutFrameArray];
        }
    
    }else if(request.tag == 102){//加载新微博
        if (layoutFrameArray.count > 0) {
            
            NSRange range = NSMakeRange(0, layoutFrameArray.count);
            NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:range];
            [_data insertObjects:layoutFrameArray atIndexes:indexSet];
            [self showNewWeiboCount:layoutFrameArray.count];
            NSLog(@"更新微博的条数%li",layoutFrameArray.count);

            
        }
    
    }
    
    if (_data.count != 0) {
        _weiboTable.layoutFrameArray = _data;
        [_weiboTable reloadData];
    }
    
    [_weiboTable.header endRefreshing];
    [_weiboTable.footer endRefreshing];
    
    
}


- (void)showNewWeiboCount:(NSInteger )count{

    if ( _barImgView == nil) {
        _barImgView = [[ThemeImageView alloc]initWithFrame:CGRectMake(5, -40, kScreenWidth-10, 40)];
        _barImgView.imgName = @"timeline_notify.png";
        [self.view addSubview:_barImgView];
        
        _barLabel = [[ThemeLabel alloc]initWithFrame:_barImgView.bounds];
        _barLabel.colorName = @"Timeline_Notice_color";
        _barLabel.backgroundColor = [UIColor clearColor];
        _barLabel.textAlignment = NSTextAlignmentCenter;//居中显示
        [_barImgView addSubview:_barLabel];
        
    }
    if (count > 0) {
        _barLabel.text = [NSString stringWithFormat:@"更新了%li条微博",count];
        [UIView animateWithDuration:.6 animations:^{
            _barImgView.transform = CGAffineTransformMakeTranslation(0, 64+5+40);
        } completion:^(BOOL finished) {
            _barImgView.transform = CGAffineTransformIdentity;
            [UIView animateWithDuration:.6 animations:^{
                [UIView setAnimationDelay:1];//让提示消息停留一秒
                _barImgView.transform = CGAffineTransformIdentity;
            }];
        }];
     
        //实现播放声音
        NSString *path = [[NSBundle mainBundle] pathForResource:@"msgcome" ofType:@"wav"];
      
        NSURL *url = [NSURL fileURLWithPath:path];
        //文件很小时，注册为系统声音
        
        SystemSoundID soundID;
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)url, &soundID);//桥接,从oc的对象转化为c的基层东西
        AudioServicesPlaySystemSound(soundID);
        
    }
    
    
}

@end





















