//
//  LoginViewController.h
//  FFYB
//
//  Created by Suraj Naik on 25/05/16.
//  Copyright © 2016 Geniusu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "Keys.h"


@interface LoginViewController : UIViewController<CLLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet UIButton *LoginButton;
@property (strong, nonatomic) CLLocationManager* locationManager;
@property (nonatomic, strong) NSString *accessToken;
@property NSUInteger Count;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;



@end
