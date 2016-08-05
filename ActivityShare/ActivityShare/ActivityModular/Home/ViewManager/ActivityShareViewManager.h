//
//  ActivityShareViewManager.h
//  ActivityShare
//
//  Created by Cain on 5/8/16.
//  Copyright © 2016年 Cain. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ActivityShareViewManager : NSObject <UITableViewDelegate, UITableViewDataSource>

- (instancetype)initViewManagerWithController:(UIViewController *)controller;

- (void)reloadViewManegerWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) NSArray *dataSource;

@end
