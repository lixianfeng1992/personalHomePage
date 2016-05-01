//
//  NewUserInfoViewController.m
//  个人详情
//
//  Created by Meeno5 on 16/4/28.
//  Copyright © 2016年 Meeno5. All rights reserved.
//


#import "NewUserInfoViewController.h"
#import "Masonry.h"
#import "NewExpertTableViewController.h"
#import "NewActivityTableViewController.h"
#import "NewInfomationTableViewController.h"
#import "NewPersonInfoTableViewController.h"

@interface NewUserInfoViewController ()<NewPersonInfoTableViewControllerDelegate>
@property (nonatomic, strong) NewExpertTableViewController *expertVC;
@property (strong, nonatomic) UITableViewController *currentController;
@property (nonatomic, strong) NewActivityTableViewController *activityVC;
@property (nonatomic, strong) NewInfomationTableViewController *infomationVC;
@end

@implementation NewUserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setChildControllers];
}

- (void)setChildControllers
{
    _expertVC = [[NewExpertTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    _expertVC.title = @"主页";
    [self addChildViewController:_expertVC];
    
    _activityVC = [[NewActivityTableViewController alloc] init];
    _activityVC.title = @"微博";
    [self addChildViewController:self.activityVC];

    _infomationVC = [[NewInfomationTableViewController alloc] init];
    _infomationVC.title = @"相册";
    [self addChildViewController:self.infomationVC];
}

//更新顶部view高度约束
- (void)newPersonInfoTableViewControllerOffsetChange:(CGFloat)offset
{
    [self.bgHeadView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(offset);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
