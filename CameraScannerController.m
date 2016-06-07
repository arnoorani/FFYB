//
//  CameraScannerController.m
//  FFYB
//
//  Created by Suraj Naik on 03/06/16.
//  Copyright © 2016 Geniusu. All rights reserved.
//

#import "CameraScannerController.h"
#import "MTBBarcodeScanner.h"

#import "GlobalImports.pch"

@interface CameraScannerController ()
@property (nonatomic, weak) IBOutlet UIView *previewView;
@property (nonatomic, weak) IBOutlet UIButton *toggleScanningButton;
@property (nonatomic, weak) IBOutlet UILabel *instructions;
@property (nonatomic, weak) IBOutlet UIView *viewOfInterest;

@property (nonatomic, strong) MTBBarcodeScanner *scanner;
@property (nonatomic, strong) NSMutableDictionary *overlayViews;
@property (nonatomic, assign) BOOL didShowAlert;

@end

@implementation CameraScannerController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tabBarController.tabBar.hidden = YES;
    [MTBBarcodeScanner requestCameraPermissionWithSuccess:^(BOOL success) {
        if (success) {
            [self startScanning];
        } else {
            [self displayPermissionMissingAlert];
        }
    }];
    _DiscoverButton.buttonColor = [UIColor turquoiseColor];
    _DiscoverButton.shadowColor = [UIColor greenSeaColor];
    _DiscoverButton.shadowHeight = 3.0f;
    _DiscoverButton.cornerRadius = 6.0f;
    _DiscoverButton.titleLabel.font = [UIFont boldFlatFontOfSize:16];
    [_DiscoverButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
    [_DiscoverButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateHighlighted];
    [_DiscoverButton addTarget:self action:@selector(GoToMainViewController) forControlEvents:UIControlEventTouchUpInside];
   

}
-(void)GoToMainViewController{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillDisappear:(BOOL)animated {
    [self.scanner stopScanning];
    [super viewWillDisappear:animated];
}
-(void)viewWillAppear:(BOOL)animated{
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
}

#pragma mark - Scanner

- (MTBBarcodeScanner *)scanner {
    if (!_scanner) {
        _scanner = [[MTBBarcodeScanner alloc] initWithPreviewView:_previewView];
    }
    return _scanner;
}

#pragma mark - Overlay Views

- (NSMutableDictionary *)overlayViews {
    if (!_overlayViews) {
        _overlayViews = [[NSMutableDictionary alloc] init];
    }
    return _overlayViews;
}

#pragma mark - Scanning

- (void)startScanning {
    
    self.scanner.didStartScanningBlock = ^{
        NSLog(@"The scanner started scanning!");
    };
    
        
    [self.scanner startScanningWithResultBlock:^(NSArray *codes) {
        [self drawOverlaysOnCodes:codes];
    }];
    
    // Optionally set a rectangle of interest to scan codes. Only codes within this rect will be scanned.
    self.scanner.scanRect = self.viewOfInterest.frame;
    
    [self.toggleScanningButton setTitle:@"Stop Scanning" forState:UIControlStateNormal];
    self.toggleScanningButton.backgroundColor = [UIColor redColor];
}
-(void)CheckingifUserExistsInFav_function:(NSString*)FriendsID{
    NSString *savedValue = [[NSUserDefaults standardUserDefaults]
                            stringForKey:@"UserID"];
    
    // NSLog(@"%@", @"LOG");
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    indicator.frame = CGRectMake(0.0, 0.0, 10.0, 10.0);
    indicator.center = self.view.center;
    [self.view addSubview:indicator];
    [indicator bringSubviewToFront:self.view];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = TRUE;
    [indicator startAnimating];
    
    
    PFQuery *query = [PFQuery queryWithClassName:@"EventDetails"];
    [query whereKey:@"ObjectId" containsString:savedValue];
    //  [query orderByAscending:@"Day"];
    // [query whereKey:@"Day" containsString:Day];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            
          
            self.AllData = objects ;
            
            
           
            
          
            [indicator stopAnimating];
            
            
            
        }
        
        
    }];
    
   
    
}
-(void)AddtoFav_function:(NSString*)FriendID{
    
    
    
    
    NSString *savedValue = [[NSUserDefaults standardUserDefaults]
                            stringForKey:@"UserID"];
    PFQuery *query = [PFQuery queryWithClassName:@"UserDetails"];
    
    // Retrieve the object by id
    [query getObjectInBackgroundWithId:savedValue
                                 block:^(PFObject *gameScore, NSError *error) {
                                     // Now let's update it with some new data. In this case, only cheatMode and score
                                     // will get sent to the cloud. playerName hasn't changed.
                                     [  gameScore addObject:FriendID forKey:@"FavPeople"];                                     [gameScore saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                                         if (succeeded) {
                                             // [self popup_warning:@"You're Profile has been updated,Please Refresh Page"];
                                             //  [self gettingData];
                                             // [self popup_warning:@"See you there"];
                                             //  [self gettingData];
                                             [self PopUp_Alertview:@"Added to Favourites"];
                                         } else {
                                             [self PopUp_Alertview:@"Sorry unable to add to Favourites"];
                                             //[self popup_warning:@"Unable to RSVP to event please contact Admin Staff"];
                                             // [self popup_warning:@"Sorry Unbale to update the Profile"];
                                             // There was a problem, check error.description
                                         }
                                     }];                                    // [self gettingData];
                                 }];
    
}


