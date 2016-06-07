//
//  DiscoverViewController.h
//  FFYB
//
//  Created by Suraj Naik on 20/05/16.
//  Copyright © 2016 Geniusu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DiscoverCustomCell.h"
#import "Keys.h"
#import "CustomIOSAlertView.h"
#import "AppDelegate.h"
@interface DiscoverViewController : UIViewController<CustomIOSAlertViewDelegate>
{
   UISegmentedControl *mainSegment;
    IBOutlet UITableView *discovertableView;
    NSMutableArray *FilterArray;
}
@property NSMutableArray *discoverDataArray;
@property CGFloat PreviousScreen;
@property (nonatomic, strong) UIVisualEffectView *EffectView;
@property (nonatomic,strong) NSArray *AllData_01;
@property (nonatomic,strong) NSArray *AllData_02;
@property (nonatomic,strong) NSArray *AllData_Final;
@property NSString *DataType;
@property NSString *Profile_ObjectID;

@end
