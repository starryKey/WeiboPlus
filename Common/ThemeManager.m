//
//  ThemeManager.m
//  WeiboPlus
//
//  Created by wol on 15/9/8.
//  Copyright (c) 2015年 wol. All rights reserved.
//

#import "ThemeManager.h"

@implementation ThemeManager

+ (ThemeManager *)shareInstance{

    static ThemeManager *instance = nil;
    
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        //只执行一次
        instance = [[[self class] alloc]init];
    });
    
    return instance;
    
}

// instancetype 和 id 的区别 ：instancetype 返回的永远是当前类的对象
- (instancetype)init{

    self = [super init];
    if (self) {
        //01默认是Cat
        //_themeName = @"Cat";
        
        
        //02 读取本地持久化存储的主题名字
        _themeName = [[NSUserDefaults standardUserDefaults] objectForKey:kThemeName];
        if (_themeName.length == 0) {
             _themeName = @"Cat";//如果本地没有存储名字，则默认Cat;
        }
        
        
        
        
        //03_themeName = @"Dark Fairy";
        //读取 主题名 ——》主题路径， 配置文件 放到字典里面
        NSString *configPath = [[NSBundle mainBundle] pathForResource:@"theme" ofType:@"plist"];
        self.themeConfig = [NSDictionary dictionaryWithContentsOfFile:configPath];
        
        
        //03读取颜色配置
        NSString *themePath = [self themePath];
        NSString *filePath = [themePath stringByAppendingPathComponent:@"config.plist"];
        self.colorConfig = [NSDictionary dictionaryWithContentsOfFile:filePath];
        
        
    }
    return self;
}

//主题切换 设置主题名 触发通知
- (void)setThemeName:(NSString *)themeName{

    if (![_themeName isEqualToString:themeName]) {
        _themeName = [themeName copy];
        
        
        //01把主题名字存储到plist中NSUserDefaults
        
        [[NSUserDefaults standardUserDefaults] setObject:_themeName forKey:kThemeName];
        [[NSUserDefaults standardUserDefaults] synchronize];//存到本地
        
        
        
        //02重新读取颜色配置文件
        NSString *themePath = [self themePath];
        NSString *filePath = [themePath stringByAppendingPathComponent:@"config.plist"];
        self.colorConfig = [NSDictionary dictionaryWithContentsOfFile:filePath];
        
        
        
        //03发通知
        [[NSNotificationCenter defaultCenter] postNotificationName:kThemeDidChangeNotificationName object:nil];
    }
    
    
}
- (UIColor *)getThemeColor:(NSString *)colorName{

    if (colorName.length == 0) {
        return nil;
    }
    NSDictionary *rgbDic = [_colorConfig objectForKey:colorName];
    CGFloat r = [rgbDic[@"R"] floatValue];
    CGFloat g = [rgbDic[@"G"] floatValue];
    CGFloat b = [rgbDic[@"B"] floatValue];
    
    
    CGFloat alpha = 1;
    if (rgbDic[@"alpha"]!= nil) {
        alpha = [ rgbDic[@"alpha"] floatValue];
    }
    
    UIColor *color = [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:alpha];
    return color;
    
}

- (UIImage *)getThemeImage:(NSString *)imageName{

    //得到图片路径
    
    //01得到主题包路径
    NSString *themaPath = [self themePath];
    
    //02拼接图片路径
    NSString *filePath = [themaPath stringByAppendingPathComponent:imageName];
    
    //03读取图片
    UIImage *image = [UIImage imageWithContentsOfFile:filePath];
    return  image;
    
}

- (NSString *)themePath{

    //01获取主题包根路径
    NSString *bundlePath = [[NSBundle mainBundle] resourcePath];
    NSLog(@"bundlePath:%@",bundlePath);
    //02当前主题包的路径
    NSString *themePath = [self.themeConfig objectForKey:self.themeName];
    
    //03完整路径
    NSString *path = [bundlePath stringByAppendingPathComponent:themePath];
    
    return path;
    

}









@end
