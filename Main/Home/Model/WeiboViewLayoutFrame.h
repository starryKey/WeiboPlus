//
//  WeiboViewLayoutFrame.h
//  WeiboPlus
//
//  Created by wol on 15/9/13.
//  Copyright (c) 2015年 wol. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WeiboModel.h"

@interface WeiboViewLayoutFrame : NSObject
//结构体CGRect 用assign
@property(nonatomic,assign) CGRect textFrame; //微博文字
@property(nonatomic,assign) CGRect srTextFrame;//转发源微博文字
@property(nonatomic,assign) CGRect bgImageFrame;//微博背景
@property(nonatomic,assign) CGRect imgFrame;  //微博图片


@property(nonatomic,assign) CGRect frame;//整个微博view的frame

@property(nonatomic,strong) WeiboModel *weiboModel;//微博的model

@property(nonatomic,assign) BOOL isDetail;//是否是详情页面布局
@end
