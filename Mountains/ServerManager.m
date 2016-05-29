//
//  ServerManager.m
//  Mountains
//
//  Created by Тимур Аюпов on 30.05.16.
//  Copyright © 2016 Тимур Аюпов. All rights reserved.
//

#import "Mountain.h"
#import "ServerManager.h"
@import Firebase;

@interface ServerManager ()
@property (strong, nonatomic) FIRDatabaseReference *ref;
@end

@implementation ServerManager
{
}

+ (ServerManager *)sharedManager
{
    static ServerManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
      manager = [[ServerManager alloc] init];
    });
    return manager;
}

+ (void)getOrderedMountainsByStarCount:(void (^)(NSArray *mountains))succes onFailure:(void (^)(NSError *error))failure
{
    FIRDatabaseQuery *ref = [[[[FIRDatabase database] reference] child:@"mountains"] queryOrderedByChild:@"starCount"];
    NSMutableArray *dataArray = [NSMutableArray array];
    [ref observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot *_Nonnull snapshot) {
      for (NSDictionary *dict in snapshot.value)
      {
          Mountain *mountain = [[Mountain alloc] initWithDictinory:dict];
          [dataArray addObject:mountain];
      }
      succes([dataArray copy]);

    }
        withCancelBlock:^(NSError *_Nonnull error) {
          failure(error);
        }];
}
@end
