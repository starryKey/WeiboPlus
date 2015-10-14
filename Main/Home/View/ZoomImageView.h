//
//  ZoomImageView.h
//  WeiboPlus
//
//  Created by wol on 15/9/20.
//  Copyright (c) 2015年 wol. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZoomImageView;
@protocol ZoomImageViewDelegate <NSObject>

@optional

//图片将要放大
- (void)imageWillZoomIn:(ZoomImageView *)imageView;
//图片将要缩小
- (void)imageWillZoomOut:(ZoomImageView *)imageView;
//图片已经放大
- (void)imageDidZoomIn:(ZoomImageView *)imageView;
//图片已经缩小
- (void)imageDidZoomOut:(ZoomImageView *)imageView;
//...

@end


@interface ZoomImageView : UIImageView<NSURLConnectionDataDelegate,UIAlertViewDelegate>
{
    UIScrollView *_scrollView;
    UIImageView *_fullImageView;
    
}
@property (nonatomic,weak) id<ZoomImageViewDelegate> delegate;

// assign weak 防止循环引用
@property (nonatomic,strong) NSString *fullImageUrl;
@property (nonatomic,assign) BOOL isGif;
//gif处理
@property (nonatomic,strong) UIImageView *iconImageView;


@end
