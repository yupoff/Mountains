//
//  NewPostViewController.h
//  Mountains
//
//  Created by Тимур Аюпов on 04.06.16.
//  Copyright © 2016 Тимур Аюпов. All rights reserved.
//

@import UIKit;
@import Firebase;

@interface NewPostViewController
    : UIViewController

@property (strong, nonatomic) FIRDatabaseReference *ref;

@end
