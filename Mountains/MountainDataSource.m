//
//  MountainDataSource.m
//  Mountains
//
//  Created by Тимур Аюпов on 29.05.16.
//  Copyright © 2016 Тимур Аюпов. All rights reserved.
//

#import "MountainDataSource.h"

@import Firebase;

@implementation MountainDataSource

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    if ([self count] != 0)
    {
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.backgroundView = nil;
    }
    return [self count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    UILabel *noDataLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, tableView.bounds.size.height)];
    noDataLabel.text = @"No posts yet - why not add one?";
    noDataLabel.textColor = [UIColor blackColor];
    noDataLabel.textAlignment = NSTextAlignmentCenter;
    tableView.backgroundView = noDataLabel;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    return 1;
}

@end
