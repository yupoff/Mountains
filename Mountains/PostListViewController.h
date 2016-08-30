//
//  PostListViewController.h
//  Mountains
//
//  Created by Тимур Аюпов on 04.06.16.
//  Copyright © 2016 Тимур Аюпов. All rights reserved.
//

#import <UIKit/UIKit.h>
@import FirebaseDatabaseUI;
@import Firebase;

@interface PostListViewController : UIViewController < UITableViewDelegate >
@property (strong, nonatomic) FIRDatabaseReference *ref;
// [END define_database_reference]
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) FirebaseTableViewDataSource *dataSource;
- (NSString *)getUid;
@end
