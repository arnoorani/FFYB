//
//  ScheduleCustomCell.h
//  FFYB
//
//  Created by Geniusu on 25/05/16.
//  Copyright © 2016 Geniusu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScheduleCustomCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *scheduleImage;
@property (weak, nonatomic) IBOutlet UILabel *scheduleTitle;
@property (weak, nonatomic) IBOutlet UILabel *scheduleTime;
@end
