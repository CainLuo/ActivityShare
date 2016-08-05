//
//  CALCustomShare+AliPay.h
//  ActivityViewControllerDemo
//
//  Created by Cain on 28/6/16.
//  Copyright © 2016年 Cain. All rights reserved.
//

#import "CALCustomShare.h"

@interface CALCustomShare (AliPay)

/**
 *  注册AliPay
 */
+ (void)registerAliPay;

/**
 *  这是调取AliPay支付链接的方法
 *
 *  @param link  传入需要AliPay支付的链接
 *  @param block 支付成功或者失败的Block回调
 */
+ (void)AliPay:(NSString *)link
      payBlock:(calCustomPayBlock)block;

@end
