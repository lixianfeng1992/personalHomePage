//
//  NewPersonInfoViewController.m
//  个人详情
//
//  Created by Meeno5 on 16/4/28.
//  Copyright © 2016年 Meeno5. All rights reserved.
//

#import "NewPersonInfoViewController.h"
#import "Masonry.h"
#import "NewPersonInfoTableViewController.h"

@interface NewPersonInfoViewController ()<NewPersonInfoTableViewControllerDelegate>

@property (nonatomic, assign) CGFloat alphaMemory;

@property (strong, nonatomic) UITableViewController *currentController;

@property (nonatomic, weak) UIView *segmentView;

@end

@implementation NewPersonInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self creatHeaderBgView];
    
    [self setNavi];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // 即将显示的时候做一次初始化操作
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //设置切换控制器
        [self setupChildView];
        //设置切换按钮
        [self setSegmentViewChildViews];
    });
    
}

- (void)setNavi
{
    if ([self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

- (void)setupChildView
{
    for (int i = 0; i < self.childViewControllers.count; i++) {
        NewPersonInfoTableViewController *childVC = self.childViewControllers[i];
        if (i == 0) {
            [self.view addSubview:childVC.tableView];
            _currentController = childVC;
        }
        childVC.delegate = self;
    }
    [self.view bringSubviewToFront:self.segmentView];
}

- (void)creatHeaderBgView
{
    UIView *headImageView = [UIView new];
    self.bgHeadView = headImageView;
    [self.view addSubview:headImageView];
    [headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(XFHeadViewH + 20);
    }];
    
    UIImageView *headBgImageView = [UIImageView new];
    headBgImageView.image = [UIImage imageNamed:@"headView_bg"];
    headBgImageView.contentMode = UIViewContentModeScaleAspectFill;
    headBgImageView.layer.masksToBounds = YES;
    [headImageView addSubview:headBgImageView];
    [headBgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.mas_equalTo(0);
    }];
    
    UIView *segmentView = [UIView new];
    segmentView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:segmentView];
    [segmentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(headImageView.mas_bottom).mas_equalTo(0);
        make.right.left.mas_equalTo(0);
        make.height.mas_equalTo(XFTabBarH);
    }];
    self.segmentView = segmentView;
    
    UIImageView *iconView = [UIImageView new];
    iconView.layer.cornerRadius = 50;
    iconView.layer.masksToBounds = YES;
    iconView.backgroundColor = [UIColor blueColor];
    [headImageView addSubview:iconView];
    [iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(100, 100));
        make.bottom.mas_equalTo(-64);
    }];
}

- (void)setSegmentViewChildViews
{
    for (int i = 0; i < self.childViewControllers.count; i++) {
        UIButton *btn = [[UIButton alloc] init];
        btn.tag = i;
        btn.frame = CGRectMake(kScreenW / 3 * i, 0, kScreenW / 3, XFTabBarH);
        [btn setTitle:self.childViewControllers[i].title forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(segmentViewBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.segmentView addSubview:btn];
    }
}

- (void)segmentViewBtnClick:(UIButton *)btn
{
    UITableViewController *targetViewController = nil;
    
    CGFloat offset = ((NewPersonInfoTableViewController *)_currentController).currtentOffSet;

    targetViewController = self.childViewControllers[btn.tag];
    
    if (targetViewController != nil && targetViewController != _currentController) {
        [_currentController willMoveToParentViewController:nil];
        [self transitionFromViewController:_currentController toViewController:targetViewController duration:0.1 options:UIViewAnimationOptionCurveLinear animations:nil completion:^(BOOL finished) {
            [targetViewController didMoveToParentViewController:self];
            _currentController = targetViewController;
        }];
        
        if (-offset - 44 > XFHeadViewH - 20) {
            targetViewController.tableView.contentOffset = CGPointMake(0, offset);
        }
        else{
            targetViewController.tableView.contentOffset = CGPointMake(0, -44 - XFTabBarH);
        }
    }
    [self.view bringSubviewToFront:self.segmentView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
