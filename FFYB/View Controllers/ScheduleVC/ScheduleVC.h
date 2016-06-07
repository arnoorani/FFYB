//
//  ScheduleVC.h
//  FFYB
//
//  Created by Geniusu on 25/05/16.
//  Copyright © 2016 Geniusu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScheduleCustomCell.h"
@interface ScheduleVC : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
     UISegmentedControl *mainSegment;
    IBOutlet UITableView *scheduleTable;
    NSMutableArray *scheduleDataArray;
    NSMutableArray *AllData;
}


@end
