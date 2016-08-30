//
//  PostDetailTableViewController.h
//  Mountains
//
//  Created by Тимур Аюпов on 04.06.16.
//  Copyright © 2016 Тимур Аюпов. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SendCommentTableViewCell.h"

@interface PostDetailTableViewController : UITableViewController <CellOutputProtocol>
@property (strong, nonatomic) NSString *postKey;
@end
