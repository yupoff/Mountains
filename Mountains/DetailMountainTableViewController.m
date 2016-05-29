//
//  DetailMountainTableViewController.m
//  Mountains
//
//  Created by Тимур Аюпов on 29.05.16.
//  Copyright © 2016 Тимур Аюпов. All rights reserved.
//

#import "DescriptionTableViewCell.h"
#import "DetailMountainTableViewController.h"
#import "ImageTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface DetailMountainTableViewController ()

@end

@implementation DetailMountainTableViewController

static NSString *cellIdentifierDescriptionCell = @"DescriptionTableViewCell";
static NSString *cellIdentifierImageCell = @"ImageTableViewCell";

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
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        ImageTableViewCell *cell = (ImageTableViewCell *)[self.tableView dequeueReusableCellWithIdentifier:cellIdentifierImageCell];
        if (!cell)
        {
            [self.tableView registerNib:[UINib nibWithNibName:cellIdentifierImageCell bundle:nil] forCellReuseIdentifier:cellIdentifierImageCell];
            cell = [self.tableView dequeueReusableCellWithIdentifier:cellIdentifierImageCell];
            [cell.imageMountainView sd_setImageWithURL:[NSURL URLWithString:self.mountain.image]];
        }
        return cell;
    }
    else if (indexPath.row == 1)
    {
        DescriptionTableViewCell *cell = (DescriptionTableViewCell *)[self.tableView dequeueReusableCellWithIdentifier:cellIdentifierDescriptionCell];
        if (!cell)
        {
            [self.tableView registerNib:[UINib nibWithNibName:cellIdentifierDescriptionCell bundle:nil] forCellReuseIdentifier:cellIdentifierDescriptionCell];
            cell = [self.tableView dequeueReusableCellWithIdentifier:cellIdentifierDescriptionCell];
            cell.bodyLabel.text = self.mountain.body;
        }
        return cell;
    }
    else
    {
        return nil;
    }
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
