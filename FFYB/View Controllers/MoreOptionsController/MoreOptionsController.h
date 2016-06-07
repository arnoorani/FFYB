//
//  MoreOptionsController.h
//  FFYB
//
//  Created by Suraj Naik on 19/05/16.
//  Copyright © 2016 Geniusu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SupportViewController.h"
#import "AboutUsViewController.h"
#import "AddressViewController.h"
#import "ProfileVC.h"
@interface MoreOptionsController : UITableViewController


@property NSDictionary *_Option_Dict;
@property NSArray *Options;
@property NSArray* IconImages;
@property NSArray* Options_forlistview;

@end
