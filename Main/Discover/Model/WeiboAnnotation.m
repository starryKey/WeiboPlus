//
//  WeiboAnnotation.m
//  WeiboPlus
//
//  Created by wol on 15/9/23.
//  Copyright (c) 2015年 wol. All rights reserved.
//

#import "WeiboAnnotation.h"

@implementation WeiboAnnotation




//- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate{
//
//    _coordinate = newCoordinate;
//}

//设置坐标
- (void)setWeiboModel:(WeiboModel *)weiboModel{

    _weiboModel = weiboModel;
    NSDictionary *geo = weiboModel.geo;//NSDictionary *geo;//地理信息字段
    
    NSArray *coordinate = [geo objectForKey:@"coordinates"];
    if (coordinate.count >= 2) {
        NSString *longitude = coordinate[0];
        NSString *latitude = coordinate[1];
        //设置坐标
        _coordinate = CLLocationCoordinate2DMake([longitude floatValue], [latitude floatValue]);
    }
}




@end
