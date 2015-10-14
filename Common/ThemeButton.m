//
//  ThemeButton.m
//  WeiboPlus
//
//  Created by wol on 15/9/9.
//  Copyright (c) 2015年 wol. All rights reserved.
//

#import "ThemeButton.h"
#import "ThemeManager.h"
@implementation ThemeButton

- (void)dealloc{

    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //监听通知
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(themeDidChange:) name: kThemeDidChangeNotificationName object:nil];
        
    }
    return  self;
}

//设置图片名字，获得图片 重写两个方法
- (void)setNormalImageName:(NSString *)normalImageName{

    if (![_normalImageName isEqualToString:normalImageName]) {
        _normalImageName = [normalImageName copy];
        [self loadImage];
    }

}

- (void)setHighLightedImageName:(NSString *)highLightedImageName{

    if (![_highLightedImageName isEqualToString:highLightedImageName]) {
        _highLightedImageName = highLightedImageName;
        [self loadImage];
        
    }

}

- (void)themeDidChange:(NSNotification *)notification{

    //重新加载图片
    [self loadImage];
    

}

- (void)loadImage{

    //01根据图片名字得到，获取主题管家对象 通过单例
    ThemeManager *themeManager = [ThemeManager shareInstance];
    
    //02通过管家对象得到图片
    UIImage *normalImage = [themeManager  getThemeImage:self.normalImageName];
    UIImage *highLightImage = [themeManager getThemeImage:self.highLightedImageName];
    
    if ( normalImage != nil) {
        [self setImage:normalImage forState:UIControlStateNormal];
    }
    if (highLightImage != nil) {
        [self setImage:highLightImage forState:UIControlStateHighlighted];
    }

}













@end
