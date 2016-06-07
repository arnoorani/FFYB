//
//  UploadProfilePicController.m
//  FFYB
//
//  Created by Suraj Naik on 01/06/16.
//  Copyright © 2016 Geniusu. All rights reserved.
//

#import "UploadProfilePicController.h"
#import <Parse/Parse.h>
#import "SCLAlertView.h"

@interface UploadProfilePicController ()

@end

@implementation UploadProfilePicController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDetected)];
    singleTap.numberOfTapsRequired = 1;
    _ProfilePic.userInteractionEnabled = YES;
    [_ProfilePic addGestureRecognizer:singleTap];
    
    _SkipThisStep.buttonColor = [UIColor turquoiseColor];
    _SkipThisStep.shadowColor = [UIColor greenSeaColor];
    _SkipThisStep.shadowHeight = 3.0f;
    _SkipThisStep.cornerRadius = 6.0f;
    _SkipThisStep.titleLabel.font = [UIFont boldFlatFontOfSize:16];
    [_SkipThisStep setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
    [_SkipThisStep setTitleColor:[UIColor cloudsColor] forState:UIControlStateHighlighted];
    [_SkipThisStep addTarget:self action:@selector(SkipthisStep_Function) forControlEvents:UIControlEventTouchUpInside];
    
  


}
-(void)tapDetected{
    [self PickOption];
    
}
-(void)SkipthisStep_Function{
    [self performSegueWithIdentifier:@"goToMain" sender:self];
  //  [self.navigationController popToRootViewControllerAnimated:NO];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)PickOption{
    SCLAlertView *alert = [[SCLAlertView alloc] init];
    alert.shouldDismissOnTapOutside = YES;
    {
        [alert addButton:@"Pick From Gallery" actionBlock:^(void) {
            [self UserGallery];
        }];
        
        [alert addButton:@"Use Camera" actionBlock:^(void) {
            //  NSLog(@"Second button tapped");
            [self UseCamera];
        }];
        
        
        [alert showQuestion:self title:@"Change Profile Picture" subTitle:@"Pick an option" closeButtonTitle:@"Dismiss" duration:0.0f];
    }
}
//> GettingData From Parse
#pragma GettingDataFromParse
-(void)gettingData{
    
    
    //
    
    NSString *UserdUniqueID = [[NSUserDefaults standardUserDefaults]
                               stringForKey:@"UserID"];
    NSLog(@"%@", UserdUniqueID);
    PFQuery *query = [PFQuery queryWithClassName:@"UserDetails"];
    
    [query whereKey:@"objectId" equalTo:@"3eoALemCZT"];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            
            
            for (PFObject *object in objects) {
                //   recipeImages= objects ;
                
                PFFile *image = [object objectForKey:@"ProfileImage"];
                [image getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
                    if (!error) {
                        _ProfilePic.image= [UIImage imageWithData:data];
                        _ProfilePic.contentMode = UIViewContentModeScaleAspectFill;
                        _ProfilePic.layer.cornerRadius = 10;
                        _ProfilePic.clipsToBounds = YES;
                        _ProfilePic.layer.borderColor = [UIColor turquoiseColor].CGColor;
                        _ProfilePic.layer.borderWidth = 1.4f;
                        [_SkipThisStep setTitle:@"Done" forState:UIControlStateNormal];

                        
                    }
                }];
                
                //  NSLog(@"%@",self.AllData);
                
                
            }
            // [self.collectionView reloadData];
        }else{
                    }

        
        
    }];
    
    
}


-(void)UserGallery{
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc]init];
    imagePickerController.delegate = self;
    imagePickerController.sourceType =  UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentModalViewController:imagePickerController animated:YES];
}

