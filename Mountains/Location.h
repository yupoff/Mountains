//
//  Location.h
//  Mountains
//
//  Created by Тимур Аюпов on 29.05.16.
//  Copyright © 2016 Тимур Аюпов. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Location : NSObject
@property (nonatomic, assign) double lon;
@property (nonatomic, assign) double lat;

- (instancetype)initWithDictinory:(NSDictionary *)dict;
@end
