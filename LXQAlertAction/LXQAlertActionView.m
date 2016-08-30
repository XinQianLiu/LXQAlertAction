//
//  LXQAlertActionView.m
//  LXQAlertAction
//
//  Created by 用户 on 16/7/29.
//  Copyright © 2016年 XinQianLiu. All rights reserved.
//

#import "LXQAlertActionView.h"

@class LXQRootViewController;
@interface LXQAlertActionView ()

@property (nonatomic, assign) CGFloat whiteBackgroundViewHeight;
@property (nonatomic, strong) NSLayoutConstraint *KBackgroundViewConstraintBottom;
@property (nonatomic, strong) LXQRootViewController *roorViewController;

- (void)setup;
- (void)displayTheViewAnimation;

@end

@interface LXQRootViewController : UIViewController

@property (nonatomic, strong) LXQAlertActionView *alertActionView;

@end

@implementation LXQRootViewController

- (void)loadView
{
    self.view = _alertActionView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [_alertActionView setup];
}

- (void)viewDidAppear:(BOOL)animated
{
    [_alertActionView displayTheViewAnimation];
}

#ifdef DEBUG
- (void)dealloc
{
    NSLog(@"\nRootViewController Dealloc");
}
#endif

@end

@implementation LXQAlertActionView

- (instancetype)initWithTitlesArray:(NSArray <NSString *> *)titlesArray titleColorsArray:(NSArray <UIColor *> *)titleColorsArray backgroundColorsArray:(NSArray <UIColor *> *)backgroungColorsArray
{
    self = [super init];
    
    if (self) {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.1f];
        self.frame = [UIScreen mainScreen].bounds;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        tap.numberOfTapsRequired = 1;
        tap.numberOfTouchesRequired = 1;
        [self addGestureRecognizer:tap];
        _whiteBackgroundViewHeight = titlesArray.count * 40 + (titlesArray.count - 1) * 10;
        _titlesArray = titlesArray;
        _titleColorsArray = titleColorsArray;
        _backgroundColorsArray = backgroungColorsArray;
        _alertActionButtonArray = [NSMutableArray array];
    }
    
    return self;
}

