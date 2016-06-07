//
//  ControllerViewController.m
//  FFYB
//
//  Created by Suraj Naik on 31/05/16.
//  Copyright © 2016 Geniusu. All rights reserved.
//

#import "ControllerViewController.h"
#import "DKScrollingTabController.h"

@interface ControllerViewController () <DKScrollingTabControllerDelegate>

@end

@implementation ControllerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    DKScrollingTabController *tabController = [[DKScrollingTabController alloc] init];
    [self addChildViewController:tabController];
    [tabController didMoveToParentViewController:self];
    [self.view addSubview:tabController.view];
    
    // Customize the tab controller (more options in DKScrollingTabController.h or check the demo)
    tabController.view.frame = CGRectMake(0, 20, 320, 40);
    tabController.buttonPadding = 23;
    tabController.selection = @[@"zero", @"one", @"two", @"three", @"four",];
    
    // Set the delegate (conforms to DKScrollingTabControllerDelegate)
    tabController.delegate = self;
    
    // ...
}

#pragma mark - DKScrollingTabControllerDelegate
    
- (void)ScrollingTabController:(DKScrollingTabController *)controller selection:(NSUInteger)selection {
    NSLog(@"Selection controller action button with index=%@", @(selection));
    
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
