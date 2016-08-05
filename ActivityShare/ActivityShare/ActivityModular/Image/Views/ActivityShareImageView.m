//
//  ActivityShareImageView.m
//  ActivityShare
//
//  Created by Cain on 5/8/16.
//  Copyright © 2016年 Cain. All rights reserved.
//

#import "ActivityShareImageView.h"

@interface ActivityShareImageView()

@property (nonatomic, strong, readwrite) UIImageView *shareImageView;

@property (nonatomic, strong) UIButton *addImageButton;
@property (nonatomic, strong) UIButton *shareButton;

@end

@implementation ActivityShareImageView

- (instancetype)init {
    
    if (self = [super init]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:self.shareImageView];
        [self addSubview:self.addImageButton];
        [self addSubview:self.shareButton];

        [self addConstraints];
    }
    
    return self;
}

- (void)addConstraints {
    
    [self.shareImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        (void)make.top.left;
        make.width.height.mas_equalTo(CAL_SCREEN_WIDTH / 2);
    }];
    
    [self.addImageButton mas_makeConstraints:^(MASConstraintMaker *make) {
        (void)make.top.right;
        make.width.height.mas_equalTo(CAL_SCREEN_WIDTH / 2);
    }];
    
    [self.shareButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(CAL_WIDTH_TO_FIT(-40));
        make.width.equalTo(self).multipliedBy(0.5);
        make.centerX.equalTo(self);
    }];
}

#pragma mark - Init Share Image View
- (UIImageView *)shareImageView {
    
    CAL_GET_METHOD_RETURN_OBJC(_shareImageView);
    
    _shareImageView = [[UIImageView alloc] init];
    _shareImageView.backgroundColor = [UIColor cyanColor];
    
    _shareImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    return _shareImageView;
}

#pragma mark - Init Add Image Button
- (UIButton *)addImageButton {
    
    CAL_GET_METHOD_RETURN_OBJC(_addImageButton);
    
    _addImageButton = [UIButton buttonWithType:UIButtonTypeSystem];
    
    _addImageButton.layer.borderColor = LINE_COLOR.CGColor;
    _addImageButton.layer.borderWidth = 10;
    _addImageButton.tintColor = [UIColor blackColor];
    _addImageButton.titleLabel.textColor = [UIColor blackColor];

    [_addImageButton setTitle:@"添加图片"
                     forState:UIControlStateNormal];
    
    [_addImageButton addTarget:self
                        action:@selector(addImageButtonAction)
              forControlEvents:UIControlEventTouchUpInside];
    
    return _addImageButton;
}

- (void)addImageButtonAction {
    
    if (self.activityShareImageBlock) {
        self.activityShareImageBlock();
    }
}

#pragma mark - Init Share Button
- (UIButton *)shareButton {
    
    CAL_GET_METHOD_RETURN_OBJC(_shareButton);
    
    _shareButton = [UIButton buttonWithType:UIButtonTypeSystem];
    
    _shareButton.clipsToBounds = YES;
    _shareButton.layer.cornerRadius = 8.f;
    _shareButton.backgroundColor = [UIColor cyanColor];
    _shareButton.titleLabel.textColor = [UIColor blackColor];
    _shareButton.tintColor = [UIColor blackColor];
    
    [_shareButton setTitle:@"分享"
                  forState:UIControlStateNormal];
    [_shareButton addTarget:self
                     action:@selector(shareButtonAction)
           forControlEvents:UIControlEventTouchUpInside];
    
    return _shareButton;
}

- (void)shareButtonAction {
    
    if (self.activityShareBlock) {
        self.activityShareBlock();
    }
}

@end
