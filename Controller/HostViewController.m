//
//  HostViewController.m
//  ICViewPager
//
//  Created by Ilter Cengiz on 28/08/2013.
//  Copyright (c) 2013 Ilter Cengiz. All rights reserved.
//

#import "HostViewController.h"
#import <Parse/Parse.h>
#import "DiscoverViewController.h"
#import "UIColor+FlatUI.h"
#import "AFHTTPSessionManager.h"
#import "OAuth2Client.h"
#import "TESTTABLEVIEW_Conttoller.h"

@interface HostViewController () <ViewPagerDataSource, ViewPagerDelegate>

@property (nonatomic) NSUInteger numberOfTabs;

@end

@implementation HostViewController



- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    
    [self setUpViewData];
    self.dataSource = self;
    self.delegate = self;
    
    self.title = @"Discover";
    
   
   
    BOOL signedIn = [[OAuth2Client sharedInstance] signedIn];
    
    if (signedIn) {
        //[[OAuth2Client sharedInstance] signOut];
    } else {
         [self performSegueWithIdentifier:@"goToLogin" sender:self];
       // [[OAuth2Client sharedInstance] authenticateInViewController:self];
    }

    
    
    // Keeps tab bar below navigation bar on iOS 7.0+
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        
        
        self.edgesForExtendedLayout = UIRectEdgeBottom;
        self.edgesForExtendedLayout = UIRectEdgeTop;
        self.edgesForExtendedLayout = UIRectEdgeAll;
        self.automaticallyAdjustsScrollViewInsets = YES;
    }

    
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
- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    [self performSelector:@selector(loadContent) withObject:nil afterDelay:1.0];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Setters
- (void)setNumberOfTabs:(NSUInteger)numberOfTabs {
    
    // Set numberOfTabs
    _numberOfTabs = numberOfTabs;
    
    // Reload data
    [self reloadData];
    
}

#pragma mark - Helpers
- (void)selectTabWithNumberFive {
    [self selectTabAtIndex:3];
}
- (void)loadContent {
    self.numberOfTabs = 3;
}

#pragma mark - Interface Orientation Changes
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    
    // Update changes after screen rotates
    [self performSelector:@selector(setNeedsReloadOptions) withObject:nil afterDelay:duration];
}

#pragma mark - ViewPagerDataSource
- (NSUInteger)numberOfTabsForViewPager:(ViewPagerController *)viewPager {
    return self.numberOfTabs;
}
- (UIView *)viewPager:(ViewPagerController *)viewPager viewForTabAtIndex:(NSUInteger)index {
   
   // CGFloat width =  [label.text sizeWithFont:[UIFont systemFontOfSize:40 ]].width;
    

    _lable = [UILabel new];
    _lable.backgroundColor = [UIColor clearColor];
    _lable.text = [NSString stringWithFormat:@"Tab"];
    _lable.numberOfLines = 1;
    [_lable setFont:[UIFont fontWithName:@"OpenSans-Semibold" size:46]];
    _lable.adjustsFontSizeToFitWidth = YES;
    _lable.textAlignment = NSTextAlignmentCenter;
    _lable.textColor = [UIColor blackColor];
    [_lable sizeToFit];
    
    
    if(index == 0){
                _lable.text = [NSString stringWithFormat:@"Attendies"];
        
    }
    if(index == 1){
        _lable.text = [NSString stringWithFormat:@"City Name"];
    }
    if(index == 2){
        _lable.text = [NSString stringWithFormat:@"Companies"];
    }
    return _lable;
}
//Getting Data from Parse
#pragma GettingDataFromServer
-(void)gettingData{
    // [self.chatMatesArray removeAllObjects];
    // NSLog(@"%@", @"LOG");
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    indicator.frame = CGRectMake(0.0, 0.0, 10.0, 10.0);
    indicator.center = self.view.center;
    [self.view addSubview:indicator];
    indicator.color = [UIColor yellowColor];
    [indicator bringSubviewToFront:self.view];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = TRUE;
    [indicator startAnimating];
    
    // __weak typeof(self) weakSelf = self;
    PFQuery *query = [PFQuery queryWithClassName:@"Speakers"];
    //  [query orderByAscending:@"Day"];
    // [query whereKey:@"Day" containsString:Day];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            
            
            //  for (PFObject *object in objects) {
            self.AllData = objects ;
            //  NSLog(@"%@",self.AllData);
            
            //}
            
           // [self.tableView reloadData];
           // [animatedImageView stopAnimating];
        }
        
        
    }];
    
    
}

