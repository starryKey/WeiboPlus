//
//  LeftViewController.m
//  WeiboPlus
//
//  Created by wol on 15/9/10.
//  Copyright (c) 2015年 wol. All rights reserved.
//

#import "LeftViewController.h"
#import "ThemeLabel.h"
#import "MMExampleDrawerVisualStateManager.h"
@interface LeftViewController ()
{
    UITableView *_tableView;
    NSArray *_rowsArray;
    NSArray *_sectionsArray;
}
@end

@implementation LeftViewController

- (instancetype)initWithCoder:(NSCoder *)aDecoder{

    self = [super initWithCoder:aDecoder];
    if (self ) {
        
    }

    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
   self.view.backgroundColor = [UIColor clearColor];
   [self _createTableViews];
   [self _loadData];
   [self setBgImage];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void)_createTableViews{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 150, kScreenHeight) style:UITableViewStyleGrouped];
    _tableView.backgroundColor = nil;
    _tableView.backgroundView = nil;
    

    _tableView.delegate = self;
    _tableView.dataSource = self;
    //_tableView.backgroundColor = [UIColor whiteColor];
    //设置坐标转换
    _tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    
    [self.view addSubview:_tableView];


}

- (void)_loadData{

    _sectionsArray = @[@"页面切换效果",@"图片浏览模式"];
    _rowsArray = @[@[@"无",@"偏移",@"偏移&缩放",@"旋转",@"视差"],@[@"小图",@"大图"]];

    
    
}


#pragma mark - DataSource delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _sectionsArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_rowsArray[section] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"leftCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"leftCell"];
        
    }
    cell.textLabel.text = _rowsArray[indexPath.section][indexPath.row];
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    ThemeLabel  *sectionLable = [[ThemeLabel alloc]initWithFrame:CGRectMake(0, 0, 150, 50)];
    sectionLable.colorName = @"More_Item_Text_color";
    sectionLable.backgroundColor = [UIColor clearColor];
    sectionLable.font = [UIFont boldSystemFontOfSize:18];
    sectionLable.text = [NSString stringWithFormat:@"  %@",_sectionsArray[section]];
    return sectionLable;
    

    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 50;
}

@end
