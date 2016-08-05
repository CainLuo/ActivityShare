//
//  CALCustomShareBlock.h
//  ActivityViewControllerDemo
//
//  Created by Cain on 27/6/16.
//  Copyright © 2016年 Cain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CALCustomShareMessage.h"

@interface CALCustomShareBlock : NSObject

/**
 *  发送分享内容的方法
 *
 *  @param shareMessage 分享的ShareMessage对象
 *  @param error        分享失败错误信息, 如果是分享成功error为nil
 */
+ (void)customShareBlockMessage:(CALCustomShareMessage *)shareMessage
                          error:(NSError *)error;

@end
