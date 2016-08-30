//
//  Mountain.m
//  Mountains
//
//  Created by Тимур Аюпов on 29.05.16.
//  Copyright © 2016 Тимур Аюпов. All rights reserved.
//

#import "Location.h"
#import "Mountain.h"

@implementation Mountain
- (instancetype)initWithDictinory:(NSDictionary *)dict
{
    self = [super init];
    if (self)
    {
        self.location = [[Location alloc] initWithDictinory:dict[@"location"]];
        self.title = dict[@"title"];
        self.region = dict[@"region"];
        self.guid = [dict[@"guid"] integerValue];
        self.body = dict[@"body"];
        self.starCount = dict[@"starCount"];
        self.image = dict[@"image"];
        self.contactsInfo = dict[@"contactsInfo"];
        self.trackInfo = dict[@"trackInfo"];
    }
    return self;
}
@end
