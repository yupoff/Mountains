//
//  CustomTextFieldStyle.m
//  Mountains
//
//  Created by Тимур Аюпов on 09.05.16.
//  Copyright © 2016 Тимур Аюпов. All rights reserved.
//

#import "CustomTextFieldStyle.h"

@implementation CustomTextFieldStyle

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self)
    {
        [self setTextColor:[UIColor mountainsWhite]];
        [self setFont:[UIFont mountainsFontHelveticaNeueLight14]];
        self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:@{
            NSForegroundColorAttributeName : [UIColor mountainsWhite],
            NSFontAttributeName : [UIFont mountainsFontHelveticaNeueLight14]
        }];
    }
    return self;
}

@end
