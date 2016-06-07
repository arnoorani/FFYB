//
//  RegisterBusinessController.m
//  FFYB
//
//  Created by Suraj Naik on 19/05/16.
//  Copyright © 2016 Geniusu. All rights reserved.
//

#import "RegisterBusinessController.h"
#import <Parse/Parse.h>
#import "SCLAlertView.h"
#import "ChooseCatagoryController.h"

@interface RegisterBusinessController ()
#define kOFFSET_FOR_KEYBOARD 35.0



@end

@implementation RegisterBusinessController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  self.tabBarController.tabBar.hidden = YES;
    
    self.EnterBusinessName_TextField.delegate = self;
    _EnterBusinessAbout_TextField.delegate = self;
    
    [_About_Business_TextFiled setFont:[UIFont fontWithName:@"OpenSans-Semibold" size:16]];
    
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    
    
    _NextButton.buttonColor = [UIColor turquoiseColor];
    _NextButton.shadowColor = [UIColor greenSeaColor];
    _NextButton.shadowHeight = 3.0f;
    _NextButton.cornerRadius = 6.0f;
    _NextButton.titleLabel.font = [UIFont boldFlatFontOfSize:16];
    [_NextButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
    [_NextButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateHighlighted];
   [_NextButton addTarget:self action:@selector(GetTextData) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    _EnterBusinessName_TextField.font = [UIFont fontWithName:@"OpenSans-Semibold" size:16];
    //_EnterBusinessName_TextField.backgroundColor = [UIColor clearColor];
    _EnterBusinessName_TextField.edgeInsets = UIEdgeInsetsMake(4.0f, 15.0f, 4.0f, 15.0f);
    _EnterBusinessName_TextField.textFieldColor = [UIColor whiteColor];
    _EnterBusinessName_TextField.borderColor = [UIColor turquoiseColor];
    _EnterBusinessName_TextField.borderWidth = 2.0f;
    _EnterBusinessName_TextField.cornerRadius = 3.0f;
    _EnterBusinessName_TextField.layer.masksToBounds = YES;
    
    
       
    _EnterBusinessAbout_TextField.font = [UIFont flatFontOfSize:15];
    //_EnterBusinessAbout_TextField.backgroundColor = [UIColor clearColor];
   _EnterBusinessAbout_TextField.layer.borderWidth = 1.5f;
    _EnterBusinessAbout_TextField.layer.borderColor = [[UIColor greenSeaColor] CGColor];
   _EnterBusinessAbout_TextField.layer.cornerRadius = 3.0f;
    _EnterBusinessAbout_TextField.layer.masksToBounds = YES;

}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // register for keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}
-(void)dismissKeyboard {
   [self.view endEditing:YES];
}

-(void)GetTextData{
    
    NSString *String =[NSString stringWithFormat:@"%@", [_EnterBusinessAbout_TextField text]];
    if(_EnterBusinessName_TextField.text.length ==0 || String.length == 0){
     [self ShowError:@"Please fill in all the information"];
    
    NSLog(@"%@",[NSString stringWithFormat:@"%@", [_EnterBusinessAbout_TextField text]]);
    }else{
        [self EnterParseData];
    }
}
#pragma Create A new Business on Server
-(void)EnterParseData{
    
    
    NSString *UserdUniqueID = [[NSUserDefaults standardUserDefaults]
                            stringForKey:@"UserID"];
    
    PFObject *Business = [PFObject objectWithClassName:Business_Name_APICall];
    Business[BusinessName] = _EnterBusinessName_TextField.text;
   Business[BusinessAbout] = [NSString stringWithFormat:@"%@", [_EnterBusinessAbout_TextField text]];
    Business[BusinessCatagory] =@"Enter Catagory";
  
    
    
    
    [Business saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
             _ObjectID_RegisterBusiness = Business.objectId;
           [self performSegueWithIdentifier:@"ChooseCatagory" sender:self];
           
                         
        } else {
           
            [self ShowError:error.description];
            // There was a problem, check error.description
        }
    }];
}

-(void)ShowError:(NSString*)Message{
    SCLAlertView *alert = [[SCLAlertView alloc] init];
    
    [alert showError:self title:@"Hold On..."
            subTitle:Message
    closeButtonTitle:@"OK" duration:0.0f];
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
   
    if([segue.identifier isEqualToString:@"ChooseCatagory"]){
         ChooseCatagoryController * chooseCatagoryController = ( ChooseCatagoryController *)segue.destinationViewController;
        chooseCatagoryController.self.ObjectID_ChooseCatagory = _ObjectID_RegisterBusiness;
        NSLog(@"ObjectID %@",_ObjectID_RegisterBusiness);
        //do something
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)keyboardWillShow {
    // Animate the current view out of the way
    if (self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES];
    }
    else if (self.view.frame.origin.y < 0)
    {
        [self setViewMovedUp:NO];
    }
}
-(void)keyboardWillHide {
    if (self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES];
    }
    else if (self.view.frame.origin.y < 0)
    {
        [self setViewMovedUp:NO];
    }
}
-(void)textFieldDidBeginEditing:(UITextField *)sender
{
    if ([sender isEqual:_About_Business_TextFiled])
    {
        //move the main view, so that the keyboard does not hide it.
        if  (self.view.frame.origin.y == 0)
        {
            [self setViewMovedUp:YES];
        }
    }
}
-(void)setViewMovedUp:(BOOL)movedUp
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3]; // if you want to slide up the view
    
    CGRect rect = self.view.frame;
    if (movedUp)
    {
        // 1. move the view's origin up so that the text field that will be hidden come above the keyboard
        // 2. increase the size of the view so that the area behind the keyboard is covered up.
        rect.origin.y -= kOFFSET_FOR_KEYBOARD;
        rect.size.height += kOFFSET_FOR_KEYBOARD;
    }
    else
    {
        // revert back to the normal state.
        rect.origin.y += kOFFSET_FOR_KEYBOARD;
        rect.size.height -= kOFFSET_FOR_KEYBOARD;
    }
    self.view.frame = rect;
    
    [UIView commitAnimations];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
