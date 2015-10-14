//
//  ThemeImageView.m
//  WeiboPlus
//
//  Created by wol on 15/9/9.
//  Copyright (c) 2015年 wol. All rights reserved.
//

#import "ThemeImageView.h"
#import "ThemeManager.h"
@implementation ThemeImageView
- (void)dealloc{

    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {
        //监听通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeDidChange:) name:kThemeDidChangeNotificationName object: nil];
    }
    return self;

}

- (void)themeDidChange:(NSNotification *)notification{

    [self loadImage];
}

- (void)setImgName:(NSString *)imgName{

    if (![_imgName isEqualToString:imgName]) {
        _imgName = [imgName copy];
        
        [self loadImage];
        
    }
}

- (void)loadImage{

    ThemeManager *manager = [ThemeManager shareInstance];
    
    UIImage *image = [manager getThemeImage:self.imgName];
    //拉伸背景图片
    UIImage *tempImage = [image stretchableImageWithLeftCapWidth:_leftCapWidth topCapHeight:_topCapWidth];
    
    
    
    
    if (image != nil) {
        self.image = tempImage;
    }
    
    
}

@end
