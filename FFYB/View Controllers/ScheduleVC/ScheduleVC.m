//
//  ScheduleVC.m
//  FFYB
//
//  Created by Geniusu on 25/05/16.
//  Copyright © 2016 Geniusu. All rights reserved.
//

#import "ScheduleVC.h"
#import "UIColor+FlatUI.h"
#import "Keys.h"
#import <Parse/Parse.h>
#import "CustomVideoController.h"
#import "SCLAlertView.h"
@interface ScheduleVC ()

@end

@implementation ScheduleVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpSegemtnController];
    //[self setUpViewData];
    [self gettingData];
}

-(void)setUpViewData
{
    scheduleDataArray = [[NSMutableArray alloc]init];
    
    NSArray *tempNameArray = [[NSArray alloc]initWithObjects:@"Top Trends",@"Lunch",@"Change-Makers",@"Top Trends", nil];
    NSArray *tempTimeArray = [[NSArray alloc]initWithObjects:@"9:00 am",@"1:00 pm",@"2:00 pm",@"5:00 pm", nil];
    NSArray *tempImageArray = [[NSArray alloc]initWithObjects:@"Suraj Naik",@"Karl",@"Ali",@"Krishna", nil];
    
  
        

    
    for (int i = 0; i <tempNameArray.count ; i++) {
        NSMutableDictionary *tempDict = [[NSMutableDictionary alloc]init];
          PFObject *Dates = [AllData objectAtIndex:i];
        [tempDict setObject:[tempNameArray objectAtIndex:i] forKey:@"Name"];
        [tempDict setObject:[tempTimeArray objectAtIndex:i] forKey:@"Time"];
        [tempDict setObject:[tempImageArray objectAtIndex:i] forKey:@"Image"];
        [scheduleDataArray addObject:tempDict];
    }
    [scheduleTable reloadData];
    
}
-(void)gettingData{
    
    // NSLog(@"%@", @"LOG");
    SCLAlertView *alert = [[SCLAlertView alloc] init];
     alert.customViewColor = [UIColor greenSeaColor];
    alert.showAnimationType = SlideInToCenter;
    alert.hideAnimationType = SlideOutFromCenter;
    
    alert.backgroundType = Blur;
    
    [alert showWaiting:self title:@"Please Wait"
              subTitle:@"Loading Schedule"
      closeButtonTitle:nil duration:1.7f];
    
    
    PFQuery *query = [PFQuery queryWithClassName:@"Schedule"];
    //  [query orderByAscending:@"Day"];
    // [query whereKey:@"Day" containsString:Day];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            
            
            //  for (PFObject *object in objects) {
            AllData = objects ;
                          [scheduleTable reloadData];
            
            //}
            
           
        }
        
        
    }];
    
    
}

#pragma mark == TableView Data Source And Delegates
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [AllData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"ScheduleCustomCell";
    
    ScheduleCustomCell *tableCell1 = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    
    PFObject *Dates = [AllData objectAtIndex:indexPath.row];
    

    
    tableCell1.scheduleTitle.text = [Dates valueForKey:@"Name"];
    
    tableCell1.scheduleTime.text = [Dates valueForKey:@"Time"];
    
    //tableCell1.scheduleImage.image = [UIImage imageNamed:[[scheduleDataArray objectAtIndex:indexPath.row] valueForKey:@"Image"]];
    
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}


-(void)setUpSegemtnController
{
    if (mainSegment ) {
        [mainSegment removeFromSuperview];
        mainSegment = nil;
    }
    mainSegment = [[UISegmentedControl alloc] initWithItems:[[NSArray alloc]initWithObjects:@"Day 1",@"Day 2", nil]];
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
    if(segment.selectedSegmentIndex == 0){
        
    }
    else{
        
    }
    [self handleFlipAnimation];
}

-(void)handleFlipAnimation
{
    [UIView transitionWithView:scheduleTable
                      duration:0.9
                       options:UIViewAnimationOptionTransitionFlipFromRight
                    animations: ^{
                       
                    }
                    completion:NULL];
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
