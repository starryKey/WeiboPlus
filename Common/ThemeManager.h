//
//  ThemeManager.h
//  WeiboPlus
//
//  Created by wol on 15/9/8.
//  Copyright (c) 2015年 wol. All rights reserved.
//

#import <Foundation/Foundation.h>
#define kThemeName @"kThemeName"

#define kThemeDidChangeNotificationName @"kThemeDidChangeNotificationName"

@interface ThemeManager : NSObject

@property (nonatomic, copy)NSString *themeName; //主题包的名字
@property (nonatomic, strong)NSDictionary *themeConfig; //theme.plist的内容
@property (nonatomic, strong)NSDictionary *colorConfig; //每个目录下的config.plist

//单例类方法，获得唯一对象（如果对象存在,直接返回）
+ (ThemeManager *)shareInstance;


- (UIImage *)getThemeImage:(NSString *)imageName;

- (UIColor *)getThemeColor:(NSString *)colorName;

@end
