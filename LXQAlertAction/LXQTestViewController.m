//
//  LXQTestViewController.m
//  LXQAlertAction
//
//  Created by 用户 on 16/7/29.
//  Copyright © 2016年 XinQianLiu. All rights reserved.
//

#import "LXQTestViewController.h"

@implementation LXQTestViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *bt = [UIButton buttonWithType:UIButtonTypeSystem];
    bt.backgroundColor = [UIColor redColor];
    bt.frame = CGRectMake(50, 50, 100, 30);
    [bt addTarget:self action:@selector(btClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bt];
}

- (void)btClicked
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)dealloc
{
    NSLog(@"TestViewController Dealloc");
}
@end
