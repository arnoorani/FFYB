//
//  DiscoverViewController.m
//  FFYB
//
//  Created by Suraj Naik on 20/05/16.
//  Copyright © 2016 Geniusu. All rights reserved.
//

#import "DiscoverViewController.h"
#import "UIColor+FlatUI.h"
#import <Parse/Parse.h>
#import "SCLAlertView.h"
#import "LocationManagerSingleton.h"
#import "ProfileVC.h"
#import "AFHTTPSessionManager.h"
#import "OAuth2Client.h"


@interface DiscoverViewController ()

@end

@implementation DiscoverViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
    
    
    BOOL signedIn = [[OAuth2Client sharedInstance] signedIn];
    
    if (signedIn) {
        //[[OAuth2Client sharedInstance] signOut];
    } else {
      //  [self performSegueWithIdentifier:@"goToLogin" sender:self];
        // [[OAuth2Client sharedInstance] authenticateInViewController:self];
    }

    
   
    [self setUpSegemtnController];
    
    
    [self setUpViewData];
    [self FadINAnimaation];
    
    
     // [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName : [UIColor whiteColor] }
                                            // forState:UIControlStateNormal];
   // [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName : [UIColor midnightBlueColor] }
                                           //  forState:UIControlStateSelected];
    
  
    //[self gettingData_People_01];
    
  
    NSString *ClassName = [[NSUserDefaults standardUserDefaults]
                               stringForKey:@"ClassName"];
    
    if([ClassName isEqualToString:@"UserDetails_01"]){
        [self EnterParseData:@"UserDetails"];
        
    }
    if([ClassName isEqualToString:@"UserDetails_02"]){
       [self EnterParseData:@"UserDetails2"];
    }

  
}

-(void)EnterParseData: (NSString *)ClassName {
    NSString *UserdUniqueID = [[NSUserDefaults standardUserDefaults]
                               stringForKey:ClassName];
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    indicator.frame = CGRectMake(0.0, 0.0, 10.0, 10.0);
    indicator.color = [UIColor yellowColor];
    indicator.center = self.view.center;
    [self.view addSubview:indicator];
    [indicator bringSubviewToFront:self.view];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = TRUE;
    [indicator startAnimating];
    
     NSLog(@"Location%f,%f",[LocationManagerSingleton sharedSingleton].locationManager.location.coordinate.latitude,[LocationManagerSingleton sharedSingleton].locationManager.location.coordinate.longitude);
    
    PFQuery *query = [PFQuery queryWithClassName:@"UserDetails"];
    
    // Retrieve the object by id
    [query getObjectInBackgroundWithId:UserdUniqueID
                                 block:^(PFObject *gameScore, NSError *error) {
                                     // Now let's update it with some new data. In this case, only cheatMode and score
                                     // will get sent to the cloud. playerName hasn't changed.
                                     
                                     [gameScore saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                                         if (succeeded) {
                                             
                                             
                                             PFGeoPoint *point = [PFGeoPoint geoPointWithLatitude:[LocationManagerSingleton sharedSingleton].locationManager.location.coordinate.latitude longitude:[LocationManagerSingleton sharedSingleton].locationManager.location.coordinate.longitude];
                                             gameScore[@"UserLocation"] = point;

                                             
                                             [indicator stopAnimating];
                                             
                                             
                                         } else {
                                             [indicator stopAnimating];
                                             
                                             // There was a problem, check error.description
                                         }
                                     }];
                                 }];
}

