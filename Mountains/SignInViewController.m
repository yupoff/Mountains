//
//  SignInViewController.m
//  Mountains
//
//  Created by Тимур Аюпов on 29.05.16.
//  Copyright © 2016 Тимур Аюпов. All rights reserved.
//

#import "SignInViewController.h"
@import FirebaseAuth;

@interface SignInViewController ()
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@end

@implementation SignInViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if ([FIRAuth auth].currentUser)
    {
        [self performSegueWithIdentifier:@"signIn" sender:nil];
    }
    _ref = [[FIRDatabase database] reference];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)signInAction:(UIButton *)sender
{
    [[FIRAuth auth] signInWithEmail:_emailTextField.text password:_passwordTextField.text completion:^(FIRUser *_Nullable user, NSError *_Nullable error) {
      if (error)
      {
          UIAlertController *alert = [UIAlertController
              alertControllerWithTitle:@"Ошибка"
                               message:error.localizedDescription
                        preferredStyle:UIAlertControllerStyleAlert];
          UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *_Nonnull action) {
            [alert dismissViewControllerAnimated:YES completion:nil];
          }];
          [alert addAction:ok];
          [self presentViewController:alert animated:YES completion:nil];
          return;
      }
      [[[_ref child:@"users"] child:user.uid]
          observeEventType:FIRDataEventTypeValue
                 withBlock:^(FIRDataSnapshot *_Nonnull snapshot) {
                   if (![snapshot exists])
                   {
                   }
                   else
                   {
                       [self performSegueWithIdentifier:@"signIn"
                                                 sender:nil];
                   }
                 }];

    }];
}

- (void)touchesBegan:(NSSet< UITouch * > *)touches withEvent:(UIEvent *)event
{
    [self.emailTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
}

@end
