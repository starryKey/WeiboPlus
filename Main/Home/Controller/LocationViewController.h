//
//  LocationViewController.h
//  WeiboPlus
//
//  Created by wol on 15/9/22.
//  Copyright (c) 2015年 wol. All rights reserved.
//

#import "BaseViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "PoiModel.h"
@interface LocationViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,CLLocationManagerDelegate>
{
    UITableView *_tableView;
    CLLocationManager *_locationManager;
    
}

@property (nonatomic, strong)NSArray *dataList;//存放服务器返回的附近地名

@end
