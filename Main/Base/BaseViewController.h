//
//  BaseViewController.h
//  WeiboPlus
//
//  Created by wol on 15/9/7.
//  Copyright (c) 2015年 wol. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "AFHTTPRequestOperation.h"
@interface BaseViewController : UIViewController
{
    UIView *_tipView;
    MBProgressHUD *_hud;
    
    UIWindow *_tipWindow;//在状态栏上显示微博发送进度
    
    
}
//系统提供加载显示
- (void)showLoading:(BOOL)show;

//第三方框架实现 MBProgress
- (void)showHUD:(NSString *)title;

- (void)hideDUD;

- (void)completeHUD:(NSString *)title;

//两个按钮 设置 和 编辑
- (void)setNavItem;

//设置背景图片
- (void)setBgImage;

//状态栏显示
- (void)showStatusTip:(NSString *)title show:(BOOL)show operation:(AFHTTPRequestOperation*)operation;


@end
