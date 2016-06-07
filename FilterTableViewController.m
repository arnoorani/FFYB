//
//  FilterTableViewController.m
//  FFYB
//
//  Created by Suraj Naik on 02/06/16.
//  Copyright © 2016 Geniusu. All rights reserved.
//

#import "FilterTableViewController.h"
#import "UITableViewCell+FlatUI.h"
#import "UIColor+FlatUI.h"
#import "DiscoverViewController.h"
static NSString * const FUITableViewControllerCellReuseIdentifier = @"FUITableViewControllerCellReuseIdentifier";
@interface FilterTableViewController ()

@end

@implementation FilterTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Pick Catagory";
_Filter = [NSMutableArray array];
    _Business_Catagories = [NSArray arrayWithObjects:@"None",@"Automotive",@"Business Support & Supplies",@"Computers & Electronics",@"Education",@"Entertainment",@"Food & Dining",@"Health & Medicine",@"Home & Garden",@"Legal & Financial",@"Manufacturing, Wholesale, Distribution",@"Merchants (Retail)",@"Personal Care & Servicesm",@"Real Estate",nil];
    
    self.tableView.backgroundView = nil;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:FUITableViewControllerCellReuseIdentifier];
    
    NSMutableArray *arr = [[NSUserDefaults standardUserDefaults] valueForKey:@"FilterArray"];
    [_Filter addObjectsFromArray:arr];

  

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    [cell configureFlatCellWithColor:[UIColor cloudsColor]
                       selectedColor:[UIColor greenSeaColor]
                     roundingCorners:corners];
    
    
    
    
    
     NSMutableArray *arr = [[NSUserDefaults standardUserDefaults] valueForKey:@"FilterArray"];
    
    tableView.rowHeight = tableView.contentSize.height/_Business_Catagories.count+1.5;
    cell.textLabel.text = [_Business_Catagories objectAtIndex:indexPath.row];
   
        if([arr containsObject:[_Business_Catagories objectAtIndex:indexPath.row]]){
           cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }else{
            cell.accessoryType = UITableViewCellAccessoryNone;
        }

    
    
    return cell;
}

-(void)viewDidDisappear:(BOOL)animated{
    [[NSUserDefaults standardUserDefaults] setValue:_Filter forKey:@"FilterArray"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    NSLog(@"%@",_Filter);
    
    
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
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    NSLog(@"Selected Row %@ ",[_Business_Catagories objectAtIndex:indexPath.row]);
    

//if([_Filter containsObject:[_Business_Catagories objectAtIndex:indexPath.row]]){
      //  [_Filter removeObjectAtIndex:indexPath.row];
   // NSLog(@"%@",@"Object Removed");
   // }else{
  //    [_Filter addObject:[_Business_Catagories objectAtIndex:indexPath.row]];
     //   NSLog(@"%@",@"Object Added");
   // }
  //
   // [[NSUserDefaults standardUserDefaults] setValue:_Filter forKey:@"FilterArray"];
   // [[NSUserDefaults standardUserDefaults] synchronize];

    //NSLog(@"Array %@", _Filter);
   // [tableView reloadData];
    
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
