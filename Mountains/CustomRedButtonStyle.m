//
//  CustomRedButtonStyle.m
//  Mountains
//
//  Created by Тимур Аюпов on 09.05.16.
//  Copyright © 2016 Тимур Аюпов. All rights reserved.
//

#import "CustomRedButtonStyle.h"

@implementation CustomRedButtonStyle

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];

    if (self)
    {
        [self drawButton];
    }
    return self;
}

- (void)drawButton
{
    [UIButton buttonWithType:UIButtonTypeCustom];

    [self.layer setCornerRadius:18];
    [self.layer setBorderWidth:0];
    [self.layer setMasksToBounds:YES];
    [self setBackgroundColor:[UIColor mountainsRed]];
    [self setTitleColor:[UIColor mountainsWhite] forState:UIControlStateNormal];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
}

- (void)setHighlighted:(BOOL)highlighted
{
    if (highlighted)
    {
        [self setBackgroundColor:[UIColor redColor]];
    }
    else
    {
        [self setBackgroundColor:[UIColor mountainsRed]];
    }
}

@end
