//
//  VideoViewController.m
//  ilab
//
//  Created by Suraj Naik on 09/12/15.
//  Copyright © 2015 Suraj Naik. All rights reserved.
//

#import "VideoViewController.h"
#import <Parse/Parse.h>
#import "CustomVideoController.h"
#import "SCLAlertView.h"
#import "UIColor+FlatUI.h"






@interface VideoViewController ()

@end

@implementation VideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
       //SWRevealViewController *revealController = [self revealViewController];
   // UITapGestureRecognizer *tap = [revealController tapGestureRecognizer];
   // tap.delegate = self;
    
   // [self.view addGestureRecognizer:tap];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
   // [self gettingData];
    
     self.tabBarController.tabBar.hidden = YES;
    [self gettingData];

}

-(void)gettingData{
    
    // NSLog(@"%@", @"LOG");
    SCLAlertView *alert = [[SCLAlertView alloc] init];
    
    alert.showAnimationType = SlideInToCenter;
    alert.hideAnimationType = SlideOutFromCenter;
    alert.customViewColor = [UIColor greenSeaColor];
    alert.backgroundType = Blur;
    
    [alert showWaiting:self title:@"Please Wait"
              subTitle:@"Loading Vidoes"
      closeButtonTitle:nil duration:4.0f];
    
    
    PFQuery *query = [PFQuery queryWithClassName:@"Videos"];
    //  [query orderByAscending:@"Day"];
    // [query whereKey:@"Day" containsString:Day];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            
            
            //  for (PFObject *object in objects) {
            self.AllData = objects ;
            //  NSLog(@"%@",self.AllData);
            
            //}
            
            [self.tableView reloadData];
                  }
        
        
    }];
    
    
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
    return self.AllData.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *simpleTableIdentifier = @"youtubeVideo";
    
    CustomVideoController *cell = (CustomVideoController *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"youtubeVideo" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    
    
    
    PFObject *Dates = [self.AllData objectAtIndex:indexPath.row];
   [ cell.playerView loadWithVideoId:[Dates valueForKey:@"YoutubeID"]];
    
    tableView.rowHeight = tableView.frame.size.height/2-30;
    
     //[self.playerView loadWithVideoId:self.VideoStringID];
   // cell.EventName.lineBreakMode = NSLineBreakByWordWrapping;
   // cell.EventName.numberOfLines = 0;
    
  //  cell.EventName.text = [Dates valueForKey:@"Tittle"];
    
    
    
    
    
    //cell.thumbnailImageView.image = [Dates valueForKey:@"Image"];
    
   // PFFile *image = [Dates objectForKey:@"VideoImage"];
    
    //[image getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
       // if (!error) {
   //         cell.thumbnailImageView.image= [UIImage imageWithData:data];
     //       cell.thumbnailImageView.contentMode = UIViewContentModeScaleToFill;
       //     cell.thumbnailImageView.clipsToBounds = YES;
   
    
            
      //  }
    //}];
    
    
    //cell.EventTime.hidden = YES;
    //cell.EventDate.hidden = YES;
    
    
    
    return cell;
    
    
}


-(void)tableView :(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   // UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
   // PFObject *Dates = [self.AllData objectAtIndex:indexPath.row];
  //  self.VideoStringID = [Dates valueForKey:@"YoutubeID"];
    
   // self.speakername =  [Dates valueForKey:@"Name"];
    //[self popup_warning:Tittle];
    
    // [[NSUserDefaults standardUserDefaults] setObject:Tittle  forKey:@"Day"];
    // [[NSUserDefaults standardUserDefaults]synchronize];
    
        
   // [self performSegueWithIdentifier:@"go" sender:self];
    
    
    
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
