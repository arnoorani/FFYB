//
//  AppDelegate.h
//  FFYB
//
//  Created by Suraj Naik on 18/05/16.
//  Copyright © 2016 Geniusu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Keys.h"
#import "CustomIOSAlertView.h"
@class DiscoverViewController;
@interface AppDelegate : UIResponder <UIApplicationDelegate,CustomIOSAlertViewDelegate>
@property CGFloat PreviousScreen;
@property (strong, nonatomic) UIWindow *window;
@property (weak, nonatomic) DiscoverViewController *myViewController;


@end

