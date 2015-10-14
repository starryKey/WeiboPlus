//
//  SendViewController.h
//  WeiboPlus
//
//  Created by wol on 15/9/21.
//  Copyright (c) 2015年 wol. All rights reserved.
//

#import "BaseViewController.h"
#import "ZoomImageView.h"
#import <CoreLocation/CoreLocation.h>
#import "FaceScrollView.h"
@interface SendViewController : BaseViewController<UINavigationControllerDelegate,UITableViewDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate,ZoomImageViewDelegate,CLLocationManagerDelegate,FaceViewDelegate>

@end
