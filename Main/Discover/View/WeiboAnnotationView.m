//
//  WeiboAnnotationView.m
//  WeiboPlus
//
//  Created by wol on 15/9/23.
//  Copyright (c) 2015年 wol. All rights reserved.
//

#import "WeiboAnnotationView.h"
#import "WeiboAnnotation.h"
#import "UIImageView+WebCache.h"
@implementation WeiboAnnotationView

- (instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {
        
        self.bounds = CGRectMake(0, 0, 100, 40);
        [self _createViews];
        
    }
    return self;

}

- (void)_createViews{
    
    _headImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [self addSubview:_headImageView];
    
    
    
    
    
    _textLabel = [[UILabel alloc]initWithFrame:CGRectMake(40, 0, 60, 40)];
    _textLabel.backgroundColor = [UIColor lightGrayColor];
    _textLabel.textColor = [UIColor blackColor];
    _textLabel.font = [UIFont systemFontOfSize:13];
    _textLabel.numberOfLines = 3;
    [self addSubview:_textLabel];
    
}

- (void)layoutSubviews{
 
    [super layoutSubviews];
    WeiboAnnotation *annotation = self.annotation;
    WeiboModel *model = annotation.weiboModel;
    _textLabel.text = model.text;
    
    NSString *url = model.userModel.profile_image_url;
    [_headImageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"icon"]];
}


@end
