//
//  ActivityShareTextViewManager.m
//  ActivityShare
//
//  Created by Cain on 5/8/16.
//  Copyright © 2016年 Cain. All rights reserved.
//

#import "ActivityShareTextViewManager.h"
#import "ActivityShareTextController.h"
#import "ActivityShareTextView.h"

@interface ActivityShareTextViewManager()

@property (nonatomic, strong) ActivityShareTextController *shareTextController;
@property (nonatomic, strong) ActivityShareTextView       *activityShareTextView;

@end

@implementation ActivityShareTextViewManager

- (instancetype)initTextViewManagerWithController:(UIViewController *)controller {
    
    if (self = [super init]) {
        _shareTextController = (ActivityShareTextController *)controller;
    }
    
    return self;
}

- (void)reloadTextViewManager {
    
    [self.shareTextController.view addSubview:self.activityShareTextView];
    
    [self addConstraints];
}

- (void)addConstraints {
    
    [self.activityShareTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.shareTextController.view).offset(64);
        make.left.right.equalTo(self.shareTextController.view);
        make.height.equalTo(self.shareTextController.view).multipliedBy(0.3);
    }];
}

- (ActivityShareTextView *)activityShareTextView {
    
    CAL_GET_METHOD_RETURN_OBJC(_activityShareTextView);
    CAL_WEAK_SELF(weakSelf);
    
    _activityShareTextView = [[ActivityShareTextView alloc] init];
    
    [_activityShareTextView setActivityShareBlock:^{
        
        CALActivityController *activityController = [[CALActivityController alloc] initActivityControllerWithContent:@[weakSelf.activityShareTextView.textView.text]];

        activityController.customShareMessage.shareDescription = weakSelf.activityShareTextView.textView.text;
        activityController.customShareMessage.shareTitle       = weakSelf.activityShareTextView.textView.text;

        [weakSelf.shareTextController presentViewController:activityController
                                                   animated:YES
                                                 completion:nil];
    }];
    
    return _activityShareTextView;
}

@end
