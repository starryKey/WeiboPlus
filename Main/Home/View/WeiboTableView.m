//
//  WeiboTableView.m
//  WeiboPlus
//
//  Created by wol on 15/9/13.
//  Copyright (c) 2015年 wol. All rights reserved.
//

#import "WeiboTableView.h"
#import "WeiboCell.h"
#import "WeiboModel.h"
#import "UIView+ViewController.h"
#import "DetailViewController.h"
@implementation WeiboTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{

    self = [super initWithFrame:frame style:style];
    if (self) {
        [self _createViews];
    }
    return self;

}

- (void)awakeFromNib{
    [self _createViews];

}

- (void)_createViews{
    self.delegate = self;
    self.dataSource = self;
    //注册单元格
    UINib *nib = [UINib nibWithNibName:@"WeiboCell" bundle:nil];
    [self registerNib:nib forCellReuseIdentifier:@"weiboCellID"];

}

#pragma mark - tableView代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return _layoutFrameArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    WeiboCell *cell = [tableView dequeueReusableCellWithIdentifier:@"weiboCellID" forIndexPath:indexPath];
    
    WeiboViewLayoutFrame *layoutFrame = _layoutFrameArray[indexPath.row];
    
    //定制单元格
   // WeiboModel *model = _dataArray[indexPath.row];
   // cell.textLabel.text = model.text;
    //cell.model = model;
    //获取某个cell的布局对象（各个frame weiboModel）
    
    cell.layoutFrame = layoutFrame;
    
    return cell;

}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    WeiboViewLayoutFrame *layoutFrame = _layoutFrameArray[indexPath.row];
    CGFloat height = layoutFrame.frame.size.height;
    
    
    return height + 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

//    //通过view找到viewController；通过响应者链
//    DetailViewController *detailVC = [[DetailViewController alloc]init];
//    
//    WeiboViewLayoutFrame *layoutFrame = _layoutFrameArray[indexPath.row];
//    detailVC.weiboModel = layoutFrame.weiboModel;
//    
//    [self.viewController.navigationController pushViewController:detailVC animated:YES];
    
    
    DetailViewController *vc = [[DetailViewController alloc] init];
    
    WeiboViewLayoutFrame *layoutFrame = _layoutFrameArray[indexPath.row];
    vc.weiboModel = layoutFrame.weiboModel;
    
    //通过 view找viewController:原理，事件响应者链
    [self.viewController.navigationController pushViewController:vc animated:YES];
    


}




@end
