//
//  MountainsListTableViewController.m
//  Mountains
//
//  Created by Тимур Аюпов on 29.05.16.
//  Copyright © 2016 Тимур Аюпов. All rights reserved.
//

#import "DetailMountainTableViewController.h"
#import "Mountain.h"
#import "MountainDataSource.h"
#import "MountainTableViewCell.h"
#import "MountainsListTableViewController.h"
#import "SignInViewController.h"

@import Firebase;
@import FirebaseAuth;

@interface MountainsListTableViewController ()

@end

@implementation MountainsListTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.ref = [[FIRDatabase database] reference];
    self.dataSource = [[MountainDataSource alloc] initWithQuery:[self getQuery] modelClass:[Mountain class] nibNamed:@"MountainTableViewCell" cellReuseIdentifier:@"MountainTableViewCell" view:self.tableView];
    [self.dataSource populateCellWithBlock:^(MountainTableViewCell *_Nonnull cell, Mountain *_Nonnull mountain) {
      cell.titleLabel.text = mountain.title;
      cell.bodyLabel.text = mountain.body;
    }];
    self.tableView.dataSource = self.dataSource;
    self.tableView.delegate = self;
    [self.tableView setRowHeight:UITableViewAutomaticDimension];
    [self.tableView setEstimatedRowHeight:220.0];
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

#pragma mark - Table view data source

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"detailsInfoMountain" sender:indexPath];
}

- (FIRDatabaseQuery *)getQuery
{
    return [[self.ref child:@"mountains"] queryOrderedByChild:@"starCount"];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *path = sender;
    DetailMountainTableViewController *detailsVC = [segue destinationViewController];
    FirebaseTableViewDataSource *source = self.dataSource;
    FIRDataSnapshot *snapshot = [source objectAtIndex:path.row];
    //    detailsVC.mountain = [[Mountain alloc]initWithDictinory:snapshot.value];
    detailsVC.mountain = [Mountain new];
    [detailsVC.mountain setValuesForKeysWithDictionary:snapshot.value];
    // Pass the selected object to the new view controller.
}

@end
