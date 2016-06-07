//
//  UploadCompanyLogoController.m
//  FFYB
//
//  Created by Suraj Naik on 20/05/16.
//  Copyright © 2016 Geniusu. All rights reserved.
//

#import "UploadCompanyLogoController.h"
#import <Parse.h>
#import "SCLAlertView.h"

@interface UploadCompanyLogoController ()

@end

@implementation UploadCompanyLogoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _DoneButton.buttonColor = [UIColor turquoiseColor];
    _DoneButton.shadowColor = [UIColor greenSeaColor];
    _DoneButton.shadowHeight = 3.0f;
    _DoneButton.cornerRadius = 6.0f;
    _DoneButton.titleLabel.font = [UIFont boldFlatFontOfSize:16];
    [_DoneButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
    [_DoneButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateHighlighted];
    
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDetected)];
    singleTap.numberOfTapsRequired = 1;
    _UploadLogo_ImageView.userInteractionEnabled = YES;
    [_UploadLogo_ImageView addGestureRecognizer:singleTap];
    
    [self gettingData];
    
  
}

-(void)tapDetected{
    [self PickOption];
    
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



-(void)EnterParseData: (NSData *)imageData {
    //[self popup_warning:Tittle];
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    indicator.frame = CGRectMake(0.0, 0.0, 10.0, 10.0);
    indicator.color = [UIColor yellowColor];
    indicator.center = self.view.center;
    [self.view addSubview:indicator];
    [indicator bringSubviewToFront:self.view];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = TRUE;
    [indicator startAnimating];
    
    
    
    PFQuery *query = [PFQuery queryWithClassName:@"Business"];
    
    // Retrieve the object by id
    [query getObjectInBackgroundWithId:_ObjectID_new
                                 block:^(PFObject *gameScore, NSError *error) {
                                     // Now let's update it with some new data. In this case, only cheatMode and score
                                     // will get sent to the cloud. playerName hasn't changed.
                                     PFFile *imageFile = [PFFile fileWithName:@"Image.jpg" data:imageData];
                                     
                                     gameScore[@"Company_Logo"] = imageFile;
                                     [gameScore saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                                         if (succeeded) {
                                             
                                             //  [self gettingData];
                                             // [self viewDidLoad];
                                             //  [self viewWillAppear:YES];
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






//> GettingData From Parse
#pragma GettingDataFromParse
-(void)gettingData{
    
    
    //  NSLog(@"%@", savedValue);
    
    
    PFQuery *query = [PFQuery queryWithClassName:Business_Name_APICall];
   
    [query whereKey:@"objectId" equalTo:_ObjectID_new];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            
            
            for (PFObject *object in objects) {
                //   recipeImages= objects ;
                
                PFFile *image = [object objectForKey:@"Company_Logo"];
                               
                
                
                
                
                
                
                [image getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
                    if (!error) {
                          self.UploadLogo_ImageView.image= [UIImage imageWithData:data];
                        
                        
                          self.UploadLogo_ImageView.contentMode = UIViewContentModeScaleAspectFill;
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                         self.UploadLogo_ImageView.layer.cornerRadius = 10;
                           self.UploadLogo_ImageView.clipsToBounds = YES;
                           self.UploadLogo_ImageView.layer.borderColor = [UIColor turquoiseColor].CGColor;
                          self.UploadLogo_ImageView.layer.borderWidth = 1.4f;
                        
                    }
                }];
                
                //  NSLog(@"%@",self.AllData);
                
                
            }
            
            // [self.collectionView reloadData];
        }
        
        
    }];
    
    
}

-(void)UserGallery{
     UIImagePickerController *imagePickerController = [[UIImagePickerController alloc]init];
    imagePickerController.delegate = self;
    imagePickerController.sourceType =  UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentModalViewController:imagePickerController animated:YES];
}


- (void)didReceiveMemoryWarning {
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

@end
