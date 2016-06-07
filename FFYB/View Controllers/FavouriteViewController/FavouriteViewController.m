//
//  FavouriteViewController.m
//  FFYB
//
//  Created by Suraj Naik on 23/05/16.
//  Copyright © 2016 Geniusu. All rights reserved.
//

#import "FavouriteViewController.h"
#import "DiscoverViewController.h"
#import "UIColor+FlatUI.h"
#import "AFHTTPSessionManager.h"
#import "OAuth2Client.h"

@interface FavouriteViewController ()



@end

@implementation FavouriteViewController



- (void)viewDidLoad {
    
    [super viewDidLoad];
    
   
    
    self.title = @"Favourites";
    [self setUpSegemtnController];
    
   // [self setUpViewData_Attendies];
    
    
    
    // Keeps tab bar below navigation bar on iOS 7.0+
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        self.edgesForExtendedLayout = UIRectEdgeTop;
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    
  
    
}

-(void)setUpViewData_Attendies
{
    _discoverDataArray_ = [[NSMutableArray alloc]init];
    
    NSArray *tempNameArray = [[NSArray alloc]initWithObjects:@"Suraj Naik Favourite",@"Karl Favourite",@"Ali Faourite",@"Krishna Favourite", nil];
    NSArray *tempImageArray = [[NSArray alloc]initWithObjects:@"Suraj Naik",@"Karl",@"Ali",@"Krishna", nil];
    NSArray *tempDesignationArray = [[NSArray alloc]initWithObjects:@"CEO",@"Operations Manager",@"App developer",@"App Developer", nil];
    
    for (int i = 0; i <tempNameArray.count ; i++) {
        NSMutableDictionary *tempDict = [[NSMutableDictionary alloc]init];
        [tempDict setObject:[tempNameArray objectAtIndex:i] forKey:@"Name"];
        [tempDict setObject:[tempImageArray objectAtIndex:i] forKey:@"Image"];
        [tempDict setObject:[tempDesignationArray objectAtIndex:i] forKey:@"Designation"];
        [_discoverDataArray_ addObject:tempDict];
    }
    
    
}
-(void)setUpViewData_Business
{
    _discoverDataArray__ = [[NSMutableArray alloc]init];
    
    NSArray *tempNameArray = [[NSArray alloc]initWithObjects:@"Apple Inc",@"Uber",@"FlipCart",@"Amazon Inc", nil];
    NSArray *tempImageArray = [[NSArray alloc]initWithObjects:@"Suraj Naik",@"Karl",@"Ali",@"Krishna", nil];
    NSArray *tempDesignationArray = [[NSArray alloc]initWithObjects:@"Suraj Naik",@"Karl",@"Ali",@"Krishna", nil];
    
    for (int i = 0; i <tempNameArray.count ; i++) {
        NSMutableDictionary *tempDict = [[NSMutableDictionary alloc]init];
        [tempDict setObject:[tempNameArray objectAtIndex:i] forKey:@"Name"];
        [tempDict setObject:[tempImageArray objectAtIndex:i] forKey:@"Image"];
        [tempDict setObject:[tempDesignationArray objectAtIndex:i] forKey:@"Designation"];
        [_discoverDataArray__ addObject:tempDict];
    }
    
    
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
   
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setUpSegemtnController
{
    if (mainSegment ) {
        [mainSegment removeFromSuperview];
        mainSegment = nil;
    }
    mainSegment = [[UISegmentedControl alloc] initWithItems:[[NSArray alloc]initWithObjects:@"People",@"Companies", nil]];
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

#pragma mark - Setters
-(void)mainSegmentControl:(UISegmentedControl *)segment
{
    NSLog(@"%ld",(long)(segment.selectedSegmentIndex));
   
    
    
    if(segment.selectedSegmentIndex == 0){
       // [self gettingData_People_01];
       // [self gettingData_People_02];
        NSMutableArray *arr = [[NSUserDefaults standardUserDefaults] valueForKey:@"FilterArray"];
        NSLog(@"%@",arr);
        
        
        
    }
    if(segment.selectedSegmentIndex == 2){
      //  [self gettingData_Company_01];
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







- (UIView *)createDemoView
{
    UIView *demoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 290, 290)];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 270, 270)];
    [imageView setImage:[UIImage imageNamed:@"QR_Code.png"]];
    [demoView addSubview:imageView];
    
    return demoView;
}


#pragma mark - ViewPagerDelegate

@end
