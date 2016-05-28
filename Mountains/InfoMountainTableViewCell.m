//
//  InfoMountainTableViewCell.m
//  Mountains
//
//  Created by Тимур Аюпов on 13.05.16.
//  Copyright © 2016 Тимур Аюпов. All rights reserved.
//

#import "InfoMountainTableViewCell.h"

@implementation InfoMountainTableViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setBackgroundColor:[UIColor mountainsTransparentGray]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
