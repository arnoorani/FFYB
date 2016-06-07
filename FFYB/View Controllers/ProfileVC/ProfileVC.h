//
//  ProfileVC.h
//  FFYB
//
//  Created by Geniusu on 25/05/16.
//  Copyright © 2016 Geniusu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProfileHeaderCell.h"
#import "SCLAlertView.h"
#import "GlobalImports.pch"
//#import <Google/Analytics.h>

@interface ProfileVC : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet UITableView *profileTable;
    NSMutableArray *profileDataArray;
    NSArray *AllData;
}
@property NSString *ObjectID;

@end
