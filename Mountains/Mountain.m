//
//  Mountain.m
//  Mountains
//
//  Created by Тимур Аюпов on 29.05.16.
//  Copyright © 2016 Тимур Аюпов. All rights reserved.
//

#import "Mountain.h"

@implementation Mountain
- (instancetype)initWithDictinory:(NSDictionary *)dict
{
    self = [super init];
    if (self)
    {
        self.guid = [dict[@"guid"] integerValue];
        self.title = dict[@"title"];
        self.body = dict[@"body"];
        self.starCount = dict[@"starCount"];
        self.image = dict[@"image"];
        self.heightDifference = dict[@"heightDifference"];
        self.countTracks = dict[@"countTracks"];
        self.totalLenghtTracks = dict[@"totalLenghtTracks"];
        self.countLifts = dict[@"countLifts"];
    }
    return self;
}
@end
