//
//  LoginViewController.m
//  FFYB
//
//  Created by Suraj Naik on 25/05/16.
//  Copyright © 2016 Geniusu. All rights reserved.
//

#import "LoginViewController.h"
#import "AFHTTPSessionManager.h"
#import "OAuth2Client.h"
#import <Parse/Parse.h>
#import "SCLAlertView.h"
@import MediaPlayer;



@interface LoginViewController ()
@property (strong, nonatomic) MPMoviePlayerController *moviePlayer;
@end



@implementation LoginViewController
CLLocationManager *locationManager;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
   locationManager = [[CLLocationManager alloc] init];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(signInNotificaitonReceived:) name:kOAuth2SignedInNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(signOutNotificaitonReceived:) name:kOAuth2SignedOutNotification object:nil];
   // NSLog(@"City %@",[self getFriendsAdressString]);
    
    
    
    [locationManager requestWhenInUseAuthorization];
    [locationManager startUpdatingLocation];
    
    
    
    
    [self GettingNumberOfRows];
    [self VideoPlayer];
    
   }

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    CLLocation* loc = [locations lastObject]; // locations is guaranteed to have at least one object
    float latitude = loc.coordinate.latitude;
    float longitude = loc.coordinate.longitude;
    NSLog(@"%.8f",latitude);
    NSLog(@"%.8f",longitude);
}
-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController.navigationBar setHidden:YES];
    self.tabBarController.tabBar.hidden = YES;
    
}
-(void)signOutNotificaitonReceived:(NSNotification *)notification {
    NSLog(@"%@",@"User Logged Out");
    
}

-(void)signInNotificaitonReceived:(NSNotification *)notification {
    NSLog(@"%@",@"User Logged In");
    [self getCredientialsFromApi];
    
}
- (void)getCredientialsFromApi {
    [[OAuth2Client sharedInstance] accessToken:^(NSString *accessToken) {
        if (accessToken != nil) {
            [self getCredientials_Data:accessToken];
            
           
        } else {
            
        
        }
    }];
}
- (IBAction)LoginButton:(id)sender {
    
   [self Login_Function];
   // [self performSegueWithIdentifier:@"goToUploadPic" sender:self];

  
}
//>-- Login
#pragma - LoginFunction
-(void)Login_Function{
    
   
     BOOL signedIn = [[OAuth2Client sharedInstance] signedIn];
    
     if (signedIn) {
     [[OAuth2Client sharedInstance] signOut];
     } else {
     [[OAuth2Client sharedInstance] authenticateInViewController:self];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//>--GettingCredentails
#pragma GettingCredentails
- (void)getCredientials_Data:(NSString*)AcessToken {
   __block NSString *ImageURL = nil;
    NSURL *url = [NSURL URLWithString:@"https://www.geniusu.com/api/v1/credentials/me"];
    NSDictionary *params = @{@"access_token": AcessToken};
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:url.absoluteString parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSLog(@"Response: %@", responseObject);
        
        [[NSUserDefaults standardUserDefaults] setObject:[responseObject valueForKey:@"full_name"] forKey:@"FullName"];
        if([responseObject valueForKey:@"Image_URL"] == (id)[NSNull null] ){
            [[NSUserDefaults standardUserDefaults] setObject:[responseObject valueForKey:@"image_url"] forKey:@"Image_URL"];
            ImageURL = [responseObject valueForKey:@"image_url"];
        }else{
           ImageURL = @"null";
            [[NSUserDefaults standardUserDefaults] setObject:@"null" forKey:@"Image_URL"];
        }
        [[NSUserDefaults standardUserDefaults] setObject:self.accessToken forKey:@"AcessToken"];
        [[NSUserDefaults standardUserDefaults] setObject:[responseObject valueForKey:@"salesforce_id"] forKey:@"UserID"];
         [[NSUserDefaults standardUserDefaults] setObject:[responseObject valueForKey:@"email"] forKey:@"Email"];
        // [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"LastName"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        //  [self performSegueWithIdentifier:@"goToMain" sender:self];
        
        
        [self checkFacebookID:[responseObject valueForKey:@"salesforce_id"]:[responseObject valueForKey:@"personality_type"]:
         [responseObject valueForKey:@"verified_result"]: [responseObject valueForKey:@"spectrum_level"]:ImageURL];
        //[self UPdateFacebookID:@"" :[responseObject valueForKey:@"personality_type"] :[responseObject valueForKey:@"verified_result"]];
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}




#pragma - GettingUserCity
-(NSString*)getFriendsAdressString{
    
        
    [locationManager startUpdatingLocation];
    
    
    [self.locationManager requestWhenInUseAuthorization];
    

    NSString* URL =[NSString stringWithFormat:@"https://maps.google.com/maps/api/geocode/json?latlng=%f,%f&sensor=true", locationManager.location.coordinate.latitude,locationManager.location.coordinate.longitude];
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:URL]];
  //  NSLog(@"URL %@",URL);
            [request setHTTPMethod:@"POST"];
            
            NSError *err;
            NSURLResponse *response;
            NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
                     NSString *resSrt = [[NSString alloc]initWithData:responseData encoding:NSASCIIStringEncoding];
            
            if(resSrt){
                
                NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:nil];
               //  NSLog(@"%@ Location",dict);
                
                if(dict){
                
         NSString *longaddr=[[[dict objectForKey:@"results"] objectAtIndex:0]objectForKey:@"formatted_address"];
                
               NSLog(@"%@ Location_CITY",longaddr);
                NSArray* foo = [longaddr componentsSeparatedByString: @","];
                NSString* firstBit = [foo objectAtIndex: 1];
                
                return firstBit;
                }else{
                    NSLog(@"%@",@"It's Empty!");
                };
            }
        
    return @"City";
    
}
-(void)checkFacebookID: (NSString*)ID:(NSString*)GeniusUProfile:(NSString*)WDP:(NSString*)SpectrumLevel:(NSString*)ImageURL{
    
    
    
    
    
    SCLAlertView *alert = [[SCLAlertView alloc] init];
    
    alert.showAnimationType = SlideInToCenter;
    alert.hideAnimationType = SlideOutFromCenter;
    
    alert.backgroundType = Blur;
    
    [alert showWaiting:self title:@"Waiting..."
              subTitle:@"Doing some boring stuff"
      closeButtonTitle:nil duration:5.0f];
    
    PFQuery *query = [PFQuery queryWithClassName:@"USERIDS"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            
            for (PFObject *object in objects) {
                
                NSArray *VotedID = [object valueForKey:@"UserIDS"] ;
             
                
                
                
                
                if([VotedID containsObject:ID]){
                    
                    
                    NSLog(@"%@",@"Contains the ID");
                    
                    //[self popup_warning:@"It contains and is not going thru"];
                    
                    [self performSegueWithIdentifier:@"goToMain" sender:self];
                                      PFInstallation *currentInstallation = [PFInstallation currentInstallation];
                    // [currentInstallation setDeviceTokenFromData:deviceToken];
                    NSString *objectID =[[NSUserDefaults standardUserDefaults]
                                         stringForKey:@"UserID"];;
                    
                    currentInstallation [@"UserObjectID"] = objectID;
                    [currentInstallation saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                     
                        
                                           }];
                    
                    }else{
                    
                            NSLog(@"%@",@"Does not contain ID");
                        
                    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
                        [self UPdateFacebookID:ID:GeniusUProfile:WDP:SpectrumLevel:ImageURL];
                    currentInstallation [@"UserObjectID"] = ID;
                    [currentInstallation saveInBackground];
                    
            
                }
            }
            
            
        }else{
            
        }
    }];
    
}

