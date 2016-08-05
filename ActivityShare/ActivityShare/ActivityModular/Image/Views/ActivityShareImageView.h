//
//  ActivityShareImageView.h
//  ActivityShare
//
//  Created by Cain on 5/8/16.
//  Copyright © 2016年 Cain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActivityShareImageView : UIView

@property (nonatomic, strong, readonly) UIImageView *shareImageView;

@property (nonatomic, copy) void(^activityShareImageBlock)(void);
@property (nonatomic, copy) void(^activityShareBlock)(void);

@end
