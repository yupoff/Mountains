//
//  Post.m
//  Mountains
//
//  Created by Тимур Аюпов on 04.06.16.
//  Copyright © 2016 Тимур Аюпов. All rights reserved.
//

#import "Post.h"

@implementation Post

- (instancetype)init
{
    return [self initWithUid:@"" andAuthor:@"" andTitle:@"" andBody:@""];
}

- (instancetype)initWithUid:(NSString *)uid
                  andAuthor:(NSString *)author
                   andTitle:(NSString *)title
                    andBody:(NSString *)body
{
    self = [super init];
    if (self)
    {
        self.uid = uid;
        self.author = author;
        self.title = title;
        self.body = body;
    }
    return self;
}

- (instancetype)initWithDictinory:(NSDictionary *)dict
{
    self = [super init];
    if (self)
    {
        self.uid = dict[@"uid"];
        self.author = dict[@"author"];
        self.title = dict[@"title"];
        self.body = dict[@"body"];
        self.starCount = [dict[@"starCount"] intValue];
    }
    return self;
}
@end
