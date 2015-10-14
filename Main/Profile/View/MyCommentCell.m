//
//  MyCommentCell.m
//  WeiboPlus
//
//  Created by wol on 15/10/4.
//  Copyright (c) 2015年 wol. All rights reserved.
//

#import "MyCommentCell.h"
#import "WeiboModel.h"
#import "UIImageView+WebCache.h"
#import "Utils.h"

@implementation MyCommentCell

- (void)awakeFromNib {
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.weiboView = [[WeiboView alloc]initWithFrame:CGRectZero];
    //背景颜色去掉
    self.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:self.weiboView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

   
}

- (void)setLayoutFrame:(WeiboViewLayoutFrame *)layoutFrame{

    if (_layoutFrame != layoutFrame) {
        _layoutFrame = layoutFrame;
        [self setNeedsDisplay];
    }
}

- (void)layoutSubviews{

    [super layoutSubviews];
    WeiboModel *weiboModel = self.layoutFrame.weiboModel;
    
    //头像图片
    NSString *urlStr = weiboModel.userModel.avatar_large;
    [_headImageView sd_setImageWithURL:[NSURL URLWithString:urlStr]];
    //用户昵称
    self.userNameLabel.text = weiboModel.userModel.name;
    //转发数
    self.repostCountLabel.text = [NSString stringWithFormat:@"转发:%@",weiboModel.repostsCount];
    //评论数
    self.commentCountLabel.text = [NSString stringWithFormat:@"评论:%@",weiboModel.commentsCount];
    
    _weiboView.layoutFrame = _layoutFrame;
    self.weiboView.frame = self.layoutFrame.frame;
    
    //微博来源
    _sourceLabel.text = weiboModel.source;
    
}

@end
