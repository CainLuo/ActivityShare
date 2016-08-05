//
//  ActivityShareImageViewManager.m
//  ActivityShare
//
//  Created by Cain on 5/8/16.
//  Copyright © 2016年 Cain. All rights reserved.
//

#import "ActivityShareImageViewManager.h"
#import "ActivityShareImageController.h"
#import "ActivityShareImageView.h"

@interface ActivityShareImageViewManager() <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, strong)ActivityShareImageController *activityShareImageController;
@property (nonatomic, strong)ActivityShareImageView *activityShareImageView;

@end

@implementation ActivityShareImageViewManager

- (instancetype)initImageViewManagerWithController:(UIViewController *)controller {
    
    if (self = [super init]) {
        _activityShareImageController = (ActivityShareImageController *)controller;
    }
    
    return self;
}

- (void)reloadImageViewManager {
    
    [self.activityShareImageController.view addSubview:self.activityShareImageView];
    
    [self addConstraints];
}

- (void)addConstraints {
    
    [self.activityShareImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.activityShareImageController.view).offset(64);
        make.left.right.equalTo(self.activityShareImageController.view);
        make.height.equalTo(self.activityShareImageController.view).multipliedBy(0.4);
    }];
}

#pragma mark - Init Activity Share Image View
- (ActivityShareImageView *)activityShareImageView {
    
    CAL_GET_METHOD_RETURN_OBJC(_activityShareImageView);
    
    _activityShareImageView = [[ActivityShareImageView alloc] init];
    
    CAL_WEAK_SELF(weakSelf);
    
    [_activityShareImageView setActivityShareImageBlock:^{
        [weakSelf chooseImage];
    }];
    
    [_activityShareImageView setActivityShareBlock:^{
        
        if (weakSelf.activityShareImageView.shareImageView.image) {
            
            CALActivityController *activityController = [[CALActivityController alloc] initActivityControllerWithContent:@[weakSelf.activityShareImageView.shareImageView.image]];
            
            activityController.customShareMessage.shareImage = weakSelf.activityShareImageView.shareImageView.image;
            
            [weakSelf.activityShareImageController presentViewController:activityController
                                                                animated:YES
                                                              completion:nil];
        } else {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示"
                                                                message:@"您尚未选择需要分享的图片, 请选择图片后再尝试"
                                                               delegate:nil
                                                      cancelButtonTitle:@"确定"
                                                      otherButtonTitles:nil, nil];
            
            [alertView show];
        }
    }];
    
    return _activityShareImageView;
}

#pragma mark - Init Image Picker Controller
- (void)chooseImage {
    
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePickerController.allowsEditing = true;
    imagePickerController.delegate = self;
    
    [self.activityShareImageController presentViewController:imagePickerController
                                                    animated:YES
                                                  completion:nil];
}

#pragma mark - Image Picker Controller Delegate
- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    [self.activityShareImageController dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *image = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    
    self.activityShareImageView.shareImageView.image = image;
}

@end
