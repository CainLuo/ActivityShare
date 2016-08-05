//
//  ActivityShareController.m
//  ActivityShare
//
//  Created by Cain on 5/8/16.
//  Copyright © 2016年 Cain. All rights reserved.
//

#import "ActivityShareController.h"
#import "ActivityShareViewManager.h"

@interface ActivityShareController ()

@property (nonatomic, strong) ActivityShareViewManager *activityShareViewManager;

@property (nonatomic, strong) UITableView *shareTypeTableView;

@end

@implementation ActivityShareController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"ActivityShare";
    
    [self.view addSubview:self.shareTypeTableView];
    
    NSArray *shareType = @[@"文本", @"图片", @"图文", @"链接", @"文件"];
    
    self.activityShareViewManager.dataSource = shareType;
    
    [self.activityShareViewManager reloadViewManegerWithTableView:self.shareTypeTableView];
}

- (ActivityShareViewManager *)activityShareViewManager {
    
    CAL_GET_METHOD_RETURN_OBJC(_activityShareViewManager);
    
    _activityShareViewManager = [[ActivityShareViewManager alloc] initViewManagerWithController:self];
    
    return _activityShareViewManager;
}

- (UITableView *)shareTypeTableView {
    
    CAL_GET_METHOD_RETURN_OBJC(_shareTypeTableView);
    
    _shareTypeTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, CAL_SCREEN_WIDTH, CAL_SCREEN_HEIGHT)];
    
    _shareTypeTableView.dataSource = self.activityShareViewManager;
    _shareTypeTableView.delegate   = self.activityShareViewManager;
    
    _shareTypeTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    return _shareTypeTableView;
}

@end
