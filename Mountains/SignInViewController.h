//
//  SignInViewController.h
//  Mountains
//
//  Created by Тимур Аюпов on 29.05.16.
//  Copyright © 2016 Тимур Аюпов. All rights reserved.
//

#import <UIKit/UIKit.h>
@import Firebase;

@interface SignInViewController : UIViewController <UITextFieldDelegate>
@property (strong, nonatomic) FIRDatabaseReference *ref;

@end
