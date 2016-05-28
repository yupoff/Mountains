//
//  MountainsListViewController.m
//  Mountains
//
//  Created by Тимур Аюпов on 10.05.16.
//  Copyright © 2016 Тимур Аюпов. All rights reserved.
//

#import "DetailsInfoViewController.h"
#import "MountainsListTableViewCell.h"
#import "MountainsListViewController.h"
@interface MountainsListViewController () < UITableViewDelegate, UITableViewDataSource >
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation MountainsListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"TopBar"]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage imageNamed:@"TopBar"];
    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController.navigationBar setTitleTextAttributes:@{
        NSForegroundColorAttributeName : [UIColor mountainsWhite],
        NSFontAttributeName : [UIFont mountainsFontHelveticaNeueLight18]
    }];
    [self.tableView setBackgroundView:nil];
    [self.tableView setBackgroundColor:[UIColor clearColor]];
    [self.tableView setDataSource:self];
    [self.tableView setDelegate:self];
    [self.tableView setRowHeight:UITableViewAutomaticDimension];
    [self.tableView setEstimatedRowHeight:150.0];
    self.navigationItem.title = @"Горы";
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@""
                                                                 style:UIBarButtonItemStylePlain
                                                                target:nil
                                                                action:nil];

    [self.navigationItem setBackBarButtonItem:backItem];
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
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"MountainsListTableViewCell";
    MountainsListTableViewCell *cell = (MountainsListTableViewCell *)[self.tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell)
    {
        [self.tableView registerNib:[UINib nibWithNibName:cellIdentifier bundle:nil] forCellReuseIdentifier:cellIdentifier];
        cell = [self.tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    }
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailsInfoViewController *detailInfoVC = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailsInfoViewController"];
    [self.navigationController pushViewController:detailInfoVC animated:YES];
}

@end
