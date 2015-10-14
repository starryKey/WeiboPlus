//
//  WeiboCell.m
//  WeiboPlus
//
//  Created by wol on 15/9/13.
//  Copyright (c) 2015年 wol. All rights reserved.
//

#import "WeiboCell.h"
#import "UIImageView+WebCache.h"
@implementation WeiboCell

- (void)awakeFromNib {
    //创建微博内容view 添加
    //设置选中格式
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.backgroundColor = [UIColor clearColor];
    _weiboView = [[WeiboView alloc]initWithFrame:CGRectZero];
    _weiboView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_weiboView];
  
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

//- (void)setModel:(WeiboModel *)model{
//
//    if (_model != model) {
//        _model = model;
//        [self setNeedsLayout];
//    }
//}

- (void)setLayoutFrame:(WeiboViewLayoutFrame *)layoutFrame{

    if (_layoutFrame != layoutFrame) {
        _layoutFrame = layoutFrame;
        [self  setNeedsLayout];
    }
    

}
//重新布局子视图
- (void)layoutSubviews{
    [super layoutSubviews];

    //00获取model
    WeiboModel *_model = _layoutFrame.weiboModel;
    
    //01用户头像
    NSString *urlStr = _model.userModel.profile_image_url;
    [_headImageView sd_setImageWithURL:[NSURL URLWithString:urlStr]];
    
    //02用户昵称
    _nickNameLabel.text = _model.userModel.screen_name;
    
    //03评论数，转发数
    _rePostLabel.text = [NSString stringWithFormat:@"转发:%@",_model.repostsCount];
    _commentLabel.text = [NSString stringWithFormat:@"评论:%@",_model.commentsCount];
    
    //04微博来源
    _srLabel.text = _model.source;
    
    //05微博内容设置
    _weiboView.layoutFrame = _layoutFrame;
#warning 微博详情:整个weiboView的x,y 设置
    _weiboView.frame = _layoutFrame.frame;

}

@end
