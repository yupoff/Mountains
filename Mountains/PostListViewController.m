//
//  PostListViewController.m
//  Mountains
//
//  Created by Тимур Аюпов on 04.06.16.
//  Copyright © 2016 Тимур Аюпов. All rights reserved.
//

#import "Post.h"
#import "PostDataSource.h"
#import "PostDetailTableViewController.h"
#import "PostListViewController.h"
#import "PostTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@import Firebase;

@interface PostListViewController ()

@end

@implementation PostListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // [START create_database_reference]
    self.ref = [[FIRDatabase database] reference];
    // [END create_database_reference]

    self.dataSource = [[PostDataSource alloc] initWithQuery:[self getQuery]
                                                 modelClass:[Post class]
                                                   nibNamed:@"PostTableViewCell"
                                        cellReuseIdentifier:@"PostTableViewCell"
                                                       view:self.tableView];

    [self.dataSource
        populateCellWithBlock:^void(PostTableViewCell *__nonnull cell,
                                    Post *__nonnull post) {
          cell.authorImage.image = [UIImage imageNamed:@"ic_account_circle"];
          cell.authorLabel.text = post.author;
          NSString *imageName = [post.stars objectForKey:[self getUid]] ? @"ic_star" : @"ic_star_border";
          [cell.starButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
          cell.numStarsLabel.text = [NSString stringWithFormat:@"%d", post.starCount];
          cell.postTitle.text = post.title;
          cell.postBody.text = post.body;
          [cell.photoView sd_setImageWithURL:[NSURL URLWithString:post.photoUrl]];
        }];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.tableView setRowHeight:UITableViewAutomaticDimension];
    [self.tableView setEstimatedRowHeight:150.0];
    self.tableView.dataSource = self.dataSource;
    self.tableView.delegate = self;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"detailPost" sender:indexPath];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.tableView reloadData];
}

- (NSString *)getUid
{
    return [FIRAuth auth].currentUser.uid;
}

- (FIRDatabaseQuery *)getQuery
{
    FIRDatabaseQuery *recentPostsQuery = [[self.ref child:@"posts"] queryOrderedByChild:@"starCount"];
    // [END recent_posts_query]
    return recentPostsQuery;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"detailPost"])
    {
        NSIndexPath *path = sender;
        PostDetailTableViewController *detail = segue.destinationViewController;
        FirebaseTableViewDataSource *source = self.dataSource;
        FIRDataSnapshot *snapshot = [source objectAtIndex:path.row];
        detail.postKey = snapshot.key;
    }
}

@end
