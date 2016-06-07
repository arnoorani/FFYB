//
//  AppDelegate.m
//  FFYB
//
//  Created by Suraj Naik on 18/05/16.
//  Copyright © 2016 Geniusu. All rights reserved.
//

#import "AppDelegate.h"
#import "OAuth2Client.h"
#import <Parse/Parse.h>
#import "UIColor+FlatUI.h"
#import "ViewControllerSimple.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [Parse setApplicationId:PARSE_APPLICATION_ID
                  clientKey:PARSE_CLIENT_KEY];

    
   // [self createItemsWithIcons];
    
   
    
    
    
    [[UINavigationBar appearance] setTintColor:[UIColor greenSeaColor]]; // this will change the back button tint
    
    [[UINavigationBar appearance] setBarTintColor:[UIColor greenSeaColor]];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor greenSeaColor]}];
     [[UINavigationBar appearance] setTitleTextAttributes:@{NSFontAttributeName : [UIFont fontWithName:@"OpenSans-Semibold" size:21]}];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    NSDictionary *textTitleOptions = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], UITextAttributeTextColor, [UIColor whiteColor], UITextAttributeTextShadowColor, nil];
    [[UINavigationBar appearance] setTitleTextAttributes:textTitleOptions];
    
    
    UIApplicationShortcutItem *item = [launchOptions valueForKey:UIApplicationLaunchOptionsShortcutItemKey];
    if (item) {
        NSLog(@"We've launched from shortcut item: %@", item.localizedTitle);
    } else {
        NSLog(@"We've launched properly.");
    }
    
    
    
    return YES;
}
- (void)createItemsWithIcons {
    
    // create some system icons (doesn't work)
    //    UIApplicationShortcutIcon *loveIcon = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeLove];
    //    UIApplicationShortcutIcon *mailIcon = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeMail];
    //    UIApplicationShortcutIcon *prohibitIcon = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeProhibit];
    
    // icons with my own images
    UIApplicationShortcutIcon *icon1 = [UIApplicationShortcutIcon iconWithTemplateImageName:@"wd"];
    UIApplicationShortcutIcon *icon2 = [UIApplicationShortcutIcon iconWithTemplateImageName:@"wd"];
    UIApplicationShortcutIcon *icon3 = [UIApplicationShortcutIcon iconWithTemplateImageName:@"disc-white"];
    
    // create several (dynamic) shortcut items
    UIMutableApplicationShortcutItem *item1 = [[UIMutableApplicationShortcutItem alloc]initWithType:@"com.test.dynamic" localizedTitle:@"Dynamic Shortcut" localizedSubtitle:@"available after first launch" icon:icon1 userInfo:nil];
    UIMutableApplicationShortcutItem *item2 = [[UIMutableApplicationShortcutItem alloc]initWithType:@"com.test.deep1" localizedTitle:@"Deep Link 1" localizedSubtitle:@"Launch Nav Controller" icon:icon2 userInfo:nil];
    UIMutableApplicationShortcutItem *item3 = [[UIMutableApplicationShortcutItem alloc]initWithType:@"com.test.deep2" localizedTitle:@"Deep Link 2" localizedSubtitle:@"Launch 2nd Level" icon:icon3 userInfo:nil];
    
    // add all items to an array
    NSArray *items = @[item1, item2, item3];
    
    // add this array to the potentially existing static UIApplicationShortcutItems
    NSArray *existingItems = [UIApplication sharedApplication].shortcutItems;
    NSArray *updatedItems = [existingItems arrayByAddingObjectsFromArray:items];
    [UIApplication sharedApplication].shortcutItems = updatedItems;
    
}

- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler {
    
    // react to shortcut item selections
   
    
    //[self BarCodeAlertView];
    

    
    // have we launched Deep Link Level 1
    if ([shortcutItem.type isEqualToString:@"ffyb.ScanQrCode"]) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
        // and instantiate our navigation controller
        UINavigationController *controller = [storyboard instantiateViewControllerWithIdentifier:@"DeepNav"];
        
        // make it the key window
        self.window.rootViewController = controller;
        [self.window makeKeyAndVisible];
    }
    
    // have we launched Deep Link Level 2
    if ([shortcutItem.type isEqualToString:@"ffyb.MyTicket"]) {
     [self BarCodeAlertView];
    }
    
}
-(void)BarCodeAlertView{
    
    _PreviousScreen = [UIScreen mainScreen].brightness;
    
    [UIScreen mainScreen].brightness = 1;
    CustomIOSAlertView *alertView = [[CustomIOSAlertView alloc] init];
    
    // Add some custom content to the alert view
    [alertView setContainerView:[self createDemoView]];
    
    // Modify the parameters
    [alertView setButtonTitles:[NSMutableArray arrayWithObjects:@"Dismiss", nil]];
    [alertView setDelegate:self];
    
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    
    
    
    
    
    // You may use a Block, rather than a delegate.
    [alertView setOnButtonTouchUpInside:^(CustomIOSAlertView *alertView, int buttonIndex) {
        //NSLog(@"Block: Button at position %d is clicked on alertView %d.", buttonIndex, (int)[alertView tag]);
        [alertView close];
    }];
    
    [alertView setUseMotionEffects:true];
    
    // And launch the dialog
    [alertView show];
}

- (void)customIOS7dialogButtonTouchUpInside: (CustomIOSAlertView *)alertView clickedButtonAtIndex: (NSInteger)buttonIndex
{
    [UIScreen mainScreen].brightness = _PreviousScreen;
  
    [alertView close];
}
- (UIView *)createDemoView
{
    UIView *demoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 290, 290)];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 270, 270)];
    [imageView setImage:[UIImage imageNamed:@"QR_Code.png"]];
    [demoView addSubview:imageView];
    
    
    
    return demoView;
}


- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    [[OAuth2Client sharedInstance] retrieveCodeFromUrl:url];
   
    return NO;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
