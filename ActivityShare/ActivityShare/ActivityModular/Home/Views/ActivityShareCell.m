//
//  ActivityShareCell.m
//  ActivityShare
//
//  Created by Cain on 5/8/16.
//  Copyright © 2016年 Cain. All rights reserved.
//

#import "ActivityShareCell.h"

@interface ActivityShareCell()

@property (nonatomic, strong) CALayer *lineLayer;

@end

@implementation ActivityShareCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self.layer addSublayer:self.lineLayer];
    }
    
    return self;
}

- (CALayer *)lineLayer {
    
    CAL_GET_METHOD_RETURN_OBJC(_lineLayer);
    
    _lineLayer = [CALayer layer];
    _lineLayer.frame = CGRectMake(15, CGRectGetMaxY(self.contentView.frame) - 1, CAL_SCREEN_WIDTH, 1);
    _lineLayer.backgroundColor = LINE_COLOR.CGColor;
    
    return _lineLayer;
}

@end
