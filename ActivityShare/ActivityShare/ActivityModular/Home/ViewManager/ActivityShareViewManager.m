//
//  ActivityShareViewManager.m
//  ActivityShare
//
//  Created by Cain on 5/8/16.
//  Copyright © 2016年 Cain. All rights reserved.
//

#import "ActivityShareViewManager.h"
#import "ActivityShareController.h"
#import "ActivityShareCell.h"

#import "ActivityShareTextController.h"
#import "ActivityShareImageController.h"

@interface ActivityShareViewManager()

@property (nonatomic, strong) ActivityShareController *shareController;

@end

@implementation ActivityShareViewManager

- (instancetype)initViewManagerWithController:(UIViewController *)controller {
    
    if (self = [super init]) {
        
        _shareController = (ActivityShareController *)controller;
    }
    
    return self;
}

- (void)reloadViewManegerWithTableView:(UITableView *)tableView {
    
    [tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *cellTitle = self.dataSource[indexPath.row];
    
    ActivityShareCell *tableViewCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ActivityShareCell class])];
    
    if (!tableViewCell) {
        
        tableViewCell = [[ActivityShareCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                 reuseIdentifier:NSStringFromClass([ActivityShareCell class])];
        
        tableViewCell.textLabel.text = cellTitle;
        tableViewCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    return tableViewCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath
                             animated:YES];
    
    switch (indexPath.row) {
        case 0: {

            ActivityShareTextController *textController = [[ActivityShareTextController alloc] init];
            
            [self.shareController.navigationController pushViewController:textController
                                                                 animated:YES];
        }
            break;
        case 1: {
            
            ActivityShareImageController *imageController = [[ActivityShareImageController alloc] init];
            
            [self.shareController.navigationController pushViewController:imageController
                                                                 animated:YES];
        }
            break;
            
        case 2:
            
            break;
            
        case 3:
            
            break;
        case 4:
            
            break;
        default:
            break;
    }
}

@end