-(void)CreateData{
    PFObject *gameScore = [PFObject objectWithClassName:@"UserDetails2"];
    gameScore[GeniusU_Profile_Constant] = @"Dynamo";
    gameScore[WDP_Profile_Constant] = @"wealth";
    gameScore[@"Profession"] =@"Enter Profession";
    gameScore[Spectrum_Level_Constant] =@"Orange";
    gameScore[@"AboutSelf"] =@"Write About Yourself";
    gameScore[User_Unique_ID_Constant] = @"00";
    gameScore[FullName_Constant] = @"Ali Noorani";
    gameScore[User_City_Constant]=@"Mumbai";
    gameScore[@"ImageURL"] = @"null";
    [gameScore addObject:@"000"  forKey:@"FavPeople"];
    [gameScore addObject:@"000"  forKey:@"FavCompanies"];
    
    
    // gameScore[@"UserObjectID"] = [[PFUser currentUser]objectId ];
    
    
    
    [gameScore saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            
            
            [[NSUserDefaults standardUserDefaults] setObject:gameScore.objectId forKey:@"UserID"];
            
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            
            // [self.navigationController popToRootViewControllerAnimated:NO];
          
            
        } else {
            
                        // There was a problem, check error.description
        }
    }];

}
-(void)FadINAnimaation{
    discovertableView.alpha=1.0;
    discovertableView.hidden=NO;
    [UIView transitionWithView:discovertableView
                      duration:1.5
                       options:UIViewAnimationOptionTransitionCurlUp
                    animations:^{
                        discovertableView.hidden=YES;
                        discovertableView.alpha=0.0;
                    } completion:nil];
    
    discovertableView.alpha=0.0;
    discovertableView.hidden=YES;
    [UIView transitionWithView:discovertableView
                      duration:1.5
                       options:UIViewAnimationOptionTransitionCurlUp
                    animations:^{
                        discovertableView.hidden=NO;
                        discovertableView.alpha=1.0;
                    } completion:nil];
}
-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = NO;
    self.tabBarController.tabBar.barTintColor = [UIColor greenSeaColor];

    self.navigationItem.leftBarButtonItem=nil;
    self.navigationItem.hidesBackButton = YES;
    [self.navigationItem setHidesBackButton:YES animated:YES];   
    [self.navigationItem setHidesBackButton:YES];
    
    self.navigationItem.leftBarButtonItem = ({
        
        UIBarButtonItem *button;
        
        button = [[UIBarButtonItem alloc] initWithTitle:@"Scan BarCode" style:UIBarButtonItemStylePlain target:self action:@selector(GoToScanner)];
        [button setTitleTextAttributes:
         [NSDictionary dictionaryWithObjectsAndKeys:
          [UIColor whiteColor], NSForegroundColorAttributeName,nil]
                              forState:UIControlStateNormal];
        
        
        button;
    });

    
}
-(void)GoToScanner{
     [self performSegueWithIdentifier:@"goToScanner" sender:self];
}

-(void)gettingData_People_01{
    
    _DataType = @"People";
      
    
    PFQuery *query = [PFQuery queryWithClassName:@"UserDetails"];
    //  [query orderByAscending:@"Day"];
    // [query whereKey:@"Day" containsString:Day];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            
            
            //  for (PFObject *object in objects) {
            _AllData_01 = objects ;
            
            
            //}
            
            
        }
        [discovertableView reloadData];

        
    }];
    
    
}

-(void)gettingData_People_02{
    
    _DataType = @"People";
    SCLAlertView *alert = [[SCLAlertView alloc] init];
    alert.customViewColor = [UIColor greenSeaColor];
    alert.showAnimationType = SlideInToCenter;
    alert.hideAnimationType = SlideOutFromCenter;
    
    alert.backgroundType = Blur;
    
    [alert showWaiting:self title:@"Please Wait"
              subTitle:@"Loading People"
      closeButtonTitle:nil duration:1.2f];
    
    
    PFQuery *query = [PFQuery queryWithClassName:@"UserDetails2"];
    //  [query orderByAscending:@"Day"];
    // [query whereKey:@"Day" containsString:Day];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            
            
            //  for (PFObject *object in objects) {
            _AllData_02 = objects ;
           
            
            //}
            
            
        }
        
      _AllData_Final=[_AllData_01 arrayByAddingObjectsFromArray:_AllData_02];
        [discovertableView reloadData];
        
    }];
    
    
}


-(void)gettingData_Company_01{
    
    // NSLog(@"%@", @"LOG");
    _DataType = @"Company";
    SCLAlertView *alert = [[SCLAlertView alloc] init];
    alert.customViewColor = [UIColor greenSeaColor];
    alert.showAnimationType = SlideInToCenter;
    alert.hideAnimationType = SlideOutFromCenter;
    
    alert.backgroundType = Blur;
    
    [alert showWaiting:self title:@"Please Wait"
              subTitle:@"Loading Companies"
      closeButtonTitle:nil duration:1.7f];
    
    
    PFQuery *query = [PFQuery queryWithClassName:@"Business"];
    //  [query orderByAscending:@"Day"];
    // [query whereKey:@"Day" containsString:Day];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            
            
            //  for (PFObject *object in objects) {
            _AllData_Final = objects ;
            
            
            //}
            
            
        }
        [discovertableView reloadData];
        
        
    }];
    
    
}


