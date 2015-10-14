//
//  NearByViewController.m
//  WeiboPlus
//
//  Created by wol on 15/9/22.
//  Copyright (c) 2015年 wol. All rights reserved.
//

#import "NearByViewController.h"
#import "WeiboAnnotation.h"
#import "WeiboAnnotationView.h"
#import "DataService.h"
#import "DetailViewController.h"
@interface NearByViewController ()

@end
/*
 1.定义（MKAnnotation协议）annotation类
 2.创建 annotation对象，并把对象添加到mapview
 3.实现mapView 的协议方法，创建标注视图
 
 */


@implementation NearByViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _createMapView];
    [self _location];
  /*
    WeiboAnnotation *annotation = [[WeiboAnnotation alloc]init];
    annotation.title = @"杭电学生公寓";
    annotation.subtitle = @"12号楼";
    //annotation.coordinate = @{@30.1842,@120.2019};
    CLLocationCoordinate2D coordinate = {30.1842,120.2019};
    [annotation setCoordinate:coordinate];
    [_mapView addAnnotation:annotation];
    
    WeiboAnnotation *annotation1 = [[WeiboAnnotation alloc]init];
    annotation1.title = @"滨江学生公寓";
    annotation1.subtitle = @"10号楼";
    //annotation.coordinate = @{@30.1842,@120.2019};
    CLLocationCoordinate2D coordinate1 = {30.1642,120.2219};
    [annotation1 setCoordinate:coordinate1];
    
    [_mapView addAnnotation:annotation1];
*/
    
    
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
  
}

- (void)_createMapView{

    _mapView = [[MKMapView alloc]initWithFrame:self.view.bounds];
    //01显示用户位置
    _mapView.showsUserLocation = YES;
    //02地图显示类型 :标准、卫星、混合
    _mapView.mapType = MKMapTypeStandard;
    //03设置代理
    _mapView.delegate = self;
    
    
   //两种显示区域的方法,一种是用户跟踪模式，另一种是自己设置地图的范围
    //04用户跟踪模式
   // _mapView.userTrackingMode = MKUserTrackingModeFollow;
    
    
    
    
    [self.view addSubview:_mapView];
}




//返回标注视图,自定义标注视图
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation{
    
    //如果是用户定位则用默认的标注视图
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    //覆用池,获取标注视图
    if ([annotation isKindOfClass:[WeiboAnnotation class]]) {
        WeiboAnnotationView *annotationView = (WeiboAnnotationView *)[mapView   dequeueReusableAnnotationViewWithIdentifier:@"view"];
        if (annotationView == nil) {
            annotationView = [[WeiboAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"view"];
          
            
        }
        annotationView.annotation = annotation;
        return annotationView;
        
    }
    return nil;
    
}




/*
//返回标注视图,系统自带大头针
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation{

    //如果是用户定位则用默认的标注视图
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    
    
    MKPinAnnotationView *pinView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"view"];
    if (pinView == nil) {  //覆用池
        pinView = [[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"view"];
        //01设置大头针颜色
        pinView.pinColor = MKPinAnnotationColorPurple;
        //02设置从天而降的效果
        pinView.animatesDrop = YES;
        //03设置显示标题
        pinView.canShowCallout = YES;
        //04设置辅助视图 感叹号等
        pinView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        
    }
    return pinView;

}
*/



#pragma mark - 定位管理
- (void)_location{

    //定位
    _locationManager = [[CLLocationManager alloc]init];
    if (kVersion > 8.0) {
        [_locationManager requestWhenInUseAuthorization];
    }
    //设置请求精确度
    [_locationManager setDesiredAccuracy:kCLLocationAccuracyBest ];
    _locationManager.delegate = self;
    //开始定位
    [_locationManager startUpdatingLocation];
}

#pragma mark - 定位管家delegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    //01停止定位
    [manager stopUpdatingLocation];
    //02获取当前请求位置
    CLLocation *location = [locations  lastObject];
    CLLocationCoordinate2D coordinate = [location coordinate];
    //经纬度
    NSString *lon = [NSString stringWithFormat:@"%f",coordinate.longitude];
    NSString *lat = [NSString stringWithFormat:@"%f",coordinate.latitude];
    //开始加载网络
    [self _loadNearByPoisWithLon:lon lat:lat];
    
    //03设置地图显示区域
    
    /* typedef struct {
     CLLocationDegrees latitudeDelta;
     CLLocationDegrees longitudeDelta;
     } MKCoordinateSpan;
     
     typedef struct {
     CLLocationCoordinate2D center;
     MKCoordinateSpan span;
     } MKCoordinateRegion;
     >>01设置center
     >>02设置span
     */
    
    //>>01设置center
    CLLocationCoordinate2D center = coordinate;
    //>>02设置span 数值越小精度越高，即范围越小
    MKCoordinateSpan span = {0.1,0.1};
    MKCoordinateRegion  region ={center,span};
    [_mapView setRegion:region];
    
}



//#pragma mark - mapView代理方法
//- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
//
//    CLLocation *location = [userLocation location];
//    CLLocationCoordinate2D coordinate = [location coordinate];
//    NSLog(@"纬度: %f 经度: %f",coordinate.latitude,coordinate.longitude);
//    
//}

#pragma mark - 获取附近的微博
- (void)_loadNearByPoisWithLon:(NSString *)lon lat:(NSString *)lat{
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    [params setObject:lon forKey:@"long"];
    [params setObject:lat forKey:@"lat"];
    
    [DataService requestAFUrl:nearby_timeline httpMethod:@"GET" params:params data:nil block:^(id result) {
        NSArray *statuses = [result objectForKey:@"statuses"];
        NSLog(@"%@",statuses);
        
        NSMutableArray *annotationArray = [[NSMutableArray alloc]initWithCapacity:statuses.count];
        
        for (NSDictionary *dataDic in statuses) {
            WeiboModel *model = [[WeiboModel alloc]initWithDataDic:dataDic];
           NSLog(@"weiboModel:%@",model.text);
            WeiboAnnotation *annotation = [[WeiboAnnotation alloc]init];
            annotation.weiboModel = model;
            [annotationArray addObject:annotation];
            
        }
        //把annotation 添加到mapView
        [_mapView addAnnotations:annotationArray];
    }];
    

}

#pragma mark - 选中标注视图
- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view{
    NSLog(@"选中");
    if (![view.annotation isKindOfClass:[WeiboAnnotation class]]) {
        return;
    }
    WeiboAnnotation *weiboAnnotation = view.annotation;
    WeiboModel *model = weiboAnnotation.weiboModel;
    DetailViewController *vc = [[DetailViewController alloc]init];
    vc.weiboModel = model;
    
    [self.navigationController pushViewController:vc animated:YES];
    
    
}




@end
