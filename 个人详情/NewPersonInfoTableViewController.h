//
//  NewPersonInfoTableViewController.h
//  个人详情
//
//  Created by Meeno5 on 16/4/28.
//  Copyright © 2016年 Meeno5. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NewPersonInfoTableViewControllerDelegate <NSObject>

@optional
- (void)newPersonInfoTableViewControllerOffsetChange:(CGFloat)offset;

@end

@interface NewPersonInfoTableViewController : UITableViewController

@property (nonatomic, weak) id<NewPersonInfoTableViewControllerDelegate>delegate;

@property (nonatomic, assign) CGFloat currtentOffSet;

@end
