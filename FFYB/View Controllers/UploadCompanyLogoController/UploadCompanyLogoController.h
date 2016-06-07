//
//  UploadCompanyLogoController.h
//  FFYB
//
//  Created by Suraj Naik on 20/05/16.
//  Copyright © 2016 Geniusu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FlatUIKit.h>
#import "Keys.h"

@interface UploadCompanyLogoController : UIViewController
@property (weak, nonatomic) IBOutlet FUIButton *DoneButton;

@property (weak, nonatomic) IBOutlet UIImageView *UploadLogo_ImageView;
@property NSString* ObjectID_new;


@end
