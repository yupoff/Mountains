//
//  SendCommentTableViewCell.h
//  Mountains
//
//  Created by Тимур Аюпов on 05.06.16.
//  Copyright © 2016 Тимур Аюпов. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CellOutputProtocol < NSObject >
- (void)didTapSend:(NSString *)commentText;
@end

@interface SendCommentTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextField *commentTextField;
@property (nonatomic, weak) id< CellOutputProtocol > output;
@end
