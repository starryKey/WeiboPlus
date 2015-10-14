//
//  RightViewController.m
//  WeiboPlus
//
//  Created by wol on 15/9/10.
//  Copyright (c) 2015年 wol. All rights reserved.
//

#import "RightViewController.h"
#import "ThemeButton.h"
#import "BaseNaviController.h"
#import "ThemeManager.h"
#import "MMDrawerController.h"
#import "UIViewController+MMDrawerController.h"
#import "BaseViewController.h"
#import "SendViewController.h"
#import "LocationViewController.h"

@interface RightViewController ()

@end

@implementation RightViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    [self setBgImage];
    
    
    // 图片的数组
    NSArray *imageNames = @[@"newbar_icon_1.png",
                            @"newbar_icon_2.png",
                            @"newbar_icon_3.png",
                            @"newbar_icon_4.png",
                            @"newbar_icon_5.png"];
    
    //创建主题按钮
    for (int i = 0 ; i < imageNames.count; i++) {
        ThemeButton *button = [[ThemeButton alloc]initWithFrame:CGRectMake(20, 64 + i * (50), 40, 40)];
        button.normalImageName = imageNames[i];
        button.tag = i;
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
    
    
    
}

- (void)buttonAction:(UIButton *)button{

    if (button .tag ==0) {
        //发送微博
        NSLog(@"发送微博");
        [self.mm_drawerController toggleDrawerSide:MMDrawerSideRight animated:YES completion:^(BOOL finished) {
            //弹出发送微博控制器
            SendViewController *sendVC = [[SendViewController alloc]init];
             sendVC.title = @"发送微博";
            
            //创建导航栏控制器
            BaseNaviController *baseNav = [[BaseNaviController alloc]initWithRootViewController:sendVC];
            [self.mm_drawerController presentViewController:baseNav animated:YES completion:nil];
            
        }];
    }
    
    if (button.tag == 4) {
        [self.mm_drawerController toggleDrawerSide:MMDrawerSideRight animated:YES completion:^(BOOL finished) {
        
        LocationViewController *locationVC = [[LocationViewController alloc]init];
        locationVC.title = @"附近商圈";
        //创建导航栏控制器
        BaseNaviController *baseNav = [[BaseNaviController alloc]initWithRootViewController:locationVC];
        [self.mm_drawerController presentViewController:baseNav animated:YES completion:nil];

          }];
    }

    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
