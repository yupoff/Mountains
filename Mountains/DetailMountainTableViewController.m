//
//  DetailMountainTableViewController.m
//  Mountains
//
//  Created by Тимур Аюпов on 29.05.16.
//  Copyright © 2016 Тимур Аюпов. All rights reserved.
//

#import "DescriptionTableViewCell.h"
#import "DetailInfoTableViewController.h"
#import "DetailMountainTableViewController.h"
#import "DetailTableViewCell.h"
#import "ImageTableViewCell.h"
#import "SearchTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
@interface DetailMountainTableViewController ()

@end

@implementation DetailMountainTableViewController

static NSString *cellIdentifierDescriptionCell = @"DescriptionTableViewCell";
static NSString *cellIdentifierImageCell = @"ImageTableViewCell";
static NSString *cellIdentifierSearchTableViewCell = @"SearchTableViewCell";
static NSString *cellDetailTableViewCell = @"DetailTableViewCell";

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self.tableView setRowHeight:UITableViewAutomaticDimension];
    [self.tableView setEstimatedRowHeight:150.0];
    [self.navigationItem setTitle:self.mountain.title];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        ImageTableViewCell *cell = (ImageTableViewCell *)[self.tableView dequeueReusableCellWithIdentifier:cellIdentifierImageCell];
        if (!cell)
        {
            [self.tableView registerNib:[UINib nibWithNibName:cellIdentifierImageCell bundle:nil] forCellReuseIdentifier:cellIdentifierImageCell];
        }
        cell = [self.tableView dequeueReusableCellWithIdentifier:cellIdentifierImageCell];
        [cell.imageMountainView sd_setImageWithURL:[NSURL URLWithString:self.mountain.image]];
        return cell;
    }
    else if (indexPath.row == 1)
    {
        SearchTableViewCell *cell = (SearchTableViewCell *)[self.tableView dequeueReusableCellWithIdentifier:cellIdentifierSearchTableViewCell];
        if (!cell)
        {
            [self.tableView registerNib:[UINib nibWithNibName:cellIdentifierSearchTableViewCell bundle:nil] forCellReuseIdentifier:cellIdentifierSearchTableViewCell];
        }
        cell = [self.tableView dequeueReusableCellWithIdentifier:cellIdentifierSearchTableViewCell];
        cell.titleLabel.text = @"Найти авиабилеты";
        cell.iconView.image = [UIImage imageNamed:@"airplane-mode-0"];
        return cell;
    }
    else if (indexPath.row == 2)
    {
        SearchTableViewCell *cell = (SearchTableViewCell *)[self.tableView dequeueReusableCellWithIdentifier:cellIdentifierSearchTableViewCell];
        if (!cell)
        {
            [self.tableView registerNib:[UINib nibWithNibName:cellIdentifierSearchTableViewCell bundle:nil] forCellReuseIdentifier:cellIdentifierSearchTableViewCell];
        }
        cell = [self.tableView dequeueReusableCellWithIdentifier:cellIdentifierSearchTableViewCell];
        cell.titleLabel.text = @"Найти отели";
        cell.iconView.image = [UIImage imageNamed:@"hotel"];
        return cell;
    }
    else if (indexPath.row == 3)
    {
        DescriptionTableViewCell *cell = (DescriptionTableViewCell *)[self.tableView dequeueReusableCellWithIdentifier:cellIdentifierDescriptionCell];
        if (!cell)
        {
            [self.tableView registerNib:[UINib nibWithNibName:cellIdentifierDescriptionCell bundle:nil] forCellReuseIdentifier:cellIdentifierDescriptionCell];
        }
        cell = [self.tableView dequeueReusableCellWithIdentifier:cellIdentifierDescriptionCell];
        cell.bodyLabel.text = self.mountain.body;
        return cell;
    }
    else if (indexPath.row == 4)
    {
        DetailTableViewCell *cell = (DetailTableViewCell *)[self.tableView dequeueReusableCellWithIdentifier:cellDetailTableViewCell];
        if (!cell)
        {
            [self.tableView registerNib:[UINib nibWithNibName:cellDetailTableViewCell bundle:nil] forCellReuseIdentifier:cellDetailTableViewCell];
        }
        cell = [self.tableView dequeueReusableCellWithIdentifier:cellDetailTableViewCell];
        cell.titleLabel.text = @"Трассы и подъемники";
        cell.bodyLabel.text = self.mountain.trackInfo;
        cell.iconView.image = [UIImage imageNamed:@"info-button"];
        return cell;
    }
    else if (indexPath.row == 5)
    {
        DetailTableViewCell *cell = (DetailTableViewCell *)[self.tableView dequeueReusableCellWithIdentifier:cellDetailTableViewCell];
        if (!cell)
        {
            [self.tableView registerNib:[UINib nibWithNibName:cellDetailTableViewCell bundle:nil] forCellReuseIdentifier:cellDetailTableViewCell];
        }
        cell = [self.tableView dequeueReusableCellWithIdentifier:cellDetailTableViewCell];
        cell.titleLabel.text = @"Как добраться";
        cell.bodyLabel.text = self.mountain.contactsInfo;
        cell.iconView.image = [UIImage imageNamed:@"info-button"];
        return cell;
    }

    else
    {
        return nil;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 4 || indexPath.row == 5)
    {
        [self performSegueWithIdentifier:@"detailInfo" sender:indexPath];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *path = sender;
    if (path.row == 4)
    {
        DetailInfoTableViewController *detailsVC = [segue destinationViewController];
        detailsVC.imageUrl = self.mountain.image;
        detailsVC.body = self.mountain.trackInfo;
    }
    if (path.row == 5)
    {
        DetailInfoTableViewController *detailsVC = [segue destinationViewController];
        detailsVC.imageUrl = self.mountain.image;
        detailsVC.body = self.mountain.contactsInfo;
    }
}

@end
