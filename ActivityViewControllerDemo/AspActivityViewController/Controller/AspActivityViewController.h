//
//  AspActivityViewController.h
//  ActivityViewControllerDemo
//
//  Created by Cain on 23/5/2016.
//  Copyright © 2016 Cain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AspActivityViewController : UIActivityViewController

@property (nonatomic, strong) CALCustomShareMessage *customShareMessage;

- (instancetype)initAspActivityControllerWithContent:(NSArray *)activityContent;

- (instancetype)initAspActivityControllerWithContent:(NSArray *)activityContent activities:(NSArray *)activities;

@end