-(void)UseCamera{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] == YES) {
        // Create image picker controller
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        
        // Set source to the camera
        imagePicker.sourceType =  UIImagePickerControllerSourceTypeCamera;
        
        // Delegate is self
        imagePicker.delegate = self;
        
        // Show image picker
        [self presentViewController:imagePicker animated:YES completion:nil];
    }
    else{
        // Device has no camera
        UIImage *image;
        int r = arc4random() % 5;
        switch (r) {
            case 0:
                image = [UIImage imageNamed:@"ParseLogo.jpg"];
                break;
            case 1:
                image = [UIImage imageNamed:@"Crowd.jpg"];
                break;
            case 2:
                image = [UIImage imageNamed:@"Desert.jpg"];
                break;
            case 3:
                image = [UIImage imageNamed:@"Lime.jpg"];
                break;
            case 4:
                image = [UIImage imageNamed:@"Sunflowers.jpg"];
                break;
            default:
                break;
        }
        
        // Resize image
        UIGraphicsBeginImageContext(CGSizeMake(640, 960));
        [image drawInRect: CGRectMake(0, 0, 640, 960)];
        UIImage *smallImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        NSData *imageData = UIImageJPEGRepresentation(smallImage, 0.05f);
        [self uploadImage:imageData];
    }
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    // Access the uncropped image from info dictionary
    UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    
    // Dismiss controller
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    // Resize image
    UIGraphicsBeginImageContext(CGSizeMake(640, 960));
    [image drawInRect: CGRectMake(0, 0, 640, 960)];
    UIImage *smallImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // Upload image
    NSData *imageData = UIImageJPEGRepresentation(smallImage, 0.05f);
    [self EnterParseData:imageData];
}
-(void)EnterParseData: (NSData *)imageData {
    NSString *UserdUniqueID = [[NSUserDefaults standardUserDefaults]
                               stringForKey:@"UserID"];
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    indicator.frame = CGRectMake(0.0, 0.0, 10.0, 10.0);
    indicator.color = [UIColor yellowColor];
    indicator.center = self.view.center;
    [self.view addSubview:indicator];
    [indicator bringSubviewToFront:self.view];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = TRUE;
    [indicator startAnimating];
    
    
    
    PFQuery *query = [PFQuery queryWithClassName:@"UserDetails"];
    
    // Retrieve the object by id
    [query getObjectInBackgroundWithId:@"3eoALemCZT"
                                 block:^(PFObject *gameScore, NSError *error) {
                                     // Now let's update it with some new data. In this case, only cheatMode and score
                                     // will get sent to the cloud. playerName hasn't changed.
                                     PFFile *imageFile = [PFFile fileWithName:@"Image.jpg" data:imageData];
                                     
                                     gameScore[@"ProfileImage"] = imageFile;
                                     [gameScore saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                                         if (succeeded) {
                                             
                                            [indicator stopAnimating];
                                             
                                             SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
                                             
                                             
                                             
                                             [alert showSuccess:@"WOW!"subTitle:@"You Look Great" closeButtonTitle:@"Thanks!" duration:0.0f];
                                             [self gettingData];
                                             
                                         } else {
                                             [indicator stopAnimating];
                                             
                                             // There was a problem, check error.description
                                         }
                                     }];
                                 }];
}

- (void)uploadImage:(NSData *)imageData


{
    
    NSString *savedValue = [[NSUserDefaults standardUserDefaults]
                            stringForKey:@"UserID"];
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    indicator.frame = CGRectMake(0.0, 0.0, 10.0, 10.0);
    indicator.center = self.view.center;
    [self.view addSubview:indicator];
    [indicator bringSubviewToFront:self.view];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = TRUE;
    [indicator startAnimating];
    
    PFFile *imageFile = [PFFile fileWithName:@"Image.jpg" data:imageData];
    
    
    // Save PFFile
    [imageFile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            //Hide determinate HUD
            
            // Show checkmark
            
            
            
            // The sample image is based on the work by http://www.pixelpressicons.com, http://creativecommons.org/licenses/by/2.5/ca/
            // Make the customViews 37 by 37 pixels for best results (those are the bounds of the build-in progress indicators)
            [indicator stopAnimating];
            
            // Set custom view mode
            
            
            
            // Create a PFObject around a PFFile and associate it with the current user
            PFObject *userPhoto = [PFObject objectWithClassName:Business_Name_APICall];
            [userPhoto setObject:imageFile forKey:@"imageFile"];
            userPhoto[@"Company_Logo"]= savedValue;
            
            // Set the access control list to current user for security purposes
            // userPhoto.ACL = [PFACL ACLWithUser:[PFUser currentUser]];
            
            
            [userPhoto saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (!error) {
                    //   [self refresh:nil];
                    [self gettingData];
                }
                else{
                    // Log details of the failure
                    NSLog(@"Error: %@ %@", error, [error userInfo]);
                }
            }];
        }
        else{
            [indicator stopAnimating];
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    } progressBlock:^(int percentDone) {
        // Update your progress spinner here. percentDone will be between 0 and 100.
        
    }];
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
