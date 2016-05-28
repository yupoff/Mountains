//
//  DetailsInfoViewController.m
//  Mountains
//
//  Created by Тимур Аюпов on 10.05.16.
//  Copyright © 2016 Тимур Аюпов. All rights reserved.
//

#import "CollectionTableViewCell.h"
#import "DescriptionMountainTableViewCell.h"
#import "DetailsInfoViewController.h"
#import "InfoMountainTableViewCell.h"

@interface DetailsInfoViewController () < UITableViewDataSource, UITableViewDelegate >
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation DetailsInfoViewController
static NSString *cellIdentifierDescriptionCell = @"DescriptionMountainTableViewCell";
static NSString *cellIdentifierCollectionCell = @"CollectionTableViewCell";
static NSString *cellIdentifierInfoMountainCell = @"InfoMountainTableViewCell";

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"TopBar"]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage imageNamed:@"TopBar"];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.navigationBar.tintColor = [UIColor mountainsWhite];
    [self.navigationController.navigationBar setTitleTextAttributes:@{
        NSForegroundColorAttributeName : [UIColor mountainsWhite],
        NSFontAttributeName : [UIFont mountainsFontHelveticaNeueLight18]
    }];
    [self.navigationItem setTitle:@""];
    [self.tableView setBackgroundView:nil];
    [self.tableView setBackgroundColor:[UIColor clearColor]];
    [self.tableView setDataSource:self];
    [self.tableView setDelegate:self];
    [self.tableView setRowHeight:UITableViewAutomaticDimension];
    [self.tableView setEstimatedRowHeight:150.0];
    [[UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], nil] setTitleTextAttributes:
                                                                                  @{
                                                                                      NSForegroundColorAttributeName : [UIColor mountainsWhite],
                                                                                      NSFontAttributeName : [UIFont mountainsFontHelveticaNeueLight18]
                                                                                  }
                                                                                            forState:UIControlStateNormal];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        CollectionTableViewCell *cell = (CollectionTableViewCell *)[self.tableView dequeueReusableCellWithIdentifier:cellIdentifierCollectionCell];
        if (!cell)
        {
            [self.tableView registerNib:[UINib nibWithNibName:cellIdentifierCollectionCell bundle:nil] forCellReuseIdentifier:cellIdentifierCollectionCell];
            cell = [self.tableView dequeueReusableCellWithIdentifier:cellIdentifierCollectionCell];
        }
        return cell;
    }
    else if (indexPath.row == 1)
    {
        InfoMountainTableViewCell *cell = (InfoMountainTableViewCell *)[self.tableView dequeueReusableCellWithIdentifier:cellIdentifierInfoMountainCell];
        if (!cell)
        {
            [self.tableView registerNib:[UINib nibWithNibName:cellIdentifierInfoMountainCell bundle:nil] forCellReuseIdentifier:cellIdentifierInfoMountainCell];
            cell = [self.tableView dequeueReusableCellWithIdentifier:cellIdentifierInfoMountainCell];
        }
        return cell;
    }
    else
    {
        DescriptionMountainTableViewCell *cell = (DescriptionMountainTableViewCell *)[self.tableView dequeueReusableCellWithIdentifier:cellIdentifierDescriptionCell];
        if (!cell)
        {
            [self.tableView registerNib:[UINib nibWithNibName:cellIdentifierDescriptionCell bundle:nil] forCellReuseIdentifier:cellIdentifierDescriptionCell];
            cell = [self.tableView dequeueReusableCellWithIdentifier:cellIdentifierDescriptionCell];
        }
        return cell;
    }
}
@end
