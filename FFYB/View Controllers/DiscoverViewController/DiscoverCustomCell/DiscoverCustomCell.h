//
//  DiscoverCustomCell.h
//  FFYB
//
//  Created by Geniusu on 24/05/16.
//  Copyright © 2016 Geniusu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DiscoverCustomCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *userDesignation;
@property (weak, nonatomic) IBOutlet UIButton *favouriteButton;

@end
