//
//  Location.m
//  Mountains
//
//  Created by Тимур Аюпов on 29.05.16.
//  Copyright © 2016 Тимур Аюпов. All rights reserved.
//

#import "Location.h"

@implementation Location
- (instancetype)initWithDictinory:(NSDictionary *)dict
{
    self = [super init];
    if (self)
    {
        self.lat = [dict[@"lat"] doubleValue];
        self.lon = [dict[@"lon"] doubleValue];
    }
    return self;
}
@end
