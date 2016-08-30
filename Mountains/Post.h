//
//  Post.h
//  Mountains
//
//  Created by Тимур Аюпов on 04.06.16.
//  Copyright © 2016 Тимур Аюпов. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Post : NSObject
@property (strong, nonatomic) NSString *uid;
@property (strong, nonatomic) NSString *author;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *body;
@property (assign, nonatomic) NSInteger starCount;
@property (strong, nonatomic) NSDictionary< NSString *, NSNumber * > *stars;
@property (strong, nonatomic) NSString *photoUrl;

- (instancetype)initWithUid:(NSString *)uid
                  andAuthor:(NSString *)author
                   andTitle:(NSString *)title
                    andBody:(NSString *)body;
- (instancetype)initWithDictinory:(NSDictionary *)dict;
@end
