//
//  FaceView.h
//  WeiboPlus
//
//  Created by wol on 15/9/24.
//  Copyright (c) 2015年 wol. All rights reserved.
//


#import <UIKit/UIKit.h>

@protocol FaceViewDelegate <NSObject>

- (void)faceDidSelect:(NSString *)text;

@end

//28 * 4   112    28  28  28  28

/*
 [
    [0 1 2 3 4 ...27]
    [28-----57]
    []
    []
 ]

*/


@interface FaceView : UIView{
    NSMutableArray *_items;  //二维数组
    //放大镜视图
    UIImageView *_magnifierView;
    
    //选中的表情名
    NSString *_selectedFaceName;
}
@property(nonatomic,readonly)NSInteger pageNumber;
@property (nonatomic,weak) id<FaceViewDelegate> delegate;

@end
