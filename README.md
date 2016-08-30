# LXQAlertAction
The UI UIAlertAction similar systems
![](http://a3.qpic.cn/psb?/V12vcXx72Pkh20/IPYwGKYwEGtLcIy.rDUh3yqVlfyQj8DTtKjA1M0JCC0!/m/dAoBAAAAAAAAnull&bo=dwGxAgAAAAADB.c!&rf=photolist&t=5)
## Usage
At first, import LXQAlertActionView:
```
#import "LXQAlertActionView.h"
```
The sample code, details the Demo:
```objective-c
UIColor *blackColor = [UIColor blackColor]; 
UIColor *redColor = [UIColor redColor];
LXQAlertActionView *alertActionView = [[LXQAlertActionView alloc] initWithTitlesArray:@[@"访问相册", @"访问相机", @"取消"] titleColorsArray:@[blackColor, blackColor, redColor] backgroundColorsArray:nil];
[alertActionView showWithTouchDone:^(NSInteger touchIndex) {
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
