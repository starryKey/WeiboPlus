//
//  ZoomImageView.m
//  WeiboPlus
//
//  Created by wol on 15/9/20.
//  Copyright (c) 2015年 wol. All rights reserved.
//

#import "ZoomImageView.h"
#import "MBProgressHUD.h"

#import <ImageIO/ImageIO.h>
#import "UIImage+GIF.h"


@implementation ZoomImageView{


    NSURLConnection *_connection;
    double _length;//纪录文件的大小
    NSMutableData *_data;
    MBProgressHUD  *_hud;
}
//从xib文件中创建出来
- (instancetype)initWithCoder:(NSCoder *)aDecoder{

    self = [super initWithCoder:aDecoder];
    if (self) {
        [self _initTap];
        
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {
        [self _initTap];
        [self _createIconGif];
    }
    return self;
}
- (instancetype)initWithImage:(UIImage *)image{

    self = [super initWithImage:image];
    if (self) {
        [self _initTap];
        [self _createIconGif];
    }
    return self;
}

- (void)_initTap{

    //01打开交互
    self.userInteractionEnabled = YES;
    //02创建单击手势
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(zoomIn)];
    [self addGestureRecognizer:gesture];
    self.contentMode = UIViewContentModeScaleAspectFit;
    
    
}


- (void)_createIconGif{

    //设置GIF图片
    
    _iconImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
    _iconImageView.hidden = YES;
    _iconImageView.image = [UIImage imageNamed:@"timeline_gif.png"];
    [self addSubview:_iconImageView];
    

}


- (void)zoomIn{
    //调用代理方法
    if ([self.delegate respondsToSelector:@selector(imageWillZoomIn:)]) {
        [self.delegate imageWillZoomIn:self];
    }
    
    self.hidden = YES;
    //01创建大图浏览的_scrollview
    [self _createView];
    //02计算_fullImageView的frame
    //把自己相对于父视图的frame转换成相对于window的frame
    CGRect frame = [self convertRect:self.bounds toView:self.window];
    _fullImageView.frame = frame;
    //03添加动画.放大
    [UIView animateWithDuration:.6 animations:^{
        _fullImageView.frame = _scrollView.frame;
        
    }completion:^(BOOL finished) {
        _fullImageView.backgroundColor = [UIColor blackColor];
        [self _loadImage];
        
    }];
    
    
}

- (void)_loadImage{
    
    //04请求网络下载原图片
    if (self.fullImageUrl.length > 0) {
        //设置加载进程
        if (_hud == nil) {
            _hud = [MBProgressHUD showHUDAddedTo:_scrollView animated:YES];
            _hud.mode = MBProgressHUDModeDeterminate;
            _hud.progress = 0.0;
        }
        
        NSURL *url = [NSURL URLWithString:_fullImageUrl];
        NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:30];
        _connection = [NSURLConnection connectionWithRequest:request delegate:self];
    }


    
}

- (void)_createView{
    
    if (_scrollView == nil) {
        //01创建_scrollView
        _scrollView = [[UIScrollView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        [self.window addSubview:_scrollView];
        //02创建_fullImageView
        _fullImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        _fullImageView.contentMode = UIViewContentModeScaleAspectFit;
        _fullImageView.image = self.image;
        [_scrollView addSubview:_fullImageView];
        
        //03添加缩小手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(zoomOut)];
        [_scrollView addGestureRecognizer:tap];
    
        //04 长按保存
        UILongPressGestureRecognizer  *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(savePhoto:)];
        [_scrollView addGestureRecognizer:longPress];
        
        
        
        
        
        
    }
    
}

#pragma mark - 保存图片到相册
- (void)savePhoto:(UILongPressGestureRecognizer *)longPress{
    if (longPress.state == UIGestureRecognizerStateBegan) {
        //弹出提示框
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"是否保存到相册" delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是", nil];
        [alert show];
    }

}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

    if (buttonIndex == 1) {
        UIImage *img = _fullImageView.image;
        //保存照片
        UIImageWriteToSavedPhotosAlbum(img, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    }
}

//保存成功调用
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    //提示保存成功
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.window animated:YES];
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];

    //显示模式为：自定义视图模式
    hud.mode = MBProgressHUDModeCustomView;
    hud.labelText = @"保存成功!";
    //延迟隐藏
    [hud hide:YES afterDelay:1];
    
}



