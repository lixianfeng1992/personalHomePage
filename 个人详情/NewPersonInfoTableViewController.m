//
//  NewPersonInfoTableViewController.m
//  个人详情
//
//  Created by Meeno5 on 16/4/28.
//  Copyright © 2016年 Meeno5. All rights reserved.
//

#import "NewPersonInfoTableViewController.h"

@interface NewPersonInfoTableViewController ()

@property (nonatomic, assign) CGFloat lastOffsetY;

@end

@implementation NewPersonInfoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    _lastOffsetY = -(XFHeadViewH + XFTabBarH);
    
    self.tableView.contentInset = UIEdgeInsetsMake(XFHeadViewH + XFTabBarH , 0, 0, 0);
    
    self.tableView.backgroundColor = [UIColor clearColor];
    
    self.tableView.tableFooterView = [UIView new];
    
    if (self.tableView.contentSize.height < kScreenH - 108) {
        self.tableView.contentInset = UIEdgeInsetsMake(XFHeadViewH + XFTabBarH , 0, kScreenH - 108 - self.tableView.contentSize.height, 0);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"personCell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"personCell"];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%d", (int)indexPath.row];
    
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 获取当前偏移量
    CGFloat offsetY = scrollView.contentOffset.y;
    
    // 获取偏移量差值
    CGFloat delta = offsetY - _lastOffsetY;
    
    CGFloat headH = XFHeadViewH - delta + 20;
    
    if (headH < XFHeadViewMinH) {
        headH = XFHeadViewMinH;
    }
    
    CGFloat alpha = delta / (XFHeadViewH - XFHeadViewMinH);
    
    
    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:alpha];
    
    _currtentOffSet = scrollView.contentOffset.y;

    if ([self.delegate respondsToSelector:@selector(newPersonInfoTableViewControllerOffsetChange:)]) {
        [self.delegate newPersonInfoTableViewControllerOffsetChange:headH];
    }
}

@end
