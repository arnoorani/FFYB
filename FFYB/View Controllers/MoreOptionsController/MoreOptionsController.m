//
//  MoreOptionsController.m
//  FFYB
//
//  Created by Suraj Naik on 19/05/16.
//  Copyright © 2016 Geniusu. All rights reserved.
//

#import "MoreOptionsController.h"
#import "UITableViewCell+FlatUI.h"
#import "UIColor+FlatUI.h"
#import <Parse/Parse.h>
#import "AFHTTPSessionManager.h"
#import "OAuth2Client.h"

static NSString * const FUITableViewControllerCellReuseIdentifier = @"FUITableViewControllerCellReuseIdentifier";

@interface MoreOptionsController ()

@end

@implementation MoreOptionsController

- (void)viewDidLoad {
    [super viewDidLoad];
    
      self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    
    __Option_Dict = @{@"My Profile" : @[@"My Profile", @"Register My Business",@"Logout"],
                     
                @"Other Information" : @[@"About Us", @"Support",@"Address",@"Wealth Dynamic Cards App"],
                   @"Videos" : @[@"FFYB Videos 2016"    ]
                
             };
      _Options = [[__Option_Dict allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    
    _IconImages = [NSArray arrayWithObjects:@"Profile.png",@"Register.png",@"log-out.png",@"About-FFYB.png",@"support.png",@"venue-map.png",@"videos.png",@"wd.png",nil];

    
    //Set the separator color
    self.title = @"More Options";
    
    
   
    self.tableView.backgroundView = nil;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:FUITableViewControllerCellReuseIdentifier];
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated ];
     self.tabBarController.tabBar.hidden = NO;
   
     }
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
     return [_Options count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [_Options objectAtIndex:section];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString *sectionTitle = [_Options objectAtIndex:section];
    NSArray *sectionAnimals = [__Option_Dict objectForKey:sectionTitle];
    return [sectionAnimals count];}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
   tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    UIRectCorner corners = 0;
   
        if ([tableView numberOfRowsInSection:indexPath.section] == 1) {
           // corners = UIRectCornerAllCorners;
        } else if (indexPath.row == 0) {
           // corners = UIRectCornerTopLeft | UIRectCornerTopRight;
        } else if (indexPath.row == [tableView numberOfRowsInSection:indexPath.section] - 1) {
           // corners = UIRectCornerBottomLeft | UIRectCornerBottomRight;
        }
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:FUITableViewControllerCellReuseIdentifier];
    [cell configureFlatCellWithColor:[UIColor whiteColor]
                       selectedColor:[UIColor cloudsColor]
                                                   roundingCorners:corners];
    
   
   
     cell.textLabel.textColor = [UIColor greenSeaColor];
    NSString *sectionTitle = [_Options objectAtIndex:indexPath.section];
   _Options_forlistview = [__Option_Dict objectForKey:sectionTitle];
    NSString *Option = [_Options_forlistview objectAtIndex:indexPath.row];
    cell.textLabel.text = Option;
    cell.imageView.image = [UIImage imageNamed:[_IconImages objectAtIndex:indexPath.row]];
    tableView.rowHeight = tableView.frame.size.height/10-10;
    
    if([cell.textLabel.text isEqualToString:@"About Us" ]){
        cell.imageView.image = [UIImage imageNamed:[_IconImages objectAtIndex:3]];
    }
    if([cell.textLabel.text isEqualToString:@"Support" ]){
        cell.imageView.image = [UIImage imageNamed:[_IconImages objectAtIndex:4]];
    }
    if([cell.textLabel.text isEqualToString:@"Address" ]){
        cell.imageView.image = [UIImage imageNamed:[_IconImages objectAtIndex:5]];
    }
    if([cell.textLabel.text isEqualToString:@"Wealth Dynamic Cards App" ]){
        cell.imageView.image = [UIImage imageNamed:[_IconImages objectAtIndex:7]];
    }
    if([cell.textLabel.text isEqualToString:@"FFYB Videos 2016" ]){
        cell.imageView.image = [UIImage imageNamed:[_IconImages objectAtIndex:6]];
    }
    
    
 cell.imageView.frame = CGRectMake(0,0,55,55);
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *sectionTitle = [_Options objectAtIndex:indexPath.section];
    _Options_forlistview = [__Option_Dict objectForKey:sectionTitle];
    NSString *Option = [_Options_forlistview objectAtIndex:indexPath.row];
    NSLog(@"%@",Option);
    
    if([Option isEqualToString:@"My Profile"]){
        ProfileVC *profilevc = [self.storyboard instantiateViewControllerWithIdentifier:@"ProfileVC"];
        profilevc.hidesBottomBarWhenPushed = YES ;
        [self.navigationController pushViewController:profilevc animated:YES];
    }
    else if([Option isEqualToString:@"Support"]){
        
        SupportViewController *support = [self.storyboard instantiateViewControllerWithIdentifier:@"SupportViewController"];
        support.hidesBottomBarWhenPushed = YES ;
        [self.navigationController pushViewController:support animated:YES];
    }
    else if([Option isEqualToString:@"About Us"]){
        
        AboutUsViewController *about = [self.storyboard instantiateViewControllerWithIdentifier:@"AboutUsViewController"];
        about.hidesBottomBarWhenPushed = YES ;
        [self.navigationController pushViewController:about animated:YES];
    }
    else if([Option isEqualToString:@"Address"]){
        
        AddressViewController *address = [self.storyboard instantiateViewControllerWithIdentifier:@"AddressViewController"];
        address.hidesBottomBarWhenPushed = YES ;
        [self.navigationController pushViewController:address animated:YES];
    }
   
    else if([Option isEqualToString:@"Logout"])
    {
        [[OAuth2Client sharedInstance] signOut];
         [self performSegueWithIdentifier:@"goToLogin" sender:self];
    }
    else
    {
        [self performSegueWithIdentifier:Option sender:self];
    }
    
    if([Option isEqualToString:@"Wealth Dynamic Cards App"]){
        [self OpenApp_Function];
    }else{
       // [self performSegueWithIdentifier:Option sender:self];
    }
    
   // NSLog(@"Selected Row %@",[_Options_forlistview objectAtIndex:indexPath.row]);
    
}
-(void)OpenApp_Function{
    
    
    NSString *WDP_Profile = [[NSUserDefaults standardUserDefaults]
                             stringForKey:@"WDP_Profile"];
    
    NSString *Email = [[NSUserDefaults standardUserDefaults]
                       stringForKey:@"Email"];
    
    
    
    
    NSString *lower = [WDP_Profile lowercaseString];
    
    NSString *varyingString1 = @"wealthdynamics://?";
    NSString *varyingString2 = [lower stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    
    NSString *str = [NSString stringWithFormat: @"%@%@,%@,%@", varyingString1,@"GOT", varyingString2,Email];
    //str is now "hello world"
    
    
    
    if ([[UIApplication sharedApplication]
         canOpenURL:[NSURL URLWithString:varyingString1]])
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    }
    else
    {
        SCLAlertView *alert = [[SCLAlertView alloc] init];
        
        alert.backgroundType = Blur;
        alert.showAnimationType = FadeIn;
        
        [alert addButton:@"Download the App" actionBlock:^(void) {
            
            
            [[UIApplication sharedApplication] openURL: [NSURL URLWithString:@"https://itunes.apple.com/us/app/wealth-dynamics/id1107866151?ls=1&mt=8"]];
            
            
        }];
        
        
        [alert showNotice:self title:@"Hello" subTitle:@"The Wealthy Dynamics cards app is not installed on your iphone would you like to install it.?" closeButtonTitle:@"Dismiss" duration:0.0f];
    }
    
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
