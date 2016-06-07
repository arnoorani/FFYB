//
//  ChooseCatagoryController.m
//  
//
//  Created by Suraj Naik on 20/05/16.
//
//

#import "ChooseCatagoryController.h"
#import "UITableViewCell+FlatUI.h"
#import "UIColor+FlatUI.h"
#import <Parse.h>
#import "UploadCompanyLogoController.h"
#import "SCLAlertView.h"
static NSString * const FUITableViewControllerCellReuseIdentifier = @"FUITableViewControllerCellReuseIdentifier";
@interface ChooseCatagoryController ()

@end

@implementation ChooseCatagoryController

- (void)viewDidLoad {
    [super viewDidLoad];
    
     self.title = @"Pick Catagory";
    
   _Business_Catagories = [NSArray arrayWithObjects:@"Automotive",@"Business Support & Supplies",@"Computers & Electronics",@"Education",@"Entertainment",@"Food & Dining",@"Health & Medicine",@"Home & Garden",@"Legal & Financial",@"Manufacturing, Wholesale, Distribution",@"Merchants (Retail)",@"Personal Care & Servicesm",@"Real Estate",nil];
    
    self.tableView.backgroundView = nil;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:FUITableViewControllerCellReuseIdentifier];
 NSLog(@"%@",_ObjectID_ChooseCatagory);
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return _Business_Catagories.count;
}


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
    [cell configureFlatCellWithColor:[UIColor greenSeaColor]
                       selectedColor:[UIColor cloudsColor]
                     roundingCorners:corners];
    
    
    
    
    
    
  
    tableView.rowHeight = tableView.contentSize.height/_Business_Catagories.count+1.5;
    cell.textLabel.text = [_Business_Catagories objectAtIndex:indexPath.row];
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    NSLog(@"%@ Selected Row",[_Business_Catagories objectAtIndex:indexPath.row]);
    [self EnterParseData:[_Business_Catagories objectAtIndex:indexPath.row ]];
   
}





-(void)EnterParseData: (NSString*) Text  {
    //[self popup_warning:Tittle];
    
    
    PFQuery *query = [PFQuery queryWithClassName:Business_Name_APICall];
    
    // Retrieve the object by id
    [query getObjectInBackgroundWithId:_ObjectID_ChooseCatagory
                                 block:^(PFObject *gameScore, NSError *error) {
                                     // Now let's update it with some new data. In this case, only cheatMode and score
                                     // will get sent to the cloud. playerName hasn't changed.
                                     gameScore[BusinessCatagory] = Text;
                                    [gameScore saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                                         if (succeeded) {
                                            [self performSegueWithIdentifier:@"UploadLogo" sender:self];
                                             //  [self gettingData];
                                             // [self viewDidLoad];
                                             //  [self viewWillAppear:YES];
                                         } else {
                                             SCLAlertView *alert = [[SCLAlertView alloc] init];
                                             
                                             [alert showError:self title:@"Hold On..."
                                                     subTitle:@"Unable to process your request"
                                             closeButtonTitle:@"OK" duration:0.0f];                                            // There was a problem, check error.description
                                         }
                                     }];
                                 }];
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if([segue.identifier isEqualToString:@"UploadLogo"]){
        UploadCompanyLogoController * uploadCompanyLogoController = ( UploadCompanyLogoController *)segue.destinationViewController;
        uploadCompanyLogoController.ObjectID_new = _ObjectID_ChooseCatagory;
        NSLog(@"ObjectID %@",_ObjectID_ChooseCatagory);
        //do something
    }
}


/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

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
