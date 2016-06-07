//
//  HostViewController.h
//  ICViewPager
//
//  Created by Ilter Cengiz on 28/08/2013.
//  Copyright (c) 2013 Ilter Cengiz. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "ViewPagerController.h"
#import "CustomIOSAlertView.h"

@interface HostViewController : ViewPagerController<CustomIOSAlertViewDelegate>
@property CGFloat PreviousScreen;
@property (nonatomic, strong) UIVisualEffectView *EffectView;
@property NSMutableArray *discoverDataArray_;
@property (nonatomic,strong) NSMutableArray *AllData;
@property UILabel* lable;


@end
