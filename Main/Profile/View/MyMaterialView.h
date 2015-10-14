//
//  MyMaterialView.h
//  WeiboPlus
//
//  Created by wol on 15/10/4.
//  Copyright (c) 2015年 wol. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeiboModel.h"
#import "UserModel.h"
#import "ThemeLabel.h"
@interface MyMaterialView : UIView
/*
@property (weak, nonatomic) IBOutlet UIImageView *myImage;

@property (weak, nonatomic) IBOutlet ThemeLabel *myName;
@property (weak, nonatomic) IBOutlet ThemeLabel *mySex;
@property (weak, nonatomic) IBOutlet ThemeLabel *myAddress;
@property (weak, nonatomic) IBOutlet ThemeLabel *myIntroduce;
@property (weak, nonatomic) IBOutlet ThemeLabel *seeNumber;
@property (weak, nonatomic) IBOutlet ThemeLabel *fansNumber;

@property (weak, nonatomic) IBOutlet ThemeLabel *weiboNumber;

- (IBAction)seeButton:(UIButton *)sender;

- (IBAction)fansButton:(UIButton *)sender;

@property(nonatomic,strong)WeiboModel *weiboModel;
@property(nonatomic,strong)UserModel *userModel;

+ (MyMaterialView *)initMyMaterialView;

*/

@property (weak, nonatomic) IBOutlet UIImageView *myImage;

@property (weak, nonatomic) IBOutlet ThemeLabel *myName;
@property (weak, nonatomic) IBOutlet ThemeLabel *mySex;
@property (weak, nonatomic) IBOutlet ThemeLabel *myAddress;
@property (weak, nonatomic) IBOutlet ThemeLabel *myIntroduce;
- (IBAction)seeButton:(UIButton *)sender;

- (IBAction)fansButton:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet ThemeLabel *seeNumber;
@property (weak, nonatomic) IBOutlet ThemeLabel *fansNumber;
@property (weak, nonatomic) IBOutlet ThemeLabel *weiboNumber;
- (IBAction)moreButton:(UIButton *)sender;
- (IBAction)informationButton:(UIButton *)sender;

@property(nonatomic,strong)WeiboModel *weiboModel;
@property(nonatomic,strong)UserModel *userModel;

@end
