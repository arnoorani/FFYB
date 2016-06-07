//
//  ViewController.m
//  FFYB
//
//  Created by Suraj Naik on 18/05/16.
//  Copyright © 2016 Geniusu. All rights reserved.
//

#import "ViewController.h"
#import "AFHTTPSessionManager.h"
#import "OAuth2Client.h"
#import "SCLAlertView.h"
#import "UIColor+FlatUI.h"
#import "UIStepper+FlatUI.h"
#import "UITabBar+FlatUI.h"
#import "UINavigationBar+FlatUI.h"
#import "UIFont+FlatUI.h"
#import "FUIAlertView.h"
#import "UIBarButtonItem+FlatUI.h"
#import "NSString+Icons.h"



@interface ViewController ()

@end

@implementation ViewController

-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController.navigationBar setHidden:NO];
    

 
    
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
     [self.navigationController.navigationBar setHidden:NO];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(signInNotificaitonReceived:) name:kOAuth2SignedInNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(signOutNotificaitonReceived:) name:kOAuth2SignedOutNotification object:nil];
    
    [UIBarButtonItem configureFlatButtonsWithColor:[UIColor peterRiverColor]
                                  highlightedColor:[UIColor belizeHoleColor]
                                      cornerRadius:3];
    
   
}

-(void)signOutNotificaitonReceived:(NSNotification *)notification {
     NSLog(@"%@",@"User Logged Out");
    
}

-(void)signInNotificaitonReceived:(NSNotification *)notification {
    NSLog(@"%@",@"User Logged In");
    
}
- (void)getCredientialsFromApi {
    [[OAuth2Client sharedInstance] accessToken:^(NSString *accessToken) {
        if (accessToken != nil) {
            // Make your API call here using AF Networking 3.0
            
            NSLog(@"%@AccessToken",accessToken);
        } else {
            NSLog(@"API: Error: Access token is nil.");
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)Login_Button:(id)sender {
    
    [self Login_Function];
}



-(void)AlertView{
    FUIAlertView *alertView = [[FUIAlertView alloc] initWithTitle:@"Hello"
                                                          message:@"This is an alert view"
                                                         delegate:nil cancelButtonTitle:@"Dismiss"
                                                otherButtonTitles:@"Function_One",@"Function_Two", nil];
    alertView.titleLabel.textColor = [UIColor cloudsColor];
    alertView.titleLabel.font = [UIFont boldFlatFontOfSize:16];
    alertView.messageLabel.textColor = [UIColor cloudsColor];
    alertView.messageLabel.font = [UIFont flatFontOfSize:14];
    alertView.backgroundOverlay.backgroundColor = [[UIColor cloudsColor] colorWithAlphaComponent:0.8];
    alertView.alertContainer.backgroundColor = [UIColor midnightBlueColor];
    alertView.defaultButtonColor = [UIColor cloudsColor];
    alertView.defaultButtonShadowColor = [UIColor asbestosColor];
    alertView.defaultButtonFont = [UIFont boldFlatFontOfSize:16];
    alertView.defaultButtonTitleColor = [UIColor asbestosColor];
    alertView.delegate = self;
    [alertView show];

}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        NSLog(@"%@,Function_One",@"Running");
    }
    else if (buttonIndex == 2) {
        NSLog(@"%@,Function_Two",@"Running");
        //
    }
}

#pragma LoginMethod
//-->Login<--
-(void)Login_Function{
    
     [self AlertView];
   // BOOL signedIn = [[OAuth2Client sharedInstance] signedIn];
    
   // if (signedIn) {
       // [[OAuth2Client sharedInstance] signOut];
   // } else {
       // [[OAuth2Client sharedInstance] authenticateInViewController:self];
    //}

}
@end