- (void)drawOverlaysOnCodes:(NSArray *)codes {
    // Get all of the captured code strings
    NSMutableArray *codeStrings = [[NSMutableArray alloc] init];
    for (AVMetadataMachineReadableCodeObject *code in codes) {
        if (code.stringValue) {
            [codeStrings addObject:code.stringValue];
        }
    }
    
    // Remove any code overlays no longer on the screen
    for (NSString *code in self.overlayViews.allKeys) {
        if ([codeStrings indexOfObject:code] == NSNotFound) {
            // A code that was on the screen is no longer
            // in the list of captured codes, remove its overlay
            [self.overlayViews[code] removeFromSuperview];
            [self.overlayViews removeObjectForKey:code];
        }
    }
    
    for (AVMetadataMachineReadableCodeObject *code in codes) {
        UIView *view = nil;
         NSString *Text = @"User is allrady in Fav";
        NSString *codeString = code.stringValue;
        
        if (codeString) {
            if (self.overlayViews[codeString]) {
                // The overlay is already on the screen
                view = self.overlayViews[codeString];
                
                // Move it to the new location
                view.frame = code.bounds;
                
            } else {
                // First time seeing this code
                BOOL isValidCode = [self isValidCodeString:codeString];
                [self CheckingifUserExistsInFav_function:codeString];
                PFObject *Dates = [self.AllData objectAtIndex:0];
                
                if([[Dates valueForKey:@"Favpeople"]containsObject:codeString]){
                    UIView *overlayView = [self overlayForCodeString:Text
                                                              bounds:code.bounds
                                                               valid:isValidCode];
                    self.overlayViews[codeString] = overlayView;
                    
                    // Add the overlay to the preview view
                    [self.previewView addSubview:overlayView];

                }else{
                    
                    [self AddtoFav_function:codeString];
                    UIView *overlayView = [self overlayForCodeString:@"Adding.."
                                                              bounds:code.bounds
                                                               valid:isValidCode];
                    self.overlayViews[codeString] = overlayView;
                    
                    // Add the overlay to the preview view
                    [self.previewView addSubview:overlayView];

                }

                
                
                // Create an overlay
                
            }
        }
    }
}

- (BOOL)isValidCodeString:(NSString *)codeString {
    BOOL stringIsValid = ([codeString rangeOfString:@"Valid"].location != NSNotFound);
    return stringIsValid;
}

- (UIView *)overlayForCodeString:(NSString *)codeString bounds:(CGRect)bounds valid:(BOOL)valid {
    UIColor *viewColor = valid ? [UIColor greenColor] : [UIColor redColor];
    UIView *view = [[UIView alloc] initWithFrame:bounds];
    UILabel *label = [[UILabel alloc] initWithFrame:view.bounds];
    
    // Configure the view
    view.layer.borderWidth = 5.0;
    view.backgroundColor = [viewColor colorWithAlphaComponent:0.75];
    view.layer.borderColor = viewColor.CGColor;
    
    // Configure the label
    label.font = [UIFont boldSystemFontOfSize:12];
    label.text = codeString;
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.numberOfLines = 0;
    
    // Add constraints to label to improve text size?
    
    // Add the label to the view
    [view addSubview:label];
    
    return view;
}

- (void)stopScanning {
    [self.scanner stopScanning];
    
    [self.toggleScanningButton setTitle:@"Start Scanning" forState:UIControlStateNormal];
    self.toggleScanningButton.backgroundColor = self.view.tintColor;
    
    for (NSString *code in self.overlayViews.allKeys) {
        [self.overlayViews[code] removeFromSuperview];
    }
}

#pragma mark - Actions

- (IBAction)toggleScanningTapped:(id)sender {
    if ([self.scanner isScanning]) {
        [self stopScanning];
    } else {
        [MTBBarcodeScanner requestCameraPermissionWithSuccess:^(BOOL success) {
            if (success) {
                [self startScanning];
            } else {
                [self displayPermissionMissingAlert];
            }
        }];
    }
}

- (IBAction)switchCameraTapped:(id)sender {
    [self.scanner flipCamera];
}

- (void)backTapped {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Notifications

- (void)deviceOrientationDidChange:(NSNotification *)notification {
    self.scanner.scanRect = self.viewOfInterest.frame;
}

#pragma mark - Helper Methods

- (void)displayPermissionMissingAlert {
    NSString *message = nil;
    if ([MTBBarcodeScanner scanningIsProhibited]) {
        message = @"This app does not have permission to use the camera.";
    } else if (![MTBBarcodeScanner cameraIsPresent]) {
        message = @"This device does not have a camera.";
    } else {
        message = @"An unknown error occurred.";
    }
    [self PopUp_Alertview:message];
}
-(void)PopUp_Alertview:(NSString*)Message{
    SCLAlertView *alert = [[SCLAlertView alloc] init];
    
    alert.backgroundType = Blur;
    alert.showAnimationType = FadeIn;
    [alert showNotice:self title:@"Hello" subTitle:Message closeButtonTitle:@"Dimiss" duration:0.0f];
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
