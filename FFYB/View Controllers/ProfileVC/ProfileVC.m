//
//  ProfileVC.m
//  FFYB
//
//  Created by Geniusu on 25/05/16.
//  Copyright © 2016 Geniusu. All rights reserved.
//

#import "ProfileVC.h"
#import "UIImage+MDQRCode.h"
#import "UIColor+FlatUI.h"

@interface ProfileVC ()

@end

@implementation ProfileVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self gettingData_People_01];
//    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
//    [tracker set:kGAIScreenName value:@"Profile"];
//    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
//    
//    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
//    [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"View Logged In User Profile" action:@"User Name" label:@"User details"  value:@1] build]];
    
    // Do any additional setup after loading the view.
    
}

-(void)gettingData_People_01{
    
    
    SCLAlertView *alert = [[SCLAlertView alloc] init];
    alert.customViewColor = [UIColor greenSeaColor];
    alert.showAnimationType = SlideInToCenter;
    alert.hideAnimationType = SlideOutFromCenter;
    
    alert.backgroundType = Blur;
    
    [alert showWaiting:self title:@"Please Wait"
              subTitle:@"Loading People"
      closeButtonTitle:nil duration:1.2f];
    
    
    PFQuery *query = [PFQuery queryWithClassName:@"UserDetails"];
    //  [query orderByAscending:@"Day"];
     [query whereKey:@"objectId" containsString:_ObjectID];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            
            
           
          
            
            AllData = objects;
            NSLog(@"%@",AllData);
            
            if(AllData.count == 0){
                [self gettingData_People_02];
                NSLog(@"%@",@"Getting People from UseeDetails2");
  
            }else{
                 [profileTable reloadData];
                
            }
            
     
            
        }else{
          [self PopUp_Alertview:error.description];
        }
        
        
        
    }];
    
}

-(void)gettingData_People_02{
    
    
    
    
    PFQuery *query = [PFQuery queryWithClassName:@"UserDetails2"];
    //  [query orderByAscending:@"Day"];
    [query whereKey:@"objectId" containsString:_ObjectID];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            
            
            
            
            
            AllData = objects;
            if(AllData.count == 0){
                
            }else{
            [profileTable reloadData];
            }
            
           
        }else{
            [self PopUp_Alertview:error.description];
        }
        
        
        
    }];
    
}
-(void)PopUp_Alertview:(NSString*)Message{
    SCLAlertView *alert = [[SCLAlertView alloc] init];
    
    alert.backgroundType = Blur;
    alert.showAnimationType = FadeIn;
    [alert showNotice:self title:@"Hello" subTitle:Message closeButtonTitle:@"Dimiss" duration:0.0f];
}

#pragma mark == TableView Data Source And Delegates
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = YES;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"ProfileHeaderCell";
    
    ProfileHeaderCell *tableCell1 = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    [self createRoundImageView: tableCell1.profileImage];
    
    [self createRoundImageView: tableCell1.profileImageBGView];
    
    [self setCornerToView: tableCell1.infoBackgroundView];
   
    tableCell1.barCodeImage.image = [UIImage mdQRCodeForString:@"Hello, world!" size:tableCell1.barCodeImage.bounds.size.width fillColor:[UIColor darkGrayColor]];
    [tableCell1.editButton addTarget:self action:@selector(performEditProfile) forControlEvents:UIControlEventTouchUpInside];
    
    
     PFObject *Dates = [AllData objectAtIndex:indexPath.row];
    
    
    tableCell1.userName.text = [Dates valueForKey:FullName_Constant];
    tableCell1.aboutUser.text = @"";
    tableCell1.profileType.text = [Dates valueForKey:GeniusU_Profile_Constant];
    
    if([[Dates valueForKey:@"ImageURL"] isEqualToString:@"null"]){
        PFFile *image = [Dates objectForKey:@"ProfileImage"];
        
        if(image){
            [image getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
                if (!error) {
                    
                    tableCell1.profileImage.image = [UIImage imageWithData:data];
                }
                
            }];
        }else{
            tableCell1.imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[Dates valueForKey:@"ImageURL"]]]];

        }
        

    
    
    }

    
    
    return tableCell1;
}

-(void)setCornerToView:(UIView *)imageView{
    imageView.layer.cornerRadius = 15;
    imageView.layer.masksToBounds = YES;
    imageView.layer.borderWidth = 0;
}

-(void)createRoundImageView:(UIView *)imageView{
    imageView.layer.cornerRadius = imageView.frame.size.height /2;
    imageView.layer.masksToBounds = YES;
    imageView.layer.borderWidth = 0;
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

-(void)performEditProfile
{
    SCLAlertView *alert = [[SCLAlertView alloc] init];
    alert.customViewColor = [UIColor greenSeaColor];
    alert.shouldDismissOnTapOutside = YES;
    UITextField *profession = [alert addTextField:@"profession"];
    [alert addButton:@"Save" actionBlock:^(void) {
     NSLog(@"profession value: %@", profession.text);
       
    }];
    
    [alert showEdit:self title:@"Edit Profile" subTitle:@"" closeButtonTitle:@"Close" duration:0.0f];
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
