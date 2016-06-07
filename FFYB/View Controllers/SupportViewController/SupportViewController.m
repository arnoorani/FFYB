//
//  SupportViewController.m
//  FFYB
//
//  Created by Geniusu on 31/05/16.
//  Copyright © 2016 Geniusu. All rights reserved.
//

#import "SupportViewController.h"
#import <Parse/Parse.h>
#import "SCLAlertView.h"
@interface SupportViewController ()

@end

@implementation SupportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _commentTextView.layer.borderWidth = 1.5f;
    _commentTextView.layer.borderColor = [[UIColor greenSeaColor] CGColor];
    _commentTextView.layer.cornerRadius = 3.0f;
    _commentTextView.layer.masksToBounds = YES;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSString *FullName = [[NSUserDefaults standardUserDefaults]
                          stringForKey:@"FullName"];
    self.topTitleLabel.text = [NSString stringWithFormat:@"Hello %@, Please Enter your comment below, and help us to improve.",FullName];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)handleSubmit:(id)sender
{
    [self SaveData:_commentTextView.text];
}
-(void)SaveData:(NSString*)Complain_Text{
    
    NSString *FullName = [[NSUserDefaults standardUserDefaults]
                          stringForKey:@"FullName"];
    NSString *email = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]stringForKey:@"email"]];;
    
    PFObject *gameScore = [PFObject objectWithClassName:@"Support"];
    gameScore[@"Name"] = FullName;
    gameScore[@"Complain"] = Complain_Text;
    gameScore[@"Email"] = email;
   
    [gameScore saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            // The object has been saved.
            NSString *Message = @"We will get back to you as soon as possible";
            [self Alerview_PopupView:Message];
        } else {
            // There was a problem, check error.description
            [self Alerview_PopupView:error.description];
        }
    }];
}

-(void)Alerview_PopupView:(NSString*)Message{
    SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
//    [alert addButton:@"Thanks!" actionBlock:^(void) {
//        [self .navigationController popViewControllerAnimated:YES];
//    }];
    [alert showSuccess:@"Thank you for your submission"subTitle:Message closeButtonTitle:@"Thanks!" duration:0.0f];
    
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
