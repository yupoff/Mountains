//
//  Mountain.h
//  Mountains
//
//  Created by Тимур Аюпов on 29.05.16.
//  Copyright © 2016 Тимур Аюпов. All rights reserved.
//

#import "Location.h"
#import <Foundation/Foundation.h>

@interface Mountain : NSObject

@property (nonatomic, assign) NSInteger guid;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *body;
@property (nonatomic, strong) NSNumber *starCount;
@property (nonatomic, strong) NSString *image;
@property (nonatomic, strong) NSNumber *heightDifference;
@property (nonatomic, strong) NSNumber *countTracks;
@property (nonatomic, strong) NSNumber *totalLenghtTracks;
@property (nonatomic, strong) NSNumber *countLifts;
@property (nonatomic, strong) NSString *region;
@property (nonatomic, strong) Location *location;

- (instancetype)initWithDictinory:(NSDictionary *)dict;
@end