//>-- UpdateFacebookID
#pragma UpadateFacebookID
-(void)UPdateFacebookID: (NSString*) ID:(NSString*) GeniusProfile:(NSString*) WDP:(NSString*)SpectrumLevel:(NSString*)ImageURL{
    
    PFQuery *query = [PFQuery queryWithClassName:@"USERIDS"];
    
    // Retrieve the object by id
    [query getObjectInBackgroundWithId:@"zbQbMczJbg"
                                 block:^(PFObject *gameScore, NSError *error) {
                                     // Now let's update it with some new data. In this case, only cheatMode and score
                                     // will get sent to the cloud. playerName hasn't changed.
                                     [gameScore addObject:ID forKey:@"UserIDS"];
                                     
                                     [gameScore saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                                         if (succeeded) {
                                             
                                             if(_Count > 1000){
                                                 [self EnterParseData_01:ID:GeniusProfile:WDP:SpectrumLevel:ImageURL];
                                             }else{
                                                 [self EnterParseData:ID:GeniusProfile:WDP:SpectrumLevel:ImageURL];
                                             }
                                           
                                             
                                             
                                             
                                         } else {
                                             [self popup_warning:error.description];
                                             
                                                                                    }
                                     }];
                                     
                                 }];
    
}
- (void)loopVideo {
    [self.moviePlayer play];
}

#pragma VideoPlayer
-(void)VideoPlayer{
    NSURL *videoURL = [[NSBundle mainBundle] URLForResource:@"FFYB" withExtension:@"mov"];
    self.moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:videoURL];
    self.moviePlayer.controlStyle = MPMovieControlStyleNone;
    self.moviePlayer.scalingMode = MPMovieScalingModeAspectFill;
    self.moviePlayer.view.frame = self.view.frame;
    [self.view insertSubview:self.moviePlayer.view atIndex:0];
    [self.view insertSubview:_LoginButton atIndex:1];
    [self.moviePlayer play];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loopVideo) name:MPMoviePlayerPlaybackDidFinishNotification object:self.moviePlayer];
}


