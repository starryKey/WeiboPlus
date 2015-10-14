//
//  WeiboTableView.h
//  WeiboPlus
//
//  Created by wol on 15/9/13.
//  Copyright (c) 2015年 wol. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeiboViewLayoutFrame.h"
@interface WeiboTableView : UITableView<UITableViewDataSource,UITableViewDelegate>

//@property(nonatomic, strong)NSArray *dataArray;

@property(nonatomic, strong)NSArray *layoutFrameArray;

@end
