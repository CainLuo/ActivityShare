//
//  WeChatTimelineActivity.h
//  ActivityViewControllerDemo
//
//  Created by Cain on 28/6/16.
//  Copyright © 2016年 Cain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CALWeChatTimelineActivity : UIActivity

@property (nonatomic, copy) void(^weChatTimelineActivityBlock)(void);

@end
