//
//  ProfileViewController.m
//  Mountains
//
//  Created by Тимур Аюпов on 29.05.16.
//  Copyright © 2016 Тимур Аюпов. All rights reserved.
//

#import "ProfileViewController.h"
#import "SignInViewController.h"
@import FirebaseAuth;
@interface ProfileViewController ()
@property (weak, nonatomic) IBOutlet UILabel *nicknameLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;

@end

@implementation ProfileViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    FIRUser *user = [FIRAuth auth].currentUser;
    self.nicknameLabel.text = user.displayName;
    self.emailLabel.text = user.email;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)signOutAction:(UIBarButtonItem *)sender
{
    NSError *signOutError;
    BOOL status = [[FIRAuth auth] signOut:&signOutError];
    if (status)
    {
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }
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
