//
//  CommentTableView.m
//  WeiboPlus
//
//  Created by wol on 15/9/19.
//  Copyright (c) 2015年 wol. All rights reserved.
//

#import "CommentTableView.h"
#import "WeiboViewLayoutFrame.h"
#import "CommentModel.h"
@implementation CommentTableView

static NSString *cellID = @"cellID";

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{

    self = [super initWithFrame:frame style:style];
    if (self) {
        [self _creatHeaderView];
        self.delegate = self;
        self.dataSource = self;
        UINib *nib = [UINib nibWithNibName:@"CommentCell" bundle:[NSBundle mainBundle]];
        [self registerNib:nib forCellReuseIdentifier:cellID];
        
    }
    return self;
}

- (void)_creatHeaderView{
    //1.创建父视图
    
    _theTableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.width, 0)];
    
#warning mark - 测试
   // _theTableHeaderView.backgroundColor = [UIColor redColor];
    _theTableHeaderView.backgroundColor = [UIColor clearColor];
    //02.加载xib创建用户视图
    _userView = [[[NSBundle mainBundle]loadNibNamed:@"UserView" owner:self options:nil] lastObject];
    _userView.backgroundColor = [UIColor clearColor];
    
    _userView.width = kScreenWidth;
    _userView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.1];
    [_theTableHeaderView  addSubview:_userView];
    
    //03创建微博视图
    _weiboView = [[WeiboView alloc]initWithFrame:CGRectMake(0, 0, 10, 20)];
#warning mark - 测试
    //_weiboView.backgroundColor = [UIColor cyanColor];
    _weiboView.imgView.contentMode = UIViewContentModeScaleAspectFit;
#warning mark - 测试
    NSLog(@"用户的Y值是:%f",_userView.bottom);
    [_theTableHeaderView addSubview:_weiboView];
}

- (void)setWeiboModel:(WeiboModel *)weiboModel{

    if (_weiboModel != weiboModel) {
        _weiboModel = weiboModel;
        
        //01创建微博视图的布局对象
        WeiboViewLayoutFrame *layoutFrame = [[WeiboViewLayoutFrame alloc]init];
        layoutFrame.isDetail = YES;
        layoutFrame.weiboModel = weiboModel;
        
        _weiboView.layoutFrame = layoutFrame;
        _weiboView.frame = layoutFrame.frame;
        _weiboView.top = _userView.bottom + 5;
#warning mark - 测试
        NSLog(@"微博视图的Y值是:%f",_weiboView.top);
        
        //2.用户视图
        _userView.weiboModel = weiboModel;
        
        //3.设置头视图
        _theTableHeaderView.height = _weiboView.bottom;

        self.tableHeaderView = _theTableHeaderView;
    }
}

#pragma mark -  TabelView 代理
//获取组的头视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    //1.创建组视图
    UIView *sectionHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.width, 40)];
    
    
    //2.评论Label
    UILabel *countLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 100, 20)];
   // countLabel.backgroundColor = [UIColor clearColor];

    countLabel.font = [UIFont boldSystemFontOfSize:16.0f];
    countLabel.textColor = [UIColor blackColor];
    
    
    //3.评论数量
    NSNumber *total = [self.commentDic objectForKey:@"total_number"];
    int value = [total intValue];
    countLabel.text = [NSString stringWithFormat:@"评论:%d",value];
    [sectionHeaderView addSubview:countLabel];
    
    sectionHeaderView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.1];
    
    return sectionHeaderView;
}

//设置组的头视图的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

//设置单元格的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CommentModel *model = self.commentDataArray[indexPath.row];
    //计算单元格的高度
    CGFloat height = [CommentCell getCommentHeight:model];
    
    return height;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    cell.commentModel = self.commentDataArray[indexPath.row];
    
    return cell;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.commentDataArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}



















@end
