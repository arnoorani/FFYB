//
//  FavouriteViewController.h
//  FFYB
//
//  Created by Suraj Naik on 23/05/16.
//  Copyright © 2016 Geniusu. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CustomIOSAlertView.h"

@interface FavouriteViewController : UIViewController<CustomIOSAlertViewDelegate>{
    UISegmentedControl *mainSegment;
}
@property NSMutableArray *discoverDataArray_;
@property NSMutableArray *discoverDataArray__;
@end
