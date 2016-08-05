//
//  ActivityShareTextView.m
//  ActivityShare
//
//  Created by Cain on 5/8/16.
//  Copyright © 2016年 Cain. All rights reserved.
//

#import "ActivityShareTextView.h"

@interface ActivityShareTextView()

@property (nonatomic, strong, readwrite) UITextView *textView;
@property (nonatomic, strong) UIButton   *shareButton;

@end

@implementation ActivityShareTextView

- (instancetype)init {
    
    if (self = [super init]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:self.textView];
        [self addSubview:self.shareButton];

        [self addConstraints];
    }
    
    return self;
}

- (void)addConstraints {
    
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self).insets(UIEdgeInsetsMake(CAL_WIDTH_TO_FIT(50), CAL_WIDTH_TO_FIT(50), 0, CAL_WIDTH_TO_FIT(50)));
        make.bottom.equalTo(self.shareButton.mas_top).offset(CAL_WIDTH_TO_FIT(-40));
    }];
    
    [self.shareButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(CAL_WIDTH_TO_FIT(-40));
        make.width.equalTo(self).multipliedBy(0.5);
        make.centerX.equalTo(self);
    }];
}

#pragma mark - Init Text View
- (UITextView *)textView {
    
    CAL_GET_METHOD_RETURN_OBJC(_textView);
    
    _textView = [[UITextView alloc] init];
    
    _textView.layer.borderWidth = 1.f;
    _textView.layer.borderColor = LINE_COLOR.CGColor;
    _textView.font = [UIFont systemFontOfSize:16];
    
    return _textView;
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
