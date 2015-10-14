//
//  MyCommentCell.h
//  WeiboPlus
//
//  Created by wol on 15/10/4.
//  Copyright (c) 2015年 wol. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeiboModel.h"
#import "WeiboViewLayoutFrame.h"
#import "WeiboView.h"
#import "ThemeLabel.h"
@interface MyCommentCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *headImageView;

@property (weak, nonatomic) IBOutlet ThemeLabel *userNameLabel;
@property (weak, nonatomic) IBOutlet ThemeLabel *commentCountLabel;
@property (weak, nonatomic) IBOutlet ThemeLabel *repostCountLabel;

@property (weak, nonatomic) IBOutlet ThemeLabel *sourceLabel;

@property (nonatomic, strong) WeiboView *weiboView;
@property (nonatomic, strong) WeiboViewLayoutFrame *layoutFrame;

@end
