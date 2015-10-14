//
//  WeiboView.m
//  WeiboPlus
//
//  Created by wol on 15/9/13.
//  Copyright (c) 2015年 wol. All rights reserved.
//

#import "WeiboView.h"
#import "UIImageView+WebCache.h"

@implementation WeiboView
//xib创建
//- (instancetype)initWithCoder:(NSCoder *)aDecoder{
//}

- (void)dealloc{

    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

//alloc创建
- (instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {
        [self _createSubviews];
    }

    return self;
}

- (void)setLayoutFrame:(WeiboViewLayoutFrame *)layoutFrame{

    if (_layoutFrame != layoutFrame) {
        _layoutFrame = layoutFrame;
        [self setNeedsLayout];
    }

}

- (void)_createSubviews{
    
    _textLabel.backgroundColor = [UIColor redColor];
    _sourceLabel.backgroundColor = [UIColor yellowColor];

    

    //1.微博内容
    _textLabel  = [[WXLabel alloc]initWithFrame:CGRectZero];
    _textLabel.wxLabelDelegate = self;
    _textLabel.linespace = 5;
    _textLabel.font = [UIFont systemFontOfSize:15];
    
    _textLabel.textColor = [[ThemeManager shareInstance] getThemeColor:@"Timeline_Content_color"];
   

    [self addSubview:_textLabel];
    
    //2.原微博内容
    _sourceLabel = [[WXLabel alloc]initWithFrame:CGRectZero];
    _sourceLabel.linespace = 5;
    _sourceLabel.wxLabelDelegate = self;
    _sourceLabel.font = [UIFont systemFontOfSize:14];
     _sourceLabel.textColor = [[ThemeManager shareInstance] getThemeColor:@"Timeline_Content_color"];
    
    [self addSubview:_sourceLabel];
    
    //3.微博图片
    _imgView = [[ZoomImageView alloc]initWithFrame:CGRectZero];
    [self addSubview:_imgView];
    
    //4.背景图片
    _bgImageView = [[ThemeImageView alloc]initWithFrame:CGRectZero];
    
    _bgImageView.leftCapWidth = 30;
    _bgImageView.topCapWidth = 30;
    _bgImageView.imgName = @"timeline_rt_border_9.png";
    //主题添加至最底层
    [self insertSubview:_bgImageView atIndex:0];
    //[self addSubview:_bgImageView ];
    
    //5 监听通知
   [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeDidNotification:) name: kThemeDidChangeNotificationName object:nil];

}

- (void)layoutSubviews{
    
    _textLabel.font =   [UIFont systemFontOfSize: FontSize_Weibo(_layoutFrame.isDetail)] ;
    _sourceLabel.font =  [UIFont systemFontOfSize: FontSize_ReWeibo(_layoutFrame.isDetail)] ;

    WeiboModel *weiboModel = _layoutFrame.weiboModel;
#pragma 微博详情 -- 整个frame的x，y可能需要在外面设置,这里注释掉
    //设置整个weiboview的frame
   // self.frame = _layoutFrame.frame;
    
    _textLabel.frame = _layoutFrame.textFrame;
    _textLabel.text = weiboModel.text;
   
   // _sourceLabel.text = weiboModel.reWeiBoModel.text;
      //是否转发
    if (weiboModel.reWeiBoModel != nil) {
        _bgImageView.hidden = NO;
        _sourceLabel.hidden = NO;
        
        //背景图片frame
        _bgImageView.frame = _layoutFrame.bgImageFrame;
        
        //原微博内容以及frame
         _sourceLabel.frame = _layoutFrame.srTextFrame;
         _sourceLabel.text = weiboModel.reWeiBoModel.text;
        
        //图片显示
        NSString *imgUrl = weiboModel.reWeiBoModel.thumbnailImage;
        
        if (imgUrl != nil) {
            _imgView.hidden = NO;
            _imgView.frame = _layoutFrame.imgFrame;
            [_imgView sd_setImageWithURL:[NSURL URLWithString:imgUrl]];
            
            //大图链接
            _imgView.fullImageUrl = weiboModel.reWeiBoModel.originalImage;
            
            
        } else{
        
            _imgView.hidden = YES;
        }
       
        
        
    }else{//非转发
    
        //隐藏不需要的view
        _bgImageView.hidden = YES;
        _sourceLabel.hidden = YES;
        
        
        
        //图片显示
        NSString *imgUrl = weiboModel.thumbnailImage;
        
        if (imgUrl != nil) {
            _imgView.hidden = NO;
            _imgView.frame = _layoutFrame.imgFrame;
            [_imgView sd_setImageWithURL:[NSURL URLWithString:imgUrl]];
            
            //加载网络大图
            _imgView.fullImageUrl = weiboModel.originalImage;
            
        } else{//如果没有图片
            
            _imgView.hidden = YES;
        }
    }
    
    //判断gif图片
    if (_imgView.hidden == NO) {
        
        NSString *extension;
        
        UIImageView *iconImgView = _imgView.iconImageView;
        iconImgView.frame = CGRectMake(_imgView.width-24, _imgView.height-15, 24, 14);

        if (weiboModel.reWeiBoModel != nil) {
            extension = [weiboModel.reWeiBoModel.thumbnailImage pathExtension];//12.gif
          
            
        }else {
            extension = [weiboModel.thumbnailImage pathExtension];
        
        }
        if ([extension isEqualToString:@"gif"]) {
            iconImgView.hidden = NO;
            _imgView.isGif = YES;
        }
        else {
            iconImgView.hidden = YES;
            _imgView.isGif = NO;
        
        }
        
        
        
    }
    
    
}

#pragma mark - wxlabel代理方法

- (NSString *)contentsOfRegexStringWithWXLabel:(WXLabel *)wxLabel {
 //需要添加链接字符串的正则表达式：@用户、http://、#话题#
 //＋表示重复一次或者多次
     NSString *regex1 = @"@\\w+";
 
     NSString *regex2 = @"http(s)?://([A-Za-z0-9._-]+(/)?)*";
     NSString *regex3 = @"#\\w+#";
     NSString *regex = [NSString stringWithFormat:@"(%@)|(%@)|(%@)",regex1,regex2,regex3];
     return regex;
}

//设置当前链接文本的颜色
- (UIColor *)linkColorWithWXLabel:(WXLabel *)wxLabel{

    return [[ThemeManager shareInstance] getThemeColor:@"Link_color"];

}
//设置当前文本手指经过的颜色
- (UIColor *)passColorWithWXLabel:(WXLabel *)wxLabel{

    return [UIColor blueColor];
    

}


#pragma mark - 主题切换通知
- (void)themeDidNotification:(NSNotification *)notification{

    _textLabel.textColor = [[ThemeManager shareInstance] getThemeColor:@"Timeline_Content_color"];
    _sourceLabel.textColor = [[ThemeManager shareInstance] getThemeColor:@"Timeline_Content_color"];

}


@end

