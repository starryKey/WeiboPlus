//
//  MyMaterialView.m
//  WeiboPlus
//
//  Created by wol on 15/10/4.
//  Copyright (c) 2015年 wol. All rights reserved.
//

/*
 //@interface UserModel : BaseModel
 //@property(nonatomic,copy)NSString *idstr;           //字符串型的用户UID
 //@property(nonatomic,copy)NSString *screen_name;     //用户昵称
 //@property(nonatomic,copy)NSString *name;            //友好显示名称
 //@property(nonatomic,copy)NSString *location;        //用户所在地
 //@property(nonatomic,copy)NSString *description;     //用户个人描述
 //@property(nonatomic,copy)NSString *url;             //用户博客地址
 //@property(nonatomic,copy)NSString * profile_image_url;  //用户头像地址，50×50像素
 //@property(nonatomic,copy)NSString * avatar_large;  //用户大头像地址
 //@property(nonatomic,copy)NSString * gender;             //性别，m：男、f：女、n：未知
 //@property(nonatomic,retain)NSNumber * followers_count;    //粉丝数
 //@property(nonatomic,retain)NSNumber * friends_count;   //关注数
 //@property(nonatomic,retain)NSNumber * statuses_count;   //微博数
 //@property(nonatomic,retain)NSNumber * favourites_count;   //收藏数
 //@property(nonatomic,retain)NSNumber * verified;   //是否是微博认证用户，即加V用户，true：是，false：否
 //@property (weak, nonatomic) IBOutlet UIImageView *myImage;
 //@property (weak, nonatomic) IBOutlet UILabel *myName;
 //@property (weak, nonatomic) IBOutlet UILabel *mySex;
 //@property (weak, nonatomic) IBOutlet UILabel *myAddress;
 //@property (weak, nonatomic) IBOutlet UILabel *myIntroduce;
 //@property (weak, nonatomic) IBOutlet UILabel *seeNumber;
 //@property (weak, nonatomic) IBOutlet UILabel *fansNumber;
 //@property (weak, nonatomic) IBOutlet UIButton *fansButton;

 */


#import "MyMaterialView.h"
#import "UIImageView+WebCache.h"

@implementation MyMaterialView

- (instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}
-  (instancetype)initWithCoder:(NSCoder *)aDecoder{

    self = [super initWithCoder:aDecoder];
    if (self) {
        
    }
    return self;
}
- (void)setUserModel:(UserModel *)userModel{

    _myName.text = userModel.name;
    _myIntroduce.text = @"hello world!";
    _myAddress.text = userModel.location;
    NSString *imgUrl = userModel.avatar_large;
    [_myImage sd_setImageWithURL:[NSURL URLWithString:imgUrl]];
    _mySex.text = @"男";
    _seeNumber.text = [NSString stringWithFormat:@"%@",userModel.friends_count];
    _fansNumber.text = [NSString stringWithFormat:@"%@",userModel.followers_count];
    _weiboNumber.text = [NSString stringWithFormat:@"共%@条微博",userModel.statuses_count];
    
    
}


- (IBAction)seeButton:(UIButton *)sender {
}


- (IBAction)fansButton:(UIButton *)sender {
}
- (IBAction)moreButton:(UIButton *)sender {
}

- (IBAction)informationButton:(UIButton *)sender {
}
@end