#pragma - BarCodeAlertView
-(void)BarCodeAlertView{
    
    _PreviousScreen = [UIScreen mainScreen].brightness;
    
    [UIScreen mainScreen].brightness = 1;
    CustomIOSAlertView *alertView = [[CustomIOSAlertView alloc] init];
    
    // Add some custom content to the alert view
    [alertView setContainerView:[self createDemoView]];
    
    // Modify the parameters
    [alertView setButtonTitles:[NSMutableArray arrayWithObjects:@"Dismiss", nil]];
    [alertView setDelegate:self];
    
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    self.EffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    self.EffectView.frame = self.view.bounds;
    self.EffectView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [self.view addSubview:self.EffectView];
    
    
    
    
    // You may use a Block, rather than a delegate.
    [alertView setOnButtonTouchUpInside:^(CustomIOSAlertView *alertView, int buttonIndex) {
        NSLog(@"Block: Button at position %d is clicked on alertView %d.", buttonIndex, (int)[alertView tag]);
        [alertView close];
    }];
    
    [alertView setUseMotionEffects:true];
    
    // And launch the dialog
    [alertView show];
}

- (UIView *)createDemoView
{
    UIView *demoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 290, 290)];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 270, 270)];
    [imageView setImage:[UIImage imageNamed:@"QR_Code.png"]];
    [demoView addSubview:imageView];
    
    return demoView;
}
- (void)customIOS7dialogButtonTouchUpInside: (CustomIOSAlertView *)alertView clickedButtonAtIndex: (NSInteger)buttonIndex
{
    [UIScreen mainScreen].brightness = _PreviousScreen;
    [self.EffectView removeFromSuperview];
    [alertView close];
}

-(void)setUpViewData
{
    _discoverDataArray = [[NSMutableArray alloc]init];
    
    NSArray *tempNameArray = [[NSArray alloc]initWithObjects:@"Suraj Naik",@"Karl",@"Ali",@"Krishna", nil];
     NSArray *tempImageArray = [[NSArray alloc]initWithObjects:@"Suraj Naik",@"Karl",@"Ali",@"Krishna", nil];
     NSArray *tempDesignationArray = [[NSArray alloc]initWithObjects:@"Suraj Naik",@"Karl",@"Ali",@"Krishna", nil];
    
    for (int i = 0; i <tempNameArray.count ; i++) {
        NSMutableDictionary *tempDict = [[NSMutableDictionary alloc]init];
        [tempDict setObject:[tempNameArray objectAtIndex:i] forKey:@"Name"];
        [tempDict setObject:[tempImageArray objectAtIndex:i] forKey:@"Image"];
        [tempDict setObject:[tempDesignationArray objectAtIndex:i] forKey:@"Designation"];
        [_discoverDataArray addObject:tempDict];
    }
    [discovertableView reloadData];
    
}




#pragma mark == TableView Data Source And Delegates
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_AllData_Final count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"DiscoverCustomCell";
    
    DiscoverCustomCell *tableCell1 = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    PFObject *Dates = [_AllData_Final objectAtIndex:indexPath.row];
    
    if([_DataType isEqualToString:@"People"]){
    tableCell1.userName.text = [Dates valueForKey:@"FullName"];
    tableCell1.userDesignation.text = [Dates valueForKey:@"Profession"];
    
        
        
        
    if([[Dates valueForKey:@"ImageURL"] isEqualToString:@"null"]){
      
        
        dispatch_queue_t q = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
        dispatch_async(q, ^{
            
              PFFile *image = [Dates objectForKey:@"ProfileImage"];
            /* Fetch the image from the server... */
        dispatch_async(dispatch_get_main_queue(), ^{
            if(image){
                [image getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
                    if (!error) {
                        
                        tableCell1.userImage.image = [UIImage imageWithData:data];
                    }
                    
                }];
                
                
            }else{
                tableCell1.imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[Dates valueForKey:@"ImageURL"]]]];
                
            }
              
            });
        });
        
        
        
        
  
            
    

   
    }else{
        NSString *url_Img1 = [Dates valueForKey:@"ImageURL"];
        tableCell1.userImage.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:url_Img1]]];
    }
    
        //   tableCell1.userImage.image = [UIImage imageNamed:[[discoverDataArray objectAtIndex:indexPath.row] valueForKey:@"Image"]];
    }else{
        tableCell1.userName.text = [Dates valueForKey:BusinessName];
        tableCell1.userDesignation.text = [Dates valueForKey:BusinessCatagory];
        PFFile *image = [Dates objectForKey:@"ProfileImage"];
        
        if(image){
            [image getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
                if (!error) {
                    
                    tableCell1.userImage.image = [UIImage imageWithData:data];
                }
                
            }];

        }
  
    }
    
    tableCell1.userImage.layer.cornerRadius = 42.0;
    tableCell1.userImage.layer.masksToBounds = true;
    //or
    [tableCell1.userImage.layer setBorderColor:[UIColor cloudsColor].CGColor];
    [tableCell1.userImage.layer setBorderWidth:2.0f];
    
    
    tableCell1.userImage.layer.cornerRadius = tableCell1.userImage.layer.frame.size.width / 2;
    tableCell1.userImage.clipsToBounds = true;
    
    return tableCell1;
}

