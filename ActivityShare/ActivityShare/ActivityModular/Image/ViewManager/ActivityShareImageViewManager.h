//
//  ActivityShareImageViewManager.h
//  ActivityShare
//
//  Created by Cain on 5/8/16.
//  Copyright © 2016年 Cain. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ActivityShareImageViewManager : NSObject

- (instancetype)initImageViewManagerWithController:(UIViewController *)controller;

- (void)reloadImageViewManager;

@end
