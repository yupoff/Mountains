//
//  SendCommentTableViewCell.m
//  Mountains
//
//  Created by Тимур Аюпов on 05.06.16.
//  Copyright © 2016 Тимур Аюпов. All rights reserved.
//

#import "SendCommentTableViewCell.h"

@implementation SendCommentTableViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)sendAction:(UIButton *)sender
{
    [self.output didTapSend:self.commentTextField.text];
    self.commentTextField.text = @"";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
