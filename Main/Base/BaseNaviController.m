//
//  BaseNaviController.m
//  WeiboPlus
//
//  Created by wol on 15/9/7.
//  Copyright (c) 2015年 wol. All rights reserved.
//

#import "BaseNaviController.h"
#import "ThemeManager.h"

@interface BaseNaviController ()

@end

@implementation BaseNaviController

- (void)dealloc{

    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

//当xib创建出来的时候调用该init方法
- (instancetype)initWithCoder:(NSCoder *)aDecoder{

    self = [super initWithCoder:aDecoder];
    if (self) {
       //注册通知监听者
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeDidChange:) name:kThemeDidChangeNotificationName object:nil];
        
    }
    return self;
}

- (void)themeDidChange:(NSNotification *)notification{

    [self loadImage];
}

- (void)loadImage{

    //01得到主题管家对象
    ThemeManager *manager = [ThemeManager shareInstance];
    //修改导航栏背景
    UIImage *image = [manager getThemeImage:@"mask_titlebar64.png"];
    
    [self.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    //02修改主题文字颜色
    UIColor *color = [manager getThemeColor:@"Mask_Title_color"];
    
    NSDictionary *attrDic = @{NSForegroundColorAttributeName:color};
    
    self.navigationBar.titleTextAttributes = attrDic;
   
    //03修改视图背景  将背景图片转化为颜色
    
    UIImage *bgImage = [manager getThemeImage:@"bg_home.jpg"];
    self.view.backgroundColor = [UIColor colorWithPatternImage:bgImage];
    
    //04 设置导航栏按钮卫文字颜色
    self.navigationBar.tintColor = color;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadImage];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
