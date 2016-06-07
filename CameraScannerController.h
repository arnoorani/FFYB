//
//  CameraScannerController.h
//  FFYB
//
//  Created by Suraj Naik on 03/06/16.
//  Copyright © 2016 Geniusu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FlatUIKit.h>

@interface CameraScannerController : UIViewController
@property NSArray* AllData;

@property (weak, nonatomic) IBOutlet FUIButton *DiscoverButton;

@end
