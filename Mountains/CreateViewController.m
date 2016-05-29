//
//  CreateViewController.m
//  Mountains
//
//  Created by Тимур Аюпов on 29.05.16.
//  Copyright © 2016 Тимур Аюпов. All rights reserved.
//

#import "CreateViewController.h"
@import FirebaseAuth;

@interface CreateViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordConfirmTextField;

@end

@implementation CreateViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _ref = [[FIRDatabase database] reference];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)createAction:(UIButton *)sender
{
    if (_usernameTextField.text && _emailTextField.text && _passwordTextField.text && ([_passwordTextField.text isEqualToString:_passwordConfirmTextField.text]))
    {
        [[FIRAuth auth] createUserWithEmail:_emailTextField.text password:_passwordConfirmTextField.text completion:^(FIRUser *_Nullable user, NSError *_Nullable error) {
          if (error)
          {
              [self showAlertViewWithError:error.localizedDescription];
              return;
          }
          FIRUserProfileChangeRequest *changeRequest = [[FIRAuth auth].currentUser profileChangeRequest];
          changeRequest.displayName = _usernameTextField.text;
          [changeRequest commitChangesWithCompletion:^(NSError *_Nullable error) {
            if (error)
            {
                [self showAlertViewWithError:error.localizedDescription];
                return;
            }
            [[[_ref child:@"users"] child:user.uid] setValue:@{ @"username" : _usernameTextField.text }];
            [self performSegueWithIdentifier:@"signIn" sender:nil];
          }];
        }];
    }
    else
    {
        [self showAlertViewWithError:@"Проверьте введеные данные"];
    }
}

- (void)showAlertViewWithError:(NSString *)error
{
    UIAlertController *alert = [UIAlertController
        alertControllerWithTitle:@"Ошибка"
                         message:error
                  preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *_Nonnull action) {
      [alert dismissViewControllerAnimated:YES completion:nil];
    }];
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
