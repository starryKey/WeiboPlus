//
//  ProfileTableView.m
//  WeiboPlus
//
//  Created by wol on 15/10/4.
//  Copyright (c) 2015年 wol. All rights reserved.
//

#import "ProfileTableView.h"

@implementation ProfileTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{


    self = [super initWithFrame:frame style:style];
    if (self ) {
        [self _createView];
    }
    return self;
}

- (void)awakeFromNib{

    [self _createView];
}

- (void)_createView{
    _tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.width, 220)];
    _tableHeaderView.backgroundColor = [UIColor clearColor];
       
   
    _myMaterialView = [[[NSBundle mainBundle]loadNibNamed:@"MyMaterialView" owner:self options:nil]lastObject];
    [_tableHeaderView addSubview:_myMaterialView];
    _myMaterialView.backgroundColor = [UIColor clearColor];
    _myMaterialView.width = self.width;
    
    self.delegate = self;
    self.dataSource = self;
    self.backgroundColor = [UIColor clearColor];
    
    UINib *nib = [UINib nibWithNibName:@"MyCommentCell" bundle:nil];
    [self registerNib:nib forCellReuseIdentifier:@"MyCommentCell"];
    
    


}

- (void)setUserModel:(UserModel *)userModel{

    if (_userModel != userModel) {
        _userModel = userModel;
    }
    _myMaterialView.userModel = userModel;
    self.tableHeaderView = _tableHeaderView;
}

#pragma mark - datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return _layoutFrameArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    MyCommentCell  *cell = [tableView dequeueReusableCellWithIdentifier:@"MyCommentCell" forIndexPath:indexPath];
    cell.layoutFrame = _layoutFrameArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    WeiboViewLayoutFrame *weiboLayoutFrame = self.layoutFrameArray[indexPath.row];
    
    CGRect frame = weiboLayoutFrame.frame;
    CGFloat height = frame.size.height;
    
    return   height + 86 ;
    
    
}



@end
