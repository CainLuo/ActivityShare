//
//  ActivityShareTextView.h
//  ActivityShare
//
//  Created by Cain on 5/8/16.
//  Copyright © 2016年 Cain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActivityShareTextView : UIView

@property (nonatomic, copy) void(^activityShareBlock)(void);
@property (nonatomic, strong, readonly) UITextView *textView;

@end
