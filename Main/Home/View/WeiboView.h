//
//  WeiboView.h
//  WeiboPlus
//
//  Created by wol on 15/9/13.
//  Copyright (c) 2015年 wol. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ThemeImageView.h"
#import "WeiboViewLayoutFrame.h"
#import "WXLabel.h"
#import "ThemeManager.h"
#import "ZoomImageView.h"
@interface WeiboView : UIView<WXLabelDelegate>

@property (nonatomic, strong)WXLabel *textLabel;//微博文字
@property (nonatomic, strong)WXLabel *sourceLabel;// 若转发原微博文字

@property (nonatomic, strong)ZoomImageView  *imgView;//微博图片
@property(nonatomic,strong)ThemeImageView *bgImageView; //原微博背景图片

@property (strong,nonatomic) WeiboViewLayoutFrame *layoutFrame;

@end
