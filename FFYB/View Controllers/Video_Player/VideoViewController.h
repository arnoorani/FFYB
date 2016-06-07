//
//  VideoViewController.h
//  ilab
//
//  Created by Suraj Naik on 09/12/15.
//  Copyright © 2015 Suraj Naik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YTPlayerView.h"

@interface VideoViewController : UITableViewController
@property (weak,nonatomic) IBOutlet UIBarButtonItem *barButton;
@property (nonatomic,strong) NSMutableArray *AllData;
@property (nonatomic,strong) NSString *VideoStringID;
@property(nonatomic, strong) IBOutlet YTPlayerView *playerView;
@property (nonatomic,strong) NSString *NEWVideoStringID;
@property (nonatomic, strong) UIVisualEffectView *EffectView;


@end