//>--EnterParseData
#pragma EnterParseData
-(void)EnterParseData:(NSString*)ID:(NSString*)GenisuProfile:(NSString*)WDprofile:(NSString*)SpectrumLevel:(NSString*)ImageURL{
    
    
    
    // NSString *UniqueNo = [[NSUserDefaults standardUserDefaults]
    //                     stringForKey:@"UserID"];
    NSString *FullName = [[NSUserDefaults standardUserDefaults]
                          stringForKey:@"FullName"];
    
    //  NSLog(@"Async JSON: %@", UniqueNo);
    
    PFObject *gameScore = [PFObject objectWithClassName:@"UserDetails"];
    gameScore[GeniusU_Profile_Constant] = GenisuProfile;
    gameScore[WDP_Profile_Constant] = WDprofile;
    gameScore[@"Profession"] =@"Enter Profession";
    gameScore[Spectrum_Level_Constant] =SpectrumLevel;
    gameScore[@"AboutSelf"] =@"Write About Yourself";
    gameScore[User_Unique_ID_Constant] = ID;
    gameScore[FullName_Constant] = FullName;
    gameScore[User_City_Constant]=[self getFriendsAdressString];
    gameScore[@"ImageURL"] = ImageURL;
    [gameScore addObject:@"000"  forKey:@"FavPeople"];
     [gameScore addObject:@"000"  forKey:@"FavCompanies"];
    
    
    // gameScore[@"UserObjectID"] = [[PFUser currentUser]objectId ];
    
    
    
    [gameScore saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            
            
            [[NSUserDefaults standardUserDefaults] setObject:gameScore.objectId forKey:@"UserID"];
              [[NSUserDefaults standardUserDefaults] setObject:@"ClassName" forKey:@"UserDetails_01"];
            [[NSUserDefaults standardUserDefaults] synchronize];
       
            
       // [self.navigationController popToRootViewControllerAnimated:NO];
            [self CheckIfProfilePicExists];
        
        } else {
           
            [self popup_warning:error.description];
            // There was a problem, check error.description
        }
    }];
}
-(void)CheckIfProfilePicExists{
    NSString *ImageURL = [[NSUserDefaults standardUserDefaults]
                               stringForKey:@"Image_URL"];
    
    if([ImageURL isEqualToString:@"null"]){
        [self performSegueWithIdentifier:@"goToUploadPic" sender:self];

    }else{
         [self.navigationController popToRootViewControllerAnimated:NO];
    }
    
}

#pragma EnterParseData
-(void)EnterParseData_01:(NSString*)ID:(NSString*)GenisuProfile:(NSString*)WDprofile:(NSString*)SpectrumLevel:(NSString*)ImageURL{
    
    
    
    // NSString *UniqueNo = [[NSUserDefaults standardUserDefaults]
    //                     stringForKey:@"UserID"];
    NSString *FullName = [[NSUserDefaults standardUserDefaults]
                          stringForKey:@"FullName"];
    
    //  NSLog(@"Async JSON: %@", UniqueNo);
    
    PFObject *gameScore = [PFObject objectWithClassName:@"UserDetails01"];
    gameScore[GeniusU_Profile_Constant] = GenisuProfile;
    gameScore[WDP_Profile_Constant] = WDprofile;
    gameScore[@"Profession"] =@"Enter Profession";
    gameScore[Spectrum_Level_Constant] =SpectrumLevel;
    gameScore[@"AboutSelf"] =@"Write About Yourself";
    gameScore[User_Unique_ID_Constant] = ID;
    gameScore[FullName_Constant] = FullName;
    gameScore[User_City_Constant]=[self getFriendsAdressString];
    
    [gameScore addObject:@"000"  forKey:@"EventsAttending"];
    
    
    // gameScore[@"UserObjectID"] = [[PFUser currentUser]objectId ];
    
    
    
    [gameScore saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            
            
            [[NSUserDefaults standardUserDefaults] setObject:gameScore.objectId forKey:@"UserID"];
            [[NSUserDefaults standardUserDefaults] setObject:@"ClassName" forKey:@"UserDetails_02"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            [self.navigationController popToRootViewControllerAnimated:NO];
            
        } else {
            
            [self popup_warning:error.description];
            // There was a problem, check error.description
        }
    }];
}

#pragma CountUserDetails Row

-(void)GettingNumberOfRows{
    PFQuery *query = [PFQuery queryWithClassName:@"UserDetails"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
          
          
           _Count = [objects count];
            
          
        }
        
       
    }];
   
}
-(void)popup_warning : (NSString*) warning{
    SCLAlertView *alert = [[SCLAlertView alloc] init];
    
    alert.backgroundViewColor = [UIColor yellowColor];
    alert.backgroundType = Shadow;
    alert.shouldDismissOnTapOutside = YES;
    [alert showError:self title:@"Hold On..."
            subTitle:warning
    closeButtonTitle:@"OK" duration:0.0f];
    
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
