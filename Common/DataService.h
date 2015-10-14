//
//  DataService.h
//  04 weibo
//
//  Created by gj on 15/8/12.
//  Copyright (c) 2015年 www.huiwen.com 杭州汇文教育. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Common.h"
#import "AFNetworking.h"
#import "AFHTTPRequestOperation.h"

#define BaseUrl @"https://api.weibo.com/2/"

typedef void(^BlockType)(id result);

@interface DataService : NSObject


+ (void)requestUrl:(NSString *)urlString //url
        httpMethod:(NSString *)method //GET  POST
            params:(NSMutableDictionary *)params //参数
             block:(BlockType)block; //接收到的数据的处理



+ (AFHTTPRequestOperation *)requestAFUrl:(NSString *)urlString
        httpMethod:(NSString *)method
            params:(NSMutableDictionary *)params //token  文本
              data:(NSMutableDictionary *)datas //文件
             block:(BlockType)block;



//获取微博列表
+ (void)getHomeList:(NSMutableDictionary *)params
              block:(BlockType)block;

//发微博
+ (void)sendWeibo:(NSMutableDictionary *)params
            block:(BlockType)block;


+ (AFHTTPRequestOperation *)sendWeibo:(NSString *)text
            image:(UIImage *)image
            block:(BlockType)block;


@end
