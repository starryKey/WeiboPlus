//
//  ThemeTableViewController.m
//  WeiboPlus
//
//  Created by wol on 15/9/11.
//  Copyright (c) 2015年 wol. All rights reserved.
//

#import "ThemeTableViewController.h"
#import "MoreTableViewCell.h"
@interface ThemeTableViewController ()

@end

@implementation ThemeTableViewController{

    NSArray *themeNameArray;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {

    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;

}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //加载主题名
    NSString *path = [[NSBundle mainBundle]pathForResource:@"theme.plist" ofType:nil];
    
    NSDictionary *themeConfig = [NSDictionary dictionaryWithContentsOfFile:path];
    
    themeNameArray = [themeConfig   allKeys];
    NSLog(@"themeNameArray :%@",themeNameArray);
    [self.tableView registerClass:[ MoreTableViewCell class] forCellReuseIdentifier:@"moreCell"];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return themeNameArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   MoreTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"moreCell" forIndexPath:indexPath];
    
    cell.themeTextLabel.text = themeNameArray[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    NSString *themeName = themeNameArray[indexPath.row];
    [[ThemeManager shareInstance] setThemeName:themeName];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}



@end
