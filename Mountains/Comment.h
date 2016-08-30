//
//  Comment.h
//  Mountains
//
//  Created by Тимур Аюпов on 04.06.16.
//  Copyright © 2016 Тимур Аюпов. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Comment : NSObject
@property (strong, nonatomic) NSString *uid;
@property (strong, nonatomic) NSString *author;
@property (strong, nonatomic) NSString *text;

- (instancetype)initWithUid:(NSString *)uid
                  andAuthor:(NSString *)author
                    andText:(NSString *)text;
@end