-(void)tableView:(UITableView *)tableView_in willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Remove seperator inset
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    // Prevent the cell from inheriting the Table View's margin settings
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
    
    // Explictly set your cell's layout margins
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}
-(void)setUpSegemtnController
{
    if (mainSegment ) {
        [mainSegment removeFromSuperview];
        mainSegment = nil;
    }
    mainSegment = [[UISegmentedControl alloc] initWithItems:[[NSArray alloc]initWithObjects:@"People",@"Nearby",@"Companies", nil]];
    CGFloat tabBarHeight = self.tabBarController.tabBar.frame.origin.y;
    
    mainSegment.frame = CGRectMake(-1,SCREEN_HEIGHT-150, SCREEN_WIDTH+1, 40);
    mainSegment.selectedSegmentIndex = 0;
    mainSegment.backgroundColor = [UIColor greenSeaColor];
    [mainSegment addTarget:self action:@selector(mainSegmentControl:) forControlEvents: UIControlEventValueChanged];
    
    [[UISegmentedControl appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor],NSFontAttributeName : [UIFont fontWithName:@"Helvetica-Bold" size:15.0], NSFontAttributeName : [UIFont systemFontOfSize:15]} forState:UIControlStateNormal];
    
    [[UISegmentedControl appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor],NSFontAttributeName : [UIFont fontWithName:@"Helvetica-Bold" size:15.0], NSUnderlineStyleAttributeName : [NSNumber numberWithInteger:NSUnderlineStyleSingle]} forState:UIControlStateSelected];
    [mainSegment setBackgroundImage:[UIImage imageNamed:@"pimgpsh_fullsize_distr3.png"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [mainSegment setBackgroundImage:[UIImage imageNamed:@"pimgpsh_fullsize_distr1.png"] forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
    //[mainSegment setDividerImage:[UIImage imageNamed:@"pimgpsh_fullsize_distr.png"]
    //             forLeftSegmentState:UIControlStateNormal
    //               rightSegmentState:UIControlStateNormal
    //                      barMetrics:UIBarMetricsDefault];
    
    [self.view addSubview:mainSegment];
    [self mainSegmentControl:mainSegment];
}
-(void)mainSegmentControl:(UISegmentedControl *)segment
{
    NSLog(@"%ld",(long)(segment.selectedSegmentIndex));
    [self FadINAnimaation];
  

    if(segment.selectedSegmentIndex == 0){
         [self gettingData_People_01];
         [self gettingData_People_02];
        NSMutableArray *arr = [[NSUserDefaults standardUserDefaults] valueForKey:@"FilterArray"];
        NSLog(@"%@",arr);
        
        self.navigationItem.rightBarButtonItem = ({
            
            UIBarButtonItem *button;
            
            button = [[UIBarButtonItem alloc] initWithTitle:@"My Ticket" style:UIBarButtonItemStylePlain target:self action:@selector(BarCodeAlertView)];
            [button setTitleTextAttributes:
             [NSDictionary dictionaryWithObjectsAndKeys:
              [UIColor whiteColor], NSForegroundColorAttributeName,nil]
                                  forState:UIControlStateNormal];
            
            
            button;
        });

       
          }
    if(segment.selectedSegmentIndex == 2){
        [self gettingData_Company_01];
        self.navigationItem.rightBarButtonItem = ({
            
            UIBarButtonItem *button;
            
            button = [[UIBarButtonItem alloc] initWithTitle:@"Filter" style:UIBarButtonItemStylePlain target:self action:@selector(GoToFilter)];
            [button setTitleTextAttributes:
             [NSDictionary dictionaryWithObjectsAndKeys:
              [UIColor whiteColor], NSForegroundColorAttributeName,nil]
                                  forState:UIControlStateNormal];
            
            
            button;
        });

    }

    else{
        
    }
   // [self handleFlipAnimation];
}


-(void)GoToFilter{
    [self performSegueWithIdentifier:@"goToFilter" sender:self];

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PFObject *Dates = [_AllData_Final objectAtIndex:indexPath.row];
    _Profile_ObjectID = Dates.objectId ;
    
    
    [self performSegueWithIdentifier:@"goToProfile" sender:self];
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(NSString*)recipeString
{
    if([segue.identifier isEqualToString:@"goToProfile"]){
        ProfileVC *speakerDetailsViewController = (ProfileVC *)segue.destinationViewController;
        speakerDetailsViewController.self.ObjectID = self.Profile_ObjectID
        ;
        //do something
    }
}
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    CGFloat tableHeight = 0.0;
//    
//    tableHeight = tableView1.frame.size.height / 8;
//    return tableHeight;
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
