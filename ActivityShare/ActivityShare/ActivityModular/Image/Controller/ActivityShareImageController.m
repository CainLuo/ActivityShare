//
//  ActivityShareImageController.m
//  ActivityShare
//
//  Created by Cain on 5/8/16.
//  Copyright © 2016年 Cain. All rights reserved.
//

#import "ActivityShareImageController.h"
#import "ActivityShareImageViewManager.h"

@interface ActivityShareImageController ()

@property (nonatomic, strong) ActivityShareImageViewManager *activityShareImageViewManager;

@end

@implementation ActivityShareImageController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Image";
    
    self.view.backgroundColor = LINE_COLOR;
    
    [self.activityShareImageViewManager reloadImageViewManager];
}

- (ActivityShareImageViewManager *)activityShareImageViewManager {
    
    CAL_GET_METHOD_RETURN_OBJC(_activityShareImageViewManager);
    
    _activityShareImageViewManager = [[ActivityShareImageViewManager alloc] initImageViewManagerWithController:self];
    
    return _activityShareImageViewManager;
}

@end
