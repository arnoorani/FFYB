//
//  AddressViewController.h
//  FFYB
//
//  Created by Geniusu on 31/05/16.
//  Copyright © 2016 Geniusu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import <Parse/Parse.h>

@interface AddressViewController : UIViewController<CLLocationManagerDelegate>
{
    double eventLatatitude;
    double eventLongitude;
    
}
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UILabel *addresslabel;
@property (weak, nonatomic) IBOutlet UILabel *duarationlabel;

@property (nonatomic, strong) CLLocationManager *locationManager;

@end
