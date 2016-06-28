//
//  WeChatSessionActivity.h
//  ActivityViewControllerDemo
//
//  Created by Cain on 28/6/16.
//  Copyright © 2016年 Cain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeChatSessionActivity : UIActivity

@property (nonatomic, copy) void(^weChatSessionActivityBlock)(void);

@end
