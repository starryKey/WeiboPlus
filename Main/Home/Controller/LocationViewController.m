//
//  LocationViewController.m
//  WeiboPlus
//
//  Created by wol on 15/9/22.
//  Copyright (c) 2015年 wol. All rights reserved.
//

#import "LocationViewController.h"
#import "DataService.h"
#import "UIImageView+WebCache.h"
@interface LocationViewController ()

@end

@implementation LocationViewController


- (instancetype)init{

    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //01初始化视图
    [self _createTableView];
    
    //02定位
    _locationManager = [[CLLocationManager alloc]init];
    if (kVersion > 8.0) {
        [_locationManager requestWhenInUseAuthorization];
    }
    //设置请求精确度
    [_locationManager setDesiredAccuracy:kCLLocationAccuracyNearestTenMeters];
    _locationManager.delegate = self;
    //开始定位
    [_locationManager startUpdatingLocation];
    
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}
#pragma mark - 创建tableView
- (void)_createTableView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    

    
}
//返回按钮
- (void)backAction{
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - 开始加载网络
- (void)loadNearByPoisWithLon:(NSString *)lon lat:(NSString *)lat{
    //01配置参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:lon forKey:@"long"];
    [params setObject:lat forKey:@"lat"];
    [params setObject:@50 forKey:@"count"];
    //02请求数据,获取附近商家

    [DataService requestUrl:nearby_pois httpMethod:@"GET" params:params block:^(id result) {
        NSArray *pois = result[@"pois"];
        NSMutableArray *dataList = [NSMutableArray array];
        for (NSDictionary *dic  in pois) {
            //创建商业圈模型对象
            PoiModel *poi = [[PoiModel alloc]initWithDataDic:dic];
            [dataList addObject:poi];
        }
        self.dataList = dataList;
        [_tableView reloadData];
    }];

}


#pragma mark - 定位管家delegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    //01停止定位
    [manager stopUpdatingLocation];
    //02获取当前请求位置
    CLLocation *location = [locations  lastObject];
    //经纬度
    NSString *lon = [NSString stringWithFormat:@"%f",location.coordinate.longitude];
    NSString *lat = [NSString stringWithFormat:@"%f",location.coordinate.latitude];
    //开始加载网络
    [self loadNearByPoisWithLon:lon lat:lat];
    
    

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataList.count;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *locCellId = @"locCellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:locCellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:locCellId];
    }
    PoiModel *model = self.dataList[indexPath.row];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:model.icon] placeholderImage:[UIImage imageNamed:@"icon"]];
    cell.textLabel.text = model.title;
    
    return cell;

}

@end
