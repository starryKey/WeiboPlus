//
//  WeiboAnnotation.h
//  WeiboPlus
//
//  Created by wol on 15/9/23.
//  Copyright (c) 2015年 wol. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MKAnnotation.h>
#import "WeiboModel.h"
@interface WeiboAnnotation : NSObject<MKAnnotation>


@property (nonatomic, assign) CLLocationCoordinate2D coordinate;



// Title and subtitle for use by selection UI.
@property (nonatomic, copy) NSString *title;
@property (nonatomic,  copy) NSString *subtitle;

// Called as a result of dragging an annotation view.
- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate;

@property (nonatomic, strong) WeiboModel *weiboModel;



@end
