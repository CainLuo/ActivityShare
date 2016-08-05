//
//  CALCustomShareMessage.m
//  ActivityViewControllerDemo
//
//  Created by Cain on 26/6/16.
//  Copyright © 2016年 Cain. All rights reserved.
//

#import "CALCustomShareMessage.h"

@implementation CALCustomShareMessage

- (BOOL)isEmptyWithValueOfKeys:(NSArray *)emptyValueForKeys notEmpty:(NSArray *)notEmptyValueForKeys {
    
    @try {
        if (emptyValueForKeys) {
            
            for (NSString *key in emptyValueForKeys) {
                
                if ([self valueForKeyPath:key]) {
                    return NO;
                }
            }
        }
        
        if (notEmptyValueForKeys) {
            
            for (NSString *key in notEmptyValueForKeys) {
                
                if (![self valueForKey: key]) {
                    
                    return NO;
                }
            }
        }
        
        return YES;
    }
    
    @catch (NSException *exception) {
        
        NSLog(@"isEmpty error: %@", exception);
        
        return NO;
    }
}

@end
