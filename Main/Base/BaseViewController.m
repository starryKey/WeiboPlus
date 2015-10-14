//
//  BaseViewController.m
//  WeiboPlus
//
//  Created by wol on 15/9/7.
//  Copyright (c) 2015年 wol. All rights reserved.
//

#import "BaseViewController.h"
#import "MMDrawerController.h"
#import "UIViewController+MMDrawerController.h"
#import "ThemeManager.h"
#import "UIProgressView+AFNetworking.h"
@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor clearColor];
    //[self setNavItem];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)setNavItem{

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"设置" style:UIBarButtonItemStylePlain target:self action:@selector(setAction)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(editAction)];
}

- (void)setAction{

    MMDrawerController *mmDraw = self.mm_drawerController;
    [mmDraw openDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
    
}

- (void)editAction{

    MMDrawerController *mmDraw = self.mm_drawerController;
    [mmDraw openDrawerSide:MMDrawerSideRight animated:YES completion:nil];

    
}

- (void)showLoading:(BOOL)show{

    if (_tipView == nil) {
        //创建
        _tipView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight/2-30, kScreenWidth, 20)];
        //_tipView.backgroundColor = [UIColor cyanColor];
        _tipView.backgroundColor = [UIColor clearColor];
        
        //01activity
        UIActivityIndicatorView *activity = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        activity.tag = 100;
        [_tipView addSubview:activity];
        
        //02label
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectZero];
        label.backgroundColor = [UIColor clearColor];
        label.text = @"正在加载";
        label.font = [UIFont systemFontOfSize:16];
        label.textColor = [UIColor blackColor];
        [label sizeToFit];//label的宽度根据文字调整
        [_tipView addSubview:label];
        
        label.left = (kScreenWidth - label.width)/2;
        activity.right = label.left-5;
        
    }
    if (show) {
        UIActivityIndicatorView *activity = [_tipView viewWithTag:100];
        [activity startAnimating];
        
        [self.view addSubview:_tipView];
    }
    else if(_tipView.superview){
        UIActivityIndicatorView *activity = [_tipView viewWithTag:100];
        [activity stopAnimating];

    
        [_tipView removeFromSuperview];
    }

}

- (void)showHUD:(NSString *)title{

    if (_hud == nil) {
        _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];

        _hud.labelText = title;
        //加载时灰色背景视图覆盖掉原来的视图
        _hud.dimBackground = YES;
       // _hud.detailsLabelText = @"测试正在加载";
        
    }
    [_hud show:YES];
}

- (void)hideDUD{

    [_hud hide:YES];
}
//加载完成后调用
- (void)completeHUD:(NSString *)title{

    _hud.customView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
    _hud.mode = MBProgressHUDModeCustomView;
    _hud.labelText = title;
    //持续1.5 秒隐藏
    [_hud hide:YES afterDelay:1.5];
    
}


#pragma -mark 设置背景图片
- (void)setBgImage{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_loadImage) name:kThemeDidChangeNotificationName object:nil];
    
    [self _loadImage];
}

- (void)_loadImage{
    
    ThemeManager *manager = [ThemeManager shareInstance];
    UIImage *img = [manager getThemeImage:@"bg_home.jpg"];
    self.view.backgroundColor = [UIColor colorWithPatternImage:img];
}

#pragma mark － 状态栏提示
- (void)showStatusTip:(NSString *)title show:(BOOL)show operation:(AFHTTPRequestOperation *)operation{

    if (_tipWindow == nil) {
        //01创建window才能显示在状态栏的上面
        _tipWindow = [[UIWindow alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 20)];
        _tipWindow.windowLevel = UIWindowLevelStatusBar;
        _tipWindow.backgroundColor = [UIColor blackColor];
    
        //02 显示文字
        UILabel *topLable = [[UILabel alloc]initWithFrame:_tipWindow.bounds];
        topLable.backgroundColor = [UIColor clearColor];
        topLable.textAlignment = NSTextAlignmentCenter;
        topLable.font = [UIFont systemFontOfSize:13];
        topLable.textColor = [UIColor whiteColor];
        topLable.tag = 100;
        [_tipWindow addSubview:topLable];
        
        //03创建进度条
        UIProgressView *progressView = [[UIProgressView alloc]initWithProgressViewStyle:UIProgressViewStyleDefault];
        progressView.frame = CGRectMake(0, 17, kScreenWidth, 5);
        progressView.tag = 101;
        progressView.progress = 0.0;
        [_tipWindow addSubview:progressView];
    }
    UILabel *topLabel = (UILabel *)[_tipWindow viewWithTag:100];
    topLabel.text = title;
    
    UIProgressView *progressView = (UIProgressView *)[_tipWindow viewWithTag:101];
    if (show) {
        _tipWindow.hidden = NO;
        
        if (operation != nil) {
            progressView.hidden = NO;
            [progressView setProgressWithUploadProgressOfOperation:operation animated:YES];
            
        } else {
        
            progressView.hidden = YES;
        }
        
        
    }else{
    
        [self performSelector:@selector(removeTipWindow) withObject:self afterDelay:0.5 ];
    }
    

}
- (void)removeTipWindow{

    _tipWindow.hidden = YES;
    _tipWindow = nil;
}

@end  















