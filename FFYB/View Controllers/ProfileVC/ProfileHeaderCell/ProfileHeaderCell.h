//
//  ProfileHeaderCell.h
//  FFYB
//
//  Created by Geniusu on 25/05/16.
//  Copyright © 2016 Geniusu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileHeaderCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *bannerImageView;
@property (weak, nonatomic) IBOutlet UIView *infoBackgroundView;
@property (weak, nonatomic) IBOutlet UIView *profileImageBGView;
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *profileType;
@property (weak, nonatomic) IBOutlet UILabel *aboutUser;
@property (weak, nonatomic) IBOutlet UILabel *userProfession;
@property (weak, nonatomic) IBOutlet UILabel *usertagLine;
@property (weak, nonatomic) IBOutlet UIButton *editButton;


@property (weak, nonatomic) IBOutlet UIImageView *barCodeImage;

@end
