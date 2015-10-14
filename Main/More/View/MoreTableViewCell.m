//
//  MoreTableViewCell.m
//  WeiboPlus
//
//  Created by wol on 15/9/11.
//  Copyright (c) 2015年 wol. All rights reserved.
//

#import "MoreTableViewCell.h"

@implementation MoreTableViewCell

- (void)awakeFromNib {
 
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (void)dealloc{

    [[NSNotificationCenter defaultCenter ] removeObserver:self];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self _createSubView];
        [self themeChangeAction];
        //注册通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeChangeAction) name:kThemeDidChangeNotificationName object:nil];
    }

    return  self;
}

- (void)_createSubView{
    
    _themeImageView = [[ThemeImageView  alloc] initWithFrame:CGRectMake(7, 7, 30, 30)];
    _themeTextLabel = [[ThemeLabel alloc]initWithFrame:CGRectMake(_themeImageView.right , 11, 200, 20)];
    _themeDetailLabel = [[ThemeLabel alloc]initWithFrame:CGRectMake(self.right-95, 11, 95, 20)];
    _themeTextLabel.font = [UIFont boldSystemFontOfSize:16];
    _themeTextLabel.backgroundColor = [UIColor clearColor];
    _themeTextLabel.colorName = @"More_Item_Text_color";
    
    _themeDetailLabel.font = [UIFont boldSystemFontOfSize:15];
    _themeDetailLabel.backgroundColor = [UIColor clearColor];
    _themeDetailLabel.colorName = @"More_Item_Text_color";
    _themeDetailLabel.textAlignment = NSTextAlignmentRight;
    
    [self.contentView addSubview:_themeImageView];
    [self.contentView addSubview:_themeTextLabel];
    [self.contentView addSubview:_themeDetailLabel];

}

- (void)themeChangeAction{

    //接收到通知 改变cell背景颜色
    self.backgroundColor = [[ThemeManager shareInstance] getThemeColor:@"More_Item_color"];

}

- (void)layoutSubviews{
    [super layoutSubviews];

    _themeDetailLabel.frame = CGRectMake(self.right-95-30, 11, 95, 20);


}




@end
