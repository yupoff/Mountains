//
//  ServerManager.h
//  Mountains
//
//  Created by Тимур Аюпов on 30.05.16.
//  Copyright © 2016 Тимур Аюпов. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ServerManager : NSObject
+ (ServerManager *)sharedManager;
+ (void)getOrderedMountainsByStarCount:(void (^)(NSArray *mountains))succes onFailure:(void (^)(NSError *error))failure;
@end
