//
//  ThemeLabel.m
//  WeiboPlus
//
//  Created by wol on 15/9/10.
//  Copyright (c) 2015年 wol. All rights reserved.
//

#import "ThemeLabel.h"
#import "ThemeManager.h"
@implementation ThemeLabel


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
//若果从故事版里创建需要设置
- (void)awakeFromNib{

    [super awakeFromNib];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeDidChange:) name:kThemeDidChangeNotificationName object: nil];
}

- (void)themeDidChange:(NSNotification *)notification{
    
    [self loadColor];
}

- (void)setColorName:(NSString *)colorName{

    if (![_colorName isEqualToString:colorName]) {
        _colorName = [colorName copy];
        [self loadColor];
    }
}

- (void)loadColor{
    
    ThemeManager *manager = [ThemeManager shareInstance];
    
    self.textColor = [manager getThemeColor:self.colorName];
    
    
}


@end
