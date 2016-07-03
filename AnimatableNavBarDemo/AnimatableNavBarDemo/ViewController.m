//
//  ViewController.m
//  AnimatableNavBarDemo
//
//  Created by shicuf on 16/7/2.
//  Copyright © 2016年 Belle. All rights reserved.
//

#import "ViewController.h"
#import "BLCustomPagerController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)configUI {
    UIButton *pushButton = [UIButton buttonWithType:UIButtonTypeSystem];
    pushButton.frame = CGRectMake(100, 100, 80, 40);
    [pushButton setTitle:@"Push" forState:UIControlStateNormal];
    [pushButton addTarget:self action:@selector(push) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:pushButton];
}

#pragma mark - Event Response
- (void)push {
    BLCustomPagerController *pagerVc = [[BLCustomPagerController alloc] init];
//    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:pagerVc];
    [self.navigationController pushViewController:pagerVc animated:YES];
}

@end
