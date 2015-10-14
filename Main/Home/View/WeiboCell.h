//
//  WeiboCell.h
//  WeiboPlus
//
//  Created by wol on 15/9/13.
//  Copyright (c) 2015年 wol. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeiboModel.h"
#import "WeiboView.h"
#import "WeiboViewLayoutFrame.h"
@interface WeiboCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *headImageView;

@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *rePostLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;
@property (weak, nonatomic) IBOutlet UILabel *srLabel;

@property (nonatomic, strong)WeiboView *weiboView;

//@property (nonatomic, strong) WeiboModel *model;

@property (strong,nonatomic) WeiboViewLayoutFrame *layoutFrame;

@end
