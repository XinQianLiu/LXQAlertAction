//
//  LXQAlertActionView.h
//  LXQAlertAction
//
//  Created by 用户 on 16/7/29.
//  Copyright © 2016年 XinQianLiu. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  touch feedback
 *
 *  @param touchIndex Touch index value , As UITapGestureRecognizer trigger if touchIndex == 10000
 */
typedef void(^TouchDoneBlock)(NSInteger touchIndex);

@interface LXQAlertActionView : UIView

/**
*  Initialization LXQAlertActionView
*
*  @param titlesArray           Button Names
*  @param titleColorsArray      Button Title Colors , Default Black
*  @param backgroungColorsArray Button Background Colors , Default White
*
*  @return LXQAlertActionView Object
*/
- (instancetype)initWithTitlesArray:(NSArray <NSString *> *)titlesArray titleColorsArray:(NSArray <UIColor *> *)titleColorsArray backgroundColorsArray:(NSArray <UIColor *> *)backgroungColorsArray;



@property (nonatomic, readonly, strong) UIWindow                    *overlayWindow;
@property (nonatomic, readonly, strong) UIView                      *KBackgroundView;
// Default [[UIColor whiteColor] colorWithAlphaComponent:0.5f]
@property (nonatomic, strong) UIColor                               *KBackgroundViewBackgroundColor;
// Button Names
@property (nonatomic, readonly, strong) NSArray <NSString *>        *titlesArray;
// Button Title Colors
@property (nonatomic, readonly, strong) NSArray <UIColor *>         *titleColorsArray;
// Button Background Colors
@property (nonatomic, readonly, strong) NSArray <UIColor *>         *backgroundColorsArray;
@property (nonatomic, readonly, strong) NSMutableArray <UIButton *> *alertActionButtonArray;
@property (nonatomic, readonly, copy) TouchDoneBlock                touchDoneBlock;



/**
 *  Display View
 *
 *  @param touchDoneBlock touch feedback
 */
- (void)showTheViewWithTouchDoneBlock:(TouchDoneBlock)touchDoneBlock;



/**
 *  Remove Views
 */
- (void)dismiss;
@end
