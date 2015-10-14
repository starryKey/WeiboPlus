//
//  NearByViewController.h
//  WeiboPlus
//
//  Created by wol on 15/9/22.
//  Copyright (c) 2015年 wol. All rights reserved.
//

#import "BaseViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
@interface NearByViewController : BaseViewController<MKMapViewDelegate,CLLocationManagerDelegate>{

    MKMapView *_mapView;
    CLLocationManager *_locationManager;
}


@end
