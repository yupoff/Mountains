//
//  User.m
//  Mountains
//
//  Created by Тимур Аюпов on 04.06.16.
//  Copyright © 2016 Тимур Аюпов. All rights reserved.
//

#import "User.h"

@implementation User
- (instancetype)init
{
    return [self initWithUsername:@""];
}

- (instancetype)initWithUsername:(NSString *)username
{
    self = [super init];
    if (self)
    {
        self.username = username;
    }
    return self;
}
@end