-(void)setUpViewData
{
    _discoverDataArray_ = [[NSMutableArray alloc]init];
    
    NSArray *tempNameArray = [[NSArray alloc]initWithObjects:@"Suraj Naik New",@"Karl New",@"Ali New",@"Krishna New",@"Krishna New",@"Krishna New",@"Krishna New",@"Krishna New",@"Krishna New",@"Krishna New",@"Krishna New",@"Krishna New",@"Krishna New",@"Krishna New",@"Krishna New",@"Krishna New",@"Krishna New",@"Krishna New",@"Krishna New",@"Krishna New",@"Krishna New",@"Krishna New",@"Krishna New",@"Krishna New",@"Krishna New",@"Krishna New",@"Krishna New", nil];
    NSArray *tempImageArray = [[NSArray alloc]initWithObjects:@"Suraj Naik New",@"Karl New",@"Ali New",@"Krishna New",@"Krishna New",@"Krishna New",@"Krishna New",@"Krishna New",@"Krishna New",@"Krishna New",@"Krishna New",@"Krishna New",@"Krishna New",@"Krishna New",@"Krishna New",@"Krishna New",@"Krishna New",@"Krishna New",@"Krishna New",@"Krishna New",@"Krishna New",@"Krishna New",@"Krishna New",@"Krishna New",@"Krishna New",@"Krishna New",@"Krishna New", nil];
    NSArray *tempDesignationArray = [[NSArray alloc]initWithObjects:@"Suraj Naik New",@"Karl New",@"Ali New",@"Krishna New",@"Krishna New",@"Krishna New",@"Krishna New",@"Krishna New",@"Krishna New",@"Krishna New",@"Krishna New",@"Krishna New",@"Krishna New",@"Krishna New",@"Krishna New",@"Krishna New",@"Krishna New",@"Krishna New",@"Krishna New",@"Krishna New",@"Krishna New",@"Krishna New",@"Krishna New",@"Krishna New",@"Krishna New",@"Krishna New",@"Krishna New", nil];
    
    for (int i = 0; i <tempNameArray.count ; i++) {
        NSMutableDictionary *tempDict = [[NSMutableDictionary alloc]init];
        [tempDict setObject:[tempNameArray objectAtIndex:i] forKey:@"Name"];
        [tempDict setObject:[tempImageArray objectAtIndex:i] forKey:@"Image"];
        [tempDict setObject:[tempDesignationArray objectAtIndex:i] forKey:@"Designation"];
        [_discoverDataArray_ addObject:tempDict];
    }
   
    
}
- (UIViewController *)viewPager:(ViewPagerController *)viewPager contentViewControllerForTabAtIndex:(NSUInteger)index {
    
    TESTTABLEVIEW_Conttoller *cvc = [self.storyboard instantiateViewControllerWithIdentifier:@"TESTTABLEVIEW_Conttoller"];
    
   // cvc.labelString = [NSString stringWithFormat:@"Content View #%i", index];
    cvc.discoverDataArray = _discoverDataArray_;
    
    return cvc;
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

- (void)customIOS7dialogButtonTouchUpInside: (CustomIOSAlertView *)alertView clickedButtonAtIndex: (NSInteger)buttonIndex
{
   [UIScreen mainScreen].brightness = _PreviousScreen;
     [self.EffectView removeFromSuperview];
    [alertView close];
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
- (CGFloat)viewPager:(ViewPagerController *)viewPager valueForOption:(ViewPagerOption)option withDefault:(CGFloat)value {
    
    switch (option) {
        case ViewPagerOptionStartFromSecondTab:
            return 1.0;
        case ViewPagerOptionCenterCurrentTab:
            return 1.0;
        case ViewPagerOptionTabLocation:
            return 0.0;
        case ViewPagerOptionTabHeight:
            return 9.0;
        case ViewPagerOptionTabOffset:
            return 36.0;
        case ViewPagerOptionTabWidth:
            return UIInterfaceOrientationIsLandscape(self.interfaceOrientation) ? 428.0 : 126.0;
        case ViewPagerOptionFixFormerTabsPositions:
            return 1.0;
        case ViewPagerOptionFixLatterTabsPositions:
            return 1.0;
        
    
        default:
            return value;
    }
}
- (void)viewPager:(ViewPagerController *)viewPager didChangeTabToIndex:(NSUInteger)index
{
    if(index == 0){

        [_lable setFont:[UIFont fontWithName:@"OpenSans-Semibold" size:52]];
      
        
    }else{
         [_lable setFont:[UIFont fontWithName:@"OpenSans-Semibold" size:48]];
    }

    NSLog(@"%lu",(unsigned long)index);

    
      }

- (UIColor *)viewPager:(ViewPagerController *)viewPager colorForComponent:(ViewPagerComponent)component withDefault:(UIColor *)color {
    
    switch (component) {
        case ViewPagerIndicator:
            return [[UIColor greenSeaColor] colorWithAlphaComponent:0.64];
        case ViewPagerTabsView:
            return [[UIColor lightGrayColor] colorWithAlphaComponent:0.32];
        case ViewPagerContent:
            return [[UIColor blueColor] colorWithAlphaComponent:0.32];
            
        default:
            return color;
    }
}

@end
