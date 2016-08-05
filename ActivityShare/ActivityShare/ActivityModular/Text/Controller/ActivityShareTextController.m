//
//  ActivityShareTextController.m
//  ActivityShare
//
//  Created by Cain on 5/8/16.
//  Copyright © 2016年 Cain. All rights reserved.
//

#import "ActivityShareTextController.h"
#import "ActivityShareTextViewManager.h"

@interface ActivityShareTextController ()

@property (nonatomic, strong) ActivityShareTextViewManager *activityShareTextViewManager;

@end

@implementation ActivityShareTextController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Text";
    
    self.view.backgroundColor = LINE_COLOR;
    
    [self.activityShareTextViewManager reloadTextViewManager];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (ActivityShareTextViewManager *)activityShareTextViewManager {
    
    CAL_GET_METHOD_RETURN_OBJC(_activityShareTextViewManager);
    
    _activityShareTextViewManager = [[ActivityShareTextViewManager alloc] initTextViewManagerWithController:self];
    
    return _activityShareTextViewManager;
}

@end
