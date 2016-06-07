//
//  RegisterBusinessController.h
//  FFYB
//
//  Created by Suraj Naik on 19/05/16.
//  Copyright © 2016 Geniusu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FlatUIKit.h>
#import "Keys.h"

@interface RegisterBusinessController : UIViewController<UITextFieldDelegate,UITextViewDelegate>
@property (weak, nonatomic) IBOutlet FUIButton  *NextButton;

@property (weak, nonatomic) IBOutlet FUITextField *EnterBusinessName_TextField;
@property (weak, nonatomic) IBOutlet UITextView *EnterBusinessAbout_TextField;
@property (nonatomic, strong) NSString *ObjectID_RegisterBusiness;

@property (weak, nonatomic) IBOutlet UILabel *About_Business_TextFiled;


@end
