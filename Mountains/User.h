//
//  User.h
//  Mountains
//
//  Created by Тимур Аюпов on 04.06.16.
//  Copyright © 2016 Тимур Аюпов. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject
@property (strong, nonatomic) NSString *username;

- (instancetype)initWithUsername:(NSString *)username;
@end
