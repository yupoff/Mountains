//
//  MountainsListTableViewController.m
//  Mountains
//
//  Created by Тимур Аюпов on 29.05.16.
//  Copyright © 2016 Тимур Аюпов. All rights reserved.
//

#import "DetailMountainTableViewController.h"
#import "DetailTableViewCell.h"
#import "Mountain.h"
#import "MountainsListTableViewController.h"
#import "ServerManager.h"
#import "SignInViewController.h"

@import Firebase;
@import FirebaseAuth;

@interface MountainsListTableViewController ()
@property (nonatomic, strong) NSArray< Mountain * > *dataSource;
@end

@implementation MountainsListTableViewController
static NSString *cellDetailTableViewCell = @"DetailTableViewCell";

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self.tableView setRowHeight:UITableViewAutomaticDimension];
    [self.tableView setEstimatedRowHeight:220.0];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.dataSource = [NSArray array];
    [self createDataSource];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.tableView reloadData];
}

- (void)createDataSource
{
    [ServerManager getOrderedMountainsByStarCount:^(NSArray *mountains) {
      self.dataSource = mountains;
      [self reloadData];
    }
        onFailure:^(NSError *error){

        }];
}

- (void)reloadData
{
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"detailsInfoMountain" sender:indexPath];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *path = sender;
    DetailMountainTableViewController *detailsVC = [segue destinationViewController];
    detailsVC.mountain = self.dataSource[path.row];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailTableViewCell *cell = (DetailTableViewCell *)[self.tableView dequeueReusableCellWithIdentifier:cellDetailTableViewCell];
    if (!cell)
    {
        [self.tableView registerNib:[UINib nibWithNibName:cellDetailTableViewCell bundle:nil] forCellReuseIdentifier:cellDetailTableViewCell];
    }
    cell = [self.tableView dequeueReusableCellWithIdentifier:cellDetailTableViewCell];
    cell.titleLabel.text = self.dataSource[indexPath.row].title;
    cell.bodyLabel.text = self.dataSource[indexPath.row].body;
    cell.iconView.image = [UIImage imageNamed:@"Earth Element-50"];
    return cell;
}

@end