- (void)zoomOut{
    if ([self.delegate respondsToSelector:@selector(imageWillZoomOut:)]) {
        [self.delegate imageWillZoomOut:self];
    }
    
    
    //取消网络下载
    [_connection cancel];
    self.hidden = NO;
    _fullImageView.backgroundColor = [UIColor clearColor];
    [UIView animateWithDuration:0.6 animations:^{
      CGRect frame = [self convertRect:self.bounds toView:self.window];
        _fullImageView.frame = frame;
        
        //计算偏移
        _fullImageView.top += _scrollView.contentOffset.y;
        
    } completion:^(BOOL finished) {
        [_scrollView removeFromSuperview];
        _fullImageView = nil;
        _scrollView = nil;
        _hud = nil;
    }];

}

#pragma mark - 网络下载delegate
//服务器响应网络请求
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    //01取得响应头
    NSDictionary *headerFiles = [httpResponse allHeaderFields];
    NSLog(@"响应头:%@",headerFiles);
    //02获取文件的大小
    NSString *lengthStr = [headerFiles objectForKey:@"Content-Length"];
    _length = [lengthStr doubleValue];
    
    _data = [[NSMutableData alloc]init];
    
   
    

}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{

     [_data appendData:data];
    CGFloat progress = _data.length/_length;
    
    _hud.progress = progress;
    NSLog(@"进度是:%f",progress);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    NSLog(@"下载完成");
    [_hud hide:YES];
    UIImage *image = [UIImage imageWithData:_data];
    _fullImageView.image = image;
    
    //尺寸处理
    CGFloat length = image.size.height/image.size.width * kScreenWidth;
    if (length>kScreenHeight) {
        [UIView animateWithDuration:.3 animations:^{
            _fullImageView.height = length;
            _scrollView.contentSize = CGSizeMake(kScreenWidth, length);
        }];
    }
    
    if (self.isGif) {
        [self gifImageShow];
    }
    

}

- (void)gifImageShow{
/*
    //1.weiboview播放
    UIWebView  *webView = [[UIWebView alloc]initWithFrame:_scrollView.bounds];
    webView.userInteractionEnabled = NO;
    webView.scalesPageToFit = YES;
    [webView loadData:_data MIMEType:@"image/gif" textEncodingName:nil baseURL:nil];
    [_scrollView addSubview:webView];

    //2.使用ImageIO 提取GIF中所有帧的图片进行播放
    //#import <ImageIO/ImageIO.h>
    //>>01创建图片源
    CGImageSourceRef source = CGImageSourceCreateWithData((__bridge CFDataRef)_data, NULL);
    //>>02获取图片源的图片个数
    size_t count = CGImageSourceGetCount(source);
    NSMutableArray *images = [[NSMutableArray alloc]init];
    for (size_t i = 0; i < count; i++) {
        //03获取每一张图片
        CGImageRef image = CGImageSourceCreateImageAtIndex(source, i, NULL);
        UIImage *uiImage = [UIImage imageWithCGImage:image];
        [images addObject:uiImage];
        CGImageRelease(image);
    }
    //04imageView 播放图片数组
    //>>04-1 第一种方式播放
    _fullImageView.animationImages = images;
    _fullImageView.animationDuration = images.count * 0.1;
    [_fullImageView startAnimating];
    //>>04-2 第二种播放方式
    UIImage *animatedImage = [UIImage animatedImageWithImages:images duration:images.count*0.1];
    _fullImageView.image = animatedImage;
  
 */
    //3.第三方框架SDWebImage封装的GIF播放
    
    _fullImageView.image = [UIImage sd_animatedGIFWithData:_data];
    
    

}

@end

