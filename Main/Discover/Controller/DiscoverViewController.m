//
//  DiscoverViewController.m
//  WeiboPlus
//
//  Created by wol on 15/9/7.
//  Copyright (c) 2015年 wol. All rights reserved.
//

#import "DiscoverViewController.h"
#import "NearByViewController.h"
@interface DiscoverViewController ()

@end

@implementation DiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavItem];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)nearByWeiBoAction:(id)sender {
    NearByViewController *near = [[NearByViewController alloc]init];
    [self.navigationController  pushViewController:near animated:YES];
}
@end
