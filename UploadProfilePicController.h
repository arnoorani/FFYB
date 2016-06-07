//
//  UploadProfilePicController.h
//  FFYB
//
//  Created by Suraj Naik on 01/06/16.
//  Copyright © 2016 Geniusu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FlatUIKit.h>
#import "Keys.h"
@interface UploadProfilePicController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *ProfilePic;
@property (weak, nonatomic) IBOutlet FUIButton *SkipThisStep;
@property (weak, nonatomic) IBOutlet UILabel *Lable;

@end
