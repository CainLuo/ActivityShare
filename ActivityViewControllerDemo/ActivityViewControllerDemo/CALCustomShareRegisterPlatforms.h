//
//  CALCustomShareRegisterPlatforms.h
//  ActivityViewControllerDemo
//
//  Created by Cain on 27/6/16.
//  Copyright © 2016年 Cain. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CALCustomShareRegisterPlatforms : NSObject

/**
 *  注册各个平台的App Key
 *
 *  @param dictionary @{平台名字 : AppKey}, 根据CALCustomShareType枚举类型来判断
 *
 */
+ (void)registerPlatformsWithDictionary:(NSArray *)platforms;

@end
