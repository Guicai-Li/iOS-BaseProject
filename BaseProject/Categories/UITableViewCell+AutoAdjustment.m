//
//  UITableViewCell.m
//  BaseProject
//
//  Created by LiGuicai on 15/7/13.
//  Copyright (c) 2015年 game. All rights reserved.
//

#import "UITableViewCell+AutoAdjustment.h"

@implementation UITableViewCell(AutoAdjustment)

- (CGFloat)autoAdjustmentTableViewCell:(UITableViewCell *)tableViewCell OnTableView:(UITableView *)tableView {
    
    [tableViewCell setNeedsUpdateConstraints];
    [tableViewCell updateConstraintsIfNeeded];
    
    CGRect frame = tableViewCell.frame;
    frame.size.width = tableView.bounds.size.width;
    tableViewCell.frame = frame;
    [tableViewCell setNeedsLayout];
    [tableViewCell layoutIfNeeded];
    CGFloat height = [tableViewCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    return height + 1;
}

@end
