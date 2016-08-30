//
//  LXQAlertActionTests.m
//  LXQAlertActionTests
//
//  Created by 用户 on 16/7/29.
//  Copyright © 2016年 XinQianLiu. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "LXQAlertActionView.h"

@interface LXQAlertActionTests : XCTestCase

@property (nonatomic, strong) NSArray *titlesArray;
@property (nonatomic, strong) NSArray *colorsArray;

@end

@implementation LXQAlertActionTests

- (void)setUp {
    [super setUp];
    _titlesArray = @[@"访问相册", @"访问相机", @"取消"];
    _colorsArray = @[[UIColor redColor], [UIColor blackColor], [UIColor yellowColor]];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    _titlesArray = nil;
    _colorsArray = nil;
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testInitialization {
    LXQAlertActionView *alertActionView = [[LXQAlertActionView alloc] initWithTitlesArray:_titlesArray titleColorsArray:_colorsArray backgroundColorsArray:_colorsArray];
    XCTAssertNotNil(alertActionView);
    XCTAssertNotNil(alertActionView.titlesArray);
    XCTAssertNotNil(alertActionView.titleColorsArray);
    XCTAssertNotNil(alertActionView.backgroundColorsArray);
    XCTAssertNotNil(alertActionView.alertActionButtonArray);
}

- (void)testShow{
    LXQAlertActionView *alertActionView = [[LXQAlertActionView alloc] initWithTitlesArray:_titlesArray titleColorsArray:_colorsArray backgroundColorsArray:_colorsArray];
    [alertActionView showWithTouchDone:nil];
    XCTAssertNotNil(alertActionView.overlayWindow);
    XCTAssertFalse(alertActionView.overlayWindow.hidden);
    XCTAssertNotNil(alertActionView.superview);
    XCTAssertEqual(alertActionView.alertActionButtonArray.count, alertActionView.titleColorsArray.count);
    XCTAssertNotNil(alertActionView.KBackgroundView);
}

- (void)testTouchDone
{
    LXQAlertActionView  *alertActionView = [[LXQAlertActionView alloc] initWithTitlesArray:_titlesArray titleColorsArray:_colorsArray backgroundColorsArray:_colorsArray];
    XCTestExpectation   *expectation = [self expectationWithDescription:@"点击回调应该被响应"];
    
    [alertActionView showWithTouchDone:^(NSInteger touchIndex) {
        if (touchIndex == 1001) {
            [alertActionView dismiss];
        }
    }];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (alertActionView.touchDoneBlock) {
            alertActionView.touchDoneBlock(1001);
        }
        
        [expectation fulfill];
    });
    [self waitForExpectationsWithTimeout:5.0f handler:nil];
}

- (void)testDismiss{
    LXQAlertActionView *alertActionView = [[LXQAlertActionView alloc] initWithTitlesArray:_titlesArray titleColorsArray:_colorsArray backgroundColorsArray:_colorsArray];
    [alertActionView showWithTouchDone:nil];
    [alertActionView dismiss];
    XCTestExpectation *expectation = [self expectationWithDescription:@"视图应该移除"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        XCTAssertNil(alertActionView.overlayWindow);
        XCTAssertNil(alertActionView.superview);
        XCTAssertNil(alertActionView.KBackgroundView);
        XCTAssertEqual(alertActionView.alertActionButtonArray.count, 0);
        [expectation fulfill];
    });
    [self waitForExpectationsWithTimeout:5.0f handler:nil];
}
@end