#pragma mark - Private methods
- (void)setup
{
    if (!_KBackgroundView) {
        _KBackgroundView = [[UIView alloc] initWithFrame:CGRectZero];
        if (!_KBackgroundViewBackgroundColor) {
            _KBackgroundViewBackgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5f];
        }
        _KBackgroundView.backgroundColor = _KBackgroundViewBackgroundColor;
        _KBackgroundView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:_KBackgroundView];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_KBackgroundView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_KBackgroundView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
        [_KBackgroundView addConstraint:[NSLayoutConstraint constraintWithItem:_KBackgroundView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:_whiteBackgroundViewHeight]];
        _KBackgroundViewConstraintBottom = [NSLayoutConstraint constraintWithItem:_KBackgroundView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1 constant:_whiteBackgroundViewHeight];
        [self addConstraint:_KBackgroundViewConstraintBottom];
    }
    
    if (_alertActionButtonArray.count <= 0) {
        NSInteger   count = _titlesArray.count;
        NSString    *title;
        UIColor     *titleColor;
        UIColor     *backgroundColor;
        
        for (int i = 0; i < count; i++) {
            title = _titlesArray[i];
            
            if (_titleColorsArray.count == _titlesArray.count) {
                titleColor = _titleColorsArray[i];
            }
            else {
                titleColor = [UIColor blackColor];
            }
            
            if (_backgroundColorsArray.count == _titlesArray.count) {
                backgroundColor = _backgroundColorsArray[i];
            }
            else {
                backgroundColor = [UIColor whiteColor];
            }
            
            UIButton *alertActionButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [alertActionButton setTitle:title forState:UIControlStateNormal];
            [alertActionButton setTitleColor:titleColor forState:UIControlStateNormal];
            [alertActionButton setBackgroundColor:backgroundColor];
            alertActionButton.tag = 1001 + i;
            [alertActionButton addTarget:self action:@selector(alertActionButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            alertActionButton.translatesAutoresizingMaskIntoConstraints = NO;
            [_KBackgroundView addSubview:alertActionButton];
            [self setButtonLayout:alertActionButton index:i];
            [_alertActionButtonArray addObject:alertActionButton];
        }
    }
}

- (void)setButtonLayout:(UIButton *)button index:(int)index
{
    [button addConstraint:[NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:40]];
    [_KBackgroundView addConstraint:[NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_KBackgroundView attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
    [_KBackgroundView addConstraint:[NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:_KBackgroundView attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
    [_KBackgroundView addConstraint:[NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_KBackgroundView attribute:NSLayoutAttributeTop multiplier:1 constant:index * 40 + index * 10]];
}

- (void)addOverlayWindow
{
    if (!_roorViewController) {
        _roorViewController = [[LXQRootViewController alloc] initWithNibName:nil bundle:nil];
        _roorViewController.alertActionView = self;
    }
    
    if (!_overlayWindow) {
        _overlayWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _overlayWindow.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _overlayWindow.opaque = NO;
        _overlayWindow.rootViewController = _roorViewController;
        _overlayWindow.hidden = NO;
    }
}

- (void)displayTheViewAnimation
{
    [self removeConstraint:_KBackgroundViewConstraintBottom];
    _KBackgroundViewConstraintBottom = [NSLayoutConstraint constraintWithItem:_KBackgroundView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    [self addConstraint:_KBackgroundViewConstraintBottom];
    [UIView animateWithDuration:.3 animations:^{
        [self setNeedsLayout];
        [self layoutIfNeeded];
    }];
}

- (void)removeTheViewAnimationDone:(void (^)(void))animationDone
{
    [self removeConstraint:_KBackgroundViewConstraintBottom];
    _KBackgroundViewConstraintBottom = [NSLayoutConstraint constraintWithItem:_KBackgroundView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1 constant:_whiteBackgroundViewHeight];
    [self addConstraint:_KBackgroundViewConstraintBottom];
    [UIView animateWithDuration:.3 animations:^{
        [self setNeedsLayout];
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        if (animationDone) {
            animationDone();
        }
    }];
}

#pragma mark - Public methods
// Display View
- (void)showWithTouchDone:(TouchDoneBlock)touchDone
{
    NSAssert([NSThread isMainThread], @"\nERROR-->  View must be displayed in the main thread\nfunction-->  - (void)showTheViewWithTouchDoneBlock:(TouchDoneBlock)touchDoneBlock");
    NSAssert(_titlesArray.count > 0, @"\nERROR-->  Titles array must be greater than 0\nfunction-->  - (void)showTheViewWithTouchDoneBlock:(TouchDoneBlock)touchDoneBlock");
    
    if (touchDone) {
        _touchDoneBlock = touchDone;
    }
    
    [self addOverlayWindow];
}

// Remove Views
- (void)dismiss
{
    [self removeTheViewAnimationDone:^{
        [self removeFromSuperview];
        
        for (UIButton *bt in _alertActionButtonArray) {
            [bt removeFromSuperview];
        }
        
        [_alertActionButtonArray removeAllObjects];
        _roorViewController = nil;
        _KBackgroundView = nil;
        _overlayWindow.hidden = YES;
        _overlayWindow = nil;
    }];
}

#pragma mark - Action
- (void)alertActionButtonClicked:(UIButton *)sender
{
    [self dismiss];
    if (_touchDoneBlock) {
        _touchDoneBlock(sender.tag);
    }
}

- (void)tap:(UITapGestureRecognizer *)sender
{
    CGPoint locationTouch = [sender locationInView:self];
    
    if (!CGRectContainsPoint(_KBackgroundView.frame, locationTouch)) {
        [self dismiss];
        if (_touchDoneBlock) {
            _touchDoneBlock(10000);
        }
    }
}

#ifdef DEBUG
- (void)dealloc
{
    NSLog(@"\nLXQAlertActionView Dealloc");
}
#endif

@end
