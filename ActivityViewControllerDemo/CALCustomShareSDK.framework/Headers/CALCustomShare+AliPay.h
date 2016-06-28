//
//  CALCustomShare+AliPay.h
//  ActivityViewControllerDemo
//
//  Created by Cain on 28/6/16.
//  Copyright © 2016年 Cain. All rights reserved.
//

#import "CALCustomShare.h"

@interface CALCustomShare (AliPay)

+ (void)registerAliPay;

+ (void)AliPay:(NSString *)link payBlock:(calCustomPayBlock)block;

@end
