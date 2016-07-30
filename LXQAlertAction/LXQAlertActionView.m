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

@property (nonatomic, assign) CGFloat screenHeight;
@property (nonatomic, assign) CGFloat screenWidth;
@property (nonatomic, assign) CGFloat whiteBackgroundViewHeight;
@property (nonatomic, strong) NSLayoutConstraint *KBackgroundViewConstraintBottom;
@property (nonatomic, strong) LXQRootViewController *roorViewController;

- (void)setup;
- (void)displayTheViewAnimation;
- (void)resetTransition;

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

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [_alertActionView resetTransition];
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{

}

#ifdef __IPHONE_7_0
- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]) {
        [self setNeedsStatusBarAppearanceUpdate];
    }
}
#endif

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    UIViewController *viewController = [_alertActionView.keyWindow currentViewController];
    
    if (viewController) {
        return [viewController supportedInterfaceOrientations];
    }
    
    return UIInterfaceOrientationMaskAll;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    UIViewController *viewController = [_alertActionView.keyWindow currentViewController];
    
    if (viewController) {
        return [viewController shouldAutorotateToInterfaceOrientation:toInterfaceOrientation];
    }
    
    return YES;
}

- (BOOL)shouldAutorotate
{
    UIViewController *viewController = [_alertActionView.keyWindow currentViewController];
    
    if (viewController) {
        return [viewController shouldAutorotate];
    }
    
    return YES;
}

#ifdef __IPHONE_7_0
- (UIStatusBarStyle)preferredStatusBarStyle
{
    UIWindow *window = _alertActionView.keyWindow;
    
    if (!window) {
        window = [UIApplication sharedApplication].keyWindow;
    }
    
    return [[window viewControllerForStatusBarStyle] preferredStatusBarStyle];
}

- (BOOL)prefersStatusBarHidden
{
    UIWindow *window = _alertActionView.keyWindow;
    
    if (!window) {
        window = [UIApplication sharedApplication].keyWindow;
    }
    
    return [[window viewControllerForStatusBarHidden] prefersStatusBarHidden];
}
#endif

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
        [self setTapGestureRecognizer];
        _screenHeight = [UIScreen mainScreen].bounds.size.height;
        _screenWidth = [UIScreen mainScreen].bounds.size.width;
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
    [self addWhiteBackgroundView];
    [self addAlertActionButton];
}

- (void)setTapGestureRecognizer
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    [self addGestureRecognizer:tap];
}

- (void)addWhiteBackgroundView
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
}

- (void)addAlertActionButton
{
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

- (void)setButtonLayout:(UIButton *)button index:(int)index
{
    [button addConstraint:[NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:40]];
    [_KBackgroundView addConstraint:[NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_KBackgroundView attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
    [_KBackgroundView addConstraint:[NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:_KBackgroundView attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
    [_KBackgroundView addConstraint:[NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_KBackgroundView attribute:NSLayoutAttributeTop multiplier:1 constant:index * 40 + index * 10]];
}

- (void)addOverlayWindow
{
    [self addKeyWindow];
    [self addRootViewController];
    if (!_overlayWindow) {
        _overlayWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _overlayWindow.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _overlayWindow.opaque = NO;
        _overlayWindow.rootViewController = _roorViewController;
        [_overlayWindow makeKeyAndVisible];
    }
}

- (void)addKeyWindow
{
    if (!_keyWindow) {
        _keyWindow = [UIApplication sharedApplication].keyWindow;
    }
}

- (void)addRootViewController
{
    if (!_roorViewController) {
        _roorViewController = [[LXQRootViewController alloc] initWithNibName:nil bundle:nil];
        _roorViewController.alertActionView = self;
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

- (void)resetTransition
{
    [_KBackgroundView.layer removeAllAnimations];
    [self.layer removeAllAnimations];
}

#pragma mark - Public methods
// Display View
- (void)showTheViewWithTouchDoneBlock:(TouchDoneBlock)touchDoneBlock
{
    NSAssert([NSThread isMainThread], @"\nERROR-->  View must be displayed in the main thread\nfunction-->  - (void)showTheViewWithTouchDoneBlock:(TouchDoneBlock)touchDoneBlock");
    NSAssert(_titlesArray.count > 0, @"\nERROR-->  Titles array must be greater than 0\nfunction-->  - (void)showTheViewWithTouchDoneBlock:(TouchDoneBlock)touchDoneBlock");
    
    if (touchDoneBlock) {
        _touchDoneBlock = touchDoneBlock;
    }
    
    [self addOverlayWindow];
}

// Remove Views
- (void)dismiss
{
    [self removeTheViewAnimationDone:^{
        [self removeFromSuperview];
        [_KBackgroundView removeFromSuperview];
        _KBackgroundView = nil;
        
        for (UIButton *bt in _alertActionButtonArray) {
            [bt removeFromSuperview];
        }
        
        [_alertActionButtonArray removeAllObjects];
        
        _roorViewController = nil;
        
        if (_overlayWindow) {
            [_overlayWindow removeFromSuperview];
            NSMutableArray *windows = (NSMutableArray *)[UIApplication sharedApplication].windows;
            [windows removeObject:_overlayWindow];
            _overlayWindow = nil;
            [windows enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(UIWindow *window, NSUInteger idx, BOOL *_Nonnull stop) {
                if ([window isKindOfClass:[UIWindow class]] && (window.windowLevel == UIWindowLevelNormal)) {
                    [window makeKeyWindow];
                    *stop = YES;
                }
            }];
        }
        
        if (_keyWindow) {
            [_keyWindow removeFromSuperview];
            _keyWindow = nil;
        }
    }];
}

#pragma mark - Action
- (void)alertActionButtonClicked:(UIButton *)sender
{
    if (_touchDoneBlock) {
        _touchDoneBlock(sender.tag);
    }
}

- (void)tap:(UITapGestureRecognizer *)sender
{
    CGPoint locationTouch = [sender locationInView:self];
    if (!CGRectContainsPoint(_KBackgroundView.frame, locationTouch)) {
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
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
