//
//  LXQViewController.m
//  LXQAlertAction
//
//  Created by 用户 on 16/7/29.
//  Copyright © 2016年 XinQianLiu. All rights reserved.
//

#import "LXQViewController.h"
#import "LXQAlertActionView.h"
#import "LXQTestViewController.h"

@interface LXQViewController ()
@property (nonatomic, strong) LXQAlertActionView *alertActionView;
@end

@implementation LXQViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIButton *bt = [UIButton buttonWithType:UIButtonTypeSystem];
    bt.backgroundColor = [UIColor redColor];
    bt.frame = CGRectMake(50, 50, 100, 30);
    [bt addTarget:self action:@selector(btClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bt];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)btClicked
{
    if (!_alertActionView) {
        UIColor *blackColor = [UIColor blackColor];
        UIColor *redColor = [UIColor redColor];
        _alertActionView = [[LXQAlertActionView alloc] initWithTitlesArray:@[@"访问相册", @"访问相机", @"取消"] titleColorsArray:@[blackColor, blackColor, redColor] backgroundColorsArray:nil];
//        _alertActionView.KBackgroundViewBackgroundColor = [UIColor blackColor];
    }
    
    
    [_alertActionView showTheViewWithTouchDoneBlock:^(NSInteger touchIndex) {
        if (touchIndex == 1001) {
            LXQTestViewController *vc = [[LXQTestViewController alloc] init];
            [self presentViewController:vc animated:YES completion:nil];
        }
        else if (touchIndex == 1002) {
            
        }
        else if (touchIndex == 1003){

        }
        else{// As UITapGestureRecognizer trigger , if touchIndex == 10000

        }
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
