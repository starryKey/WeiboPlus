//
//  WeiboModel.m
//  WeiboPlus
//
//  Created by wol on 15/9/10.
//  Copyright (c) 2015年 wol. All rights reserved.
//

#import "WeiboModel.h"
#import "RegexKitLite.h"
@implementation WeiboModel


- (NSDictionary*)attributeMapDictionary{
    
    //   @"属性名": @"数据字典的key"
    NSDictionary *mapAtt = @{
                             @"createDate":@"created_at",
                             @"weiboId":@"id",
                             @"text":@"text",
                             @"source":@"source",
                             @"favorited":@"favorited",
                             @"thumbnailImage":@"thumbnail_pic",
                             @"bmiddlelImage":@"bmiddle_pic",
                             @"originalImage":@"original_pic",
                             @"geo":@"geo",
                             @"repostsCount":@"reposts_count",
                             @"commentsCount":@"comments_count",
                             @"weiboIdStr":@"idstr"
                             };
    
    return mapAtt;
}

- (void)setAttributes:(NSDictionary *)dataDic{
    
    [super setAttributes:dataDic];
    
   // NSLog(@"微博来源:%@",self.source);
    
    //微博来源:<a href="http://app.weibo.com/t/feed/9ksdit" rel="nofollow">iPhone客户端</a>
    
    //正则表达式的应用
    //01微博来源处理 //@">.+<"
    if (_source != nil) {
        NSString *regex = @">.+<";
        NSArray *array = [_source componentsMatchedByRegex:regex];
        if ( array.count != 0) {
            NSString *temp = array[0];
            temp = [temp substringWithRange:NSMakeRange(1, temp.length-2)];
            _source = [NSString stringWithFormat:@"来源:%@",temp];
        }
        
    }
   
    
    
    //用户信息
    NSDictionary *userDic = [dataDic objectForKey:@"user"];
    if (userDic != nil) {
        _userModel = [[UserModel alloc]initWithDataDic:userDic];
    }
     //被转发的微博
    NSDictionary *reWeiBoDic = [dataDic objectForKey:@"retweeted_status"];
    if (reWeiBoDic != nil) {
        _reWeiBoModel  = [[WeiboModel alloc]initWithDataDic:reWeiBoDic];
        
         //02转发微博的用户名字处理 :用户名＋内容 字符串的拼接
        NSString *name = _reWeiBoModel.userModel.name;
        _reWeiBoModel.text = [NSString stringWithFormat:@"@%@:%@",name,_reWeiBoModel.text];
        
    }
    
    //03表情处理
    //>>01在微博中找到表情文字例如：[微笑]
    NSString *regex = @"\\[\\w+\\]";
    NSArray *faceItems = [_text componentsMatchedByRegex:regex];
    NSLog(@"%@",faceItems);
    //>> 在emoticons.plist文件中找到对应的png
    NSString *configPath = [[NSBundle mainBundle] pathForResource:@"emoticons" ofType:@"plist"];
    NSArray *faceArray = [NSArray arrayWithContentsOfFile:configPath];
    for (NSString  *faceName in faceItems) {
        // faceName = @"[兔子]", self.chs = @'[兔子]'
        //用谓词过滤
        NSString *t = [NSString stringWithFormat:@"self.chs='%@'",faceName];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:t];
        
        NSArray *items = [faceArray filteredArrayUsingPredicate:predicate];
        
        if (items.count > 0) {
            NSDictionary *faceDic = items[0];
            //取得图片的名字
            NSString *imageName = [faceDic objectForKey:@"png"];
            
            //<image url = '1.png'>
            
            NSString *replaceString = [NSString stringWithFormat:@"<image url = '%@'>",imageName];
            
            //原微博中［兔子］替换成 <image url = '001.png'>
            self.text = [self.text stringByReplacingOccurrencesOfString:faceName withString:replaceString];
        }
        
    }
    
}



@end


















