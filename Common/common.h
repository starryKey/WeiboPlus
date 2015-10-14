//
//  common.h
//  WeiboPlus
//
//  Created by wol on 15/9/7.
//  Copyright (c) 2015年 wol. All rights reserved.
//

#ifndef WeiboPlus_common_h
#define WeiboPlus_common_h

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
////SDK
//#define kAppKey             @"2354458100"
//#define kAppSecret          @"19fd68182835a7839c28ef5e2e9c7550"
//#define kAppRedirectURI     @"https://api.weibo.com/oauth2/default.html"
//

//App Key：2317226332
//App Secret：185babf3e33c909be521dde3e8e4e480

#define kAppKey @"2317226332"
#define kAppSecret @"185babf3e33c909be521dde3e8e4e480"
#define kAppRedirectURI @"https://api.weibo.com/oauth2/default.html"

#define unread         @"remind/unread_count.json" //未读消息
#define home_timeline  @"statuses/home_timeline.json"//微博列表@"statuses/home_timeline.json"
#define comments       @"comments/show.json"//评论列表
#define send_update @"statuses/update.json"  //发微博(不带图片)
#define send_upload @"statuses/upload.json"  //发微博(带图片)
#define geo_to_address @"location/geo/geo_to_address.json"  //查询坐标对应的位置
#define nearby_pois @"place/nearby/pois.json" // 附近商圈
#define nearby_timeline  @"place/nearby_timeline.json" //附近动态

#define user_show @"users/show.json" 当前用户信息


#define kVersion [[UIDevice currentDevice].systemVersion doubleValue]

//微博字体
#define FontSize_Weibo(isDetail) isDetail?16:15
#define FontSize_ReWeibo(isDetail) isDetail?15:14


#endif
