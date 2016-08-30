//
//  NewPostViewController.m
//  Mountains
//
//  Created by Тимур Аюпов on 04.06.16.
//  Copyright © 2016 Тимур Аюпов. All rights reserved.
//

#import "NewPostViewController.h"
#import "Post.h"
#import "User.h"
@import Photos;
@import Firebase;
@import FirebaseStorage;

@interface NewPostViewController () < UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate >
@property (weak, nonatomic) IBOutlet UITextView *bodyTextView;
@property (weak, nonatomic) IBOutlet UIImageView *photoView;
@property (weak) IBOutlet UITextField *titleTextField;
@property (strong, nonatomic) FIRStorageReference *storageRef;
@property (strong, nonatomic) NSString *photoUrl;

@end

@implementation NewPostViewController

#pragma mark - UIViewController lifecycle methods
- (void)viewDidLoad
{
    [super viewDidLoad];

    // [START create_database_reference]
    self.ref = [[FIRDatabase database] reference];
    self.storageRef = [[FIRStorage storage] reference];
    // [END create_database_reference]
}

- (IBAction)didTapShare:(id)sender
{
    // [START single_value_read]
    NSString *userID = [FIRAuth auth].currentUser.uid;
    [[[_ref child:@"users"] child:userID] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot *_Nonnull snapshot) {
      // Get user value
      User *user = [[User alloc] initWithUsername:snapshot.value[@"username"]];

      // [START_EXCLUDE]

      // Write new post
      [self writeNewPost:userID
                username:user.username
                   title:_titleTextField.text
                    body:_bodyTextView.text
               immageUrl:_photoUrl];
      // Finish this Activity, back to the stream
      [[self navigationController] popViewControllerAnimated:YES];
      // [END_EXCLUDE]
    }
        withCancelBlock:^(NSError *_Nonnull error) {
          NSLog(@"%@", error.localizedDescription);
        }];
    // [END single_value_read]
}

- (void)writeNewPost:(NSString *)userID username:(NSString *)username title:(NSString *)title body:(NSString *)body immageUrl:(NSString *)imageUrl
{
    // Create new post at /user-posts/$userid/$postid and at
    // /posts/$postid simultaneously
    // [START write_fan_out]
    NSString *key = [[_ref child:@"posts"] childByAutoId].key;
    NSDictionary *post = @{ @"uid" : userID,
                            @"author" : username,
                            @"title" : title,
                            @"body" : body,
                            @"photoUrl" : imageUrl };
    NSDictionary *childUpdates = @{ [@"/posts/" stringByAppendingString:key] : post,
                                    [NSString stringWithFormat:@"/user-posts/%@/%@/", userID, key] : post };
    [_ref updateChildValues:childUpdates];
    // [END write_fan_out]
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return NO;
}
- (IBAction)addPhotoAction:(UIBarButtonItem *)sender
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = false;
    UIAlertController *view = [UIAlertController
        alertControllerWithTitle:nil
                         message:nil
                  preferredStyle:UIAlertControllerStyleActionSheet];

    UIAlertAction *camera = [UIAlertAction
        actionWithTitle:@"Камера"
                  style:UIAlertActionStyleDefault
                handler:^(UIAlertAction *action) {
                  //Do some thing here
                  [view dismissViewControllerAnimated:YES completion:nil];
                  picker.sourceType = UIImagePickerControllerSourceTypeCamera;
                  [self presentViewController:picker animated:YES completion:NULL];

                }];
    UIAlertAction *gallery = [UIAlertAction
        actionWithTitle:@"Галлерея"
                  style:UIAlertActionStyleDefault
                handler:^(UIAlertAction *action) {
                  [view dismissViewControllerAnimated:YES completion:nil];
                  picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
                  [self presentViewController:picker animated:YES completion:NULL];

                }];
    UIAlertAction *cancel = [UIAlertAction
        actionWithTitle:@"Отменить"
                  style:UIAlertActionStyleDefault
                handler:^(UIAlertAction *action) {
                  [view dismissViewControllerAnimated:YES completion:nil];

                }];
    [view addAction:camera];
    [view addAction:gallery];
    [view addAction:cancel];
    [self presentViewController:view animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary< NSString *, id > *)info
{
    [picker dismissViewControllerAnimated:YES completion:NULL];
    [_photoView setImage:[info objectForKey:UIImagePickerControllerOriginalImage]];
    UIActivityIndicatorView *actitvity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    actitvity.center = CGPointMake(_photoView.frame.size.width / 2, _photoView.frame.size.height / 2);
    [_photoView addSubview:actitvity];
    [actitvity startAnimating];
    NSURL *referenceUrl = info[UIImagePickerControllerReferenceURL];
    // if it's a photo from the library, not an image from the camera
    if (referenceUrl)
    {
        PHFetchResult *assets = [PHAsset fetchAssetsWithALAssetURLs:@[ referenceUrl ] options:nil];
        PHAsset *asset = [assets firstObject];
        [asset requestContentEditingInputWithOptions:nil
                                   completionHandler:^(PHContentEditingInput *contentEditingInput,
                                                       NSDictionary *info) {
                                     NSURL *imageFile = contentEditingInput.fullSizeImageURL;
                                     NSString *filePath =
                                         [NSString stringWithFormat:@"%@/%lld/%@",
                                                                    [FIRAuth auth].currentUser.uid,
                                                                    (long long)([[NSDate date] timeIntervalSince1970] * 1000.0),
                                                                    [imageFile lastPathComponent]];
                                     // [START uploadimage]
                                     [[_storageRef child:filePath]
                                            putFile:imageFile
                                           metadata:nil
                                         completion:^(FIRStorageMetadata *metadata, NSError *error) {
                                           if (error)
                                           {
                                               NSLog(@"Error uploading: %@", error);

                                               return;
                                           }
                                           NSLog(@"Upload");
                                           [actitvity stopAnimating];
                                           _photoUrl = [metadata.downloadURL relativeString];
                                         }];
                                     // [END uploadimage]
                                   }];
    }
    else
    {
        UIImage *image = info[UIImagePickerControllerOriginalImage];
        NSData *imageData = UIImageJPEGRepresentation(image, 0.8);
        NSString *imagePath =
            [NSString stringWithFormat:@"%@/%lld.jpg",
                                       [FIRAuth auth].currentUser.uid,
                                       (long long)([[NSDate date] timeIntervalSince1970] * 1000.0)];
        FIRStorageMetadata *metadata = [FIRStorageMetadata new];
        metadata.contentType = @"image/jpeg";
        [[_storageRef child:imagePath] putData:imageData metadata:metadata
                                    completion:^(FIRStorageMetadata *_Nullable metadata, NSError *_Nullable error) {
                                      if (error)
                                      {
                                          NSLog(@"Error uploading: %@", error);
                                          return;
                                      }
                                      NSLog(@"Upload");
                                      [actitvity stopAnimating];
                                      _photoUrl = [metadata.downloadURL relativeString];
                                    }];
    }
}

- (void)touchesBegan:(NSSet< UITouch * > *)touches withEvent:(UIEvent *)event
{
    [self.titleTextField resignFirstResponder];
    [self.bodyTextView resignFirstResponder];
}

@end
