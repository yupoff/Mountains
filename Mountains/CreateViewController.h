//
//  CreateViewController.h
//  Mountains
//
//  Created by Тимур Аюпов on 29.05.16.
//  Copyright © 2016 Тимур Аюпов. All rights reserved.
//

#import <UIKit/UIKit.h>
@import Firebase;

@interface CreateViewController : UIViewController
@property (strong, nonatomic) FIRDatabaseReference *ref;
@end
