//
//  LoginViewController.m
//  Mountains
//
//  Created by Тимур Аюпов on 09.05.16.
//  Copyright © 2016 Тимур Аюпов. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController () < UITextFieldDelegate >
@property (weak, nonatomic) IBOutlet CustomTextFieldStyle *loginTextField;
@property (weak, nonatomic) IBOutlet CustomTextFieldStyle *passwordTextField;

@end

@implementation LoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
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

- (void)touchesBegan:(NSSet< UITouch * > *)touches withEvent:(UIEvent *)event
{
    [self.loginTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([textField isEqual:self.loginTextField])
    {
        [self.passwordTextField becomeFirstResponder];
    }
    else
    {
        [textField resignFirstResponder];
    }
    return NO;
}

@end
