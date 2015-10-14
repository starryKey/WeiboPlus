//
//  MainTabBarController.m
//  WeiboPlus
//
//  Created by wol on 15/9/7.
//  Copyright (c) 2015年 wol. All rights reserved.
//

#import "MainTabBarController.h"
//#import "common.h"
#import "BaseNaviController.h"
#import "ThemeButton.h"
#import "ThemeImageView.h"
#import "AppDelegate.h"
#import "SinaWeiboRequest.h"
#import "ThemeLabel.h"
@interface MainTabBarController ()<SinaWeiboRequestDelegate>
{
   
    ThemeImageView *_selectImageView;
    ThemeLabel *_bgLabel;
    ThemeImageView  *_bgImgView;

}
@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    //创建子视图控制器
    [self _createSubControllers];
    //设置tabBar
    [self _createTabBar];
    
    //开启定时器，请求unread_count接口，获取未读微博、新评论等的数量
    [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)_createTabBar{

    //修改TabBar的两种方法 1、先隐藏原有的TabBar，再在原来的位置上添加tabBarButton 2、不隐藏原有的，把原有的button移除，再在这基础上添加子视图
    //01.移除tabBarButton
    for (UIView *view  in self.tabBar.subviews) {
        Class cls = NSClassFromString(@"UITabBarButton");
        
        if ([view isKindOfClass:cls]) {
            [view removeFromSuperview];
        }
    }
    
    //02创建imageView 作为子视图 添加到tabBar 上
    ThemeImageView *bgImageView = [[ThemeImageView alloc]initWithFrame:CGRectMake(0, 0,kScreenWidth, 49)];
    
     //bgImageView.image = [UIImage imageNamed:@"Skins/cat/mask_navbar.png"];
    bgImageView.imgName = @"mask_navbar.png";
    [self.tabBar addSubview:bgImageView];
    
    //03选中图片
    
    _selectImageView = [[ThemeImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth / 4, 49)];
    
    //_selectImageView.image = [UIImage imageNamed:@"Skins/cat/home_bottom_tab_arrow.png"];
    
    _selectImageView.imgName = @"home_bottom_tab_arrow.png";
    [self.tabBar addSubview:_selectImageView];

  
     //04tabBar 标签 button
//    NSArray *imageNames = @[
//                            @"Skins/cat/home_tab_icon_1.png",
//                            @"Skins/cat/home_tab_icon_2.png",
//                            @"Skins/cat/home_tab_icon_3.png",
//                            @"Skins/cat/home_tab_icon_4.png",
//                            @"Skins/cat/home_tab_icon_5.png",
//                            ];
    
    
    NSArray *imageNames = @[
                            @"home_tab_icon_1.png",
                           // @"home_tab_icon_2.png",
                            @"home_tab_icon_3.png",
                            @"home_tab_icon_4.png",
                            @"home_tab_icon_5.png",
                            ];

    CGFloat itemWidth = kScreenWidth / imageNames.count;
    for (int i = 0; i < imageNames.count; i++) {
        
        ThemeButton *button = [[ThemeButton alloc]initWithFrame:CGRectMake(i * itemWidth, 0, itemWidth, 49)];
        
        //[button setBackgroundImage:[UIImage imageNamed:imageNames[i]] forState:UIControlStateNormal];
        button.normalImageName = imageNames[i];
        
        button.tag = i;
        [button addTarget:self action:@selector(_selectAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.tabBar addSubview:button];
    }


}


- (void)_selectAction:(UIButton *)button{
    
    [UIView animateWithDuration:0.3 animations:^{
        _selectImageView.center = button.center;
    }];
    self.selectedIndex = button.tag;
    
}


- (void)_createSubControllers{
    
    NSArray *names = @[@"Home",@"Profile",@"Discover",@"More"];
    
    NSMutableArray *navArray = [[NSMutableArray alloc]initWithCapacity:names.count];
    
    for (int i = 0 ; i < names.count ; i++) {
        NSString *name = names[i];
        //创建storyBoard对象
        UIStoryboard *storyBoard = [UIStoryboard  storyboardWithName:name bundle:nil];
        
        BaseNaviController *naviVC = [storyBoard instantiateInitialViewController];
        
        [navArray addObject:naviVC];
    }
    
    self.viewControllers = navArray;
    
    
    
}


- (void)timerAction{
    //请求数据
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    SinaWeibo *sinaWeibo = appDelegate.sinaWeibo;
    
    [sinaWeibo requestWithURL:unread params:nil httpMethod:@"GET" delegate:self];
    

}

- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result{

    //未读微博数量
    NSNumber *status = [result objectForKey:@"status"];
    NSInteger count = [status integerValue];
    
    CGFloat tabBarButtonWidth = kScreenWidth/4;
    if (_bgImgView == nil) {
        _bgImgView = [[ThemeImageView alloc]initWithFrame:CGRectMake(tabBarButtonWidth-32, 0, 32, 32)];
        _bgImgView.imgName = @"number_notify_9.png";
        [self.tabBar addSubview:_bgImgView];
        
        _bgLabel = [[ThemeLabel alloc]initWithFrame:_bgImgView.bounds];
        _bgLabel.textAlignment = NSTextAlignmentCenter;
        _bgLabel.backgroundColor = [UIColor clearColor];
        _bgLabel.font = [UIFont systemFontOfSize:13];
        _bgLabel.colorName  = @"Timeline_Notice_color";
        [_bgImgView  addSubview:_bgLabel];
        
    }
    if (count > 0) {
        _bgImgView.hidden = NO;
        if (count > 99) {
            count = 99;
        }
        _bgLabel.text = [NSString stringWithFormat:@"%li",count];
    }
    if (count == 0) {
        _bgImgView.hidden = YES;
       
    }

    
}

@end
