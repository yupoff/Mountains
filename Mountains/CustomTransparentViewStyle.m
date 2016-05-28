//
//  CustomTransparentViewStyle.m
//  Mountains
//
//  Created by Тимур Аюпов on 09.05.16.
//  Copyright © 2016 Тимур Аюпов. All rights reserved.
//

#import "CustomTransparentViewStyle.h"

@implementation CustomTransparentViewStyle

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self)
    {
        self.layer.cornerRadius = 18;
        self.layer.borderWidth = 0;
        [self setBackgroundColor:[UIColor mountainsTransparentGray]];
    }
    return self;
}

@end
