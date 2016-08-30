//
//  CommentTableViewCell.h
//  Mountains
//
//  Created by Тимур Аюпов on 05.06.16.
//  Copyright © 2016 Тимур Аюпов. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentTextLabel;

@end
