//
//  MountainsListTableViewController.h
//  Mountains
//
//  Created by Тимур Аюпов on 29.05.16.
//  Copyright © 2016 Тимур Аюпов. All rights reserved.
//

#import <UIKit/UIKit.h>
@import Firebase;
@import FirebaseDatabaseUI;

@interface MountainsListTableViewController : UITableViewController

// [START define_database_reference]
@property (strong, nonatomic) FIRDatabaseReference *ref;
// [END define_database_reference]
@property (strong, nonatomic) FirebaseTableViewDataSource *dataSource;

@end
